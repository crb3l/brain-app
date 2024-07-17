import 'package:bigbrain/screens/home_screen.dart';
import 'package:bigbrain/screens/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bigbrain/reusable_widgets/reusable_widgets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _passwordTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  // TextEditingController _usernameTextController = TextEditingController();
  final _vpasswordTextController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String errorMessage = '';
  bool isLoading = false;

  void _clearTextFields() {
    _emailTextController.clear();
    _passwordTextController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Form(
        key: _key,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 80, 20, 0),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  mailSignUpTextFormField("Enter email", Icons.person_outline,
                      _emailTextController),
                  const SizedBox(
                    height: 10,
                  ),
                  passwordSignUpTextFormField("Enter password",
                      Icons.lock_outline, _passwordTextController),
                  const SizedBox(
                    height: 10,
                  ),
                  passwordConfirmTextFormField(
                      "Confirm password",
                      Icons.lock_outline,
                      _passwordTextController,
                      _vpasswordTextController,
                      context),
                  const SizedBox(height: 5),
                  Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Visibility(
                          visible: errorMessage.isNotEmpty,
                          child: Text(errorMessage,
                              style: const TextStyle(color: Colors.red),
                              textAlign: TextAlign.left))),
                  const SizedBox(
                    height: 10,
                  ),
                  signInSignUpButton(context, false, () async {
                    if (_key.currentState!.validate()) {
                      try {
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: _emailTextController.text,
                                password: _passwordTextController.text)
                            .then((value) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        });
                        setState(() {
                          isLoading = true;
                          errorMessage = '';
                        });
                        _clearTextFields();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()),
                            (Route<dynamic> route) => false);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'invalid-email') {
                          setState(() {
                            isLoading = false;
                            errorMessage =
                                'The email is not valid. Please check and try again.';
                          });
                        } else if (e.code == 'email-already-in-use') {
                          setState(() {
                            isLoading = false;
                            errorMessage =
                                'The email is already in use. Please use a different email address.';
                          });
                        } else {
                          setState(() {
                            isLoading = false;
                            errorMessage =
                                'Something went wrong. Please try again.';
                          });
                        }
                      } catch (e) {
                        setState(() {
                          isLoading = false;
                          errorMessage =
                              'Something went wrong. Please try again.';
                        });
                      }
                    }
                  }, isLoading),
                  signInOption()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row signInOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have an account?",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignInScreen()));
          },
          child: const Text(
            " Log in",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  TextFormField passwordSignUpTextFormField(
      String text, IconData icon, TextEditingController controller) {
    return TextFormField(
        controller: controller,
        validator: validateSignUpPassword,
        obscureText: true,
        cursorColor: Colors.white,
        style: TextStyle(color: Colors.white.withOpacity(0.9)),
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.white70,
          ),
          labelText: text,
          labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
          filled: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          fillColor: Colors.black.withOpacity(0.2),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(
                  width: 1.5, style: BorderStyle.solid, color: Colors.grey)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(
                width: 1.5,
                style: BorderStyle.solid,
                color: Colors.red,
              )),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(
                width: 1.5,
                style: BorderStyle.solid,
                color: Colors.red,
              )),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(
                width: 1.5,
                style: BorderStyle.solid,
                color: Colors.black26,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide(
                width: 1.5,
                style: BorderStyle.solid,
                color: Theme.of(context).colorScheme.secondary,
              )),
        ),
        keyboardType: TextInputType.visiblePassword);
  }

  TextFormField mailSignUpTextFormField(
      String text, IconData icon, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      validator: validateSignUpEmail,
      obscureText: false,
      enableSuggestions: true,
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white.withOpacity(0.9)),
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: Colors.white70,
        ),
        labelText: text,
        labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: Colors.black.withOpacity(0.2),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(
                width: 1.5, style: BorderStyle.solid, color: Colors.grey)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(
              width: 1.5,
              style: BorderStyle.solid,
              color: Colors.red,
            )),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(
              width: 1.5,
              style: BorderStyle.solid,
              color: Colors.red,
            )),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(
              width: 1.5,
              style: BorderStyle.solid,
              color: Colors.black26,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(
              width: 1.5,
              style: BorderStyle.solid,
              color: Theme.of(context).colorScheme.secondary,
            )),
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }

  String? validateSignUpEmail(String? formEmail) {
    if (formEmail == null || formEmail.isEmpty) {
      isLoading = false;
      return "Email address is required.";
    }
    String pattern = r'\w+a\w+\.\w+';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(formEmail)) {
      isLoading = false;
      return 'Invalid email address format.';
    }
    return null;
  }

  String? validateSignUpPassword(String? formPassword) {
    if (formPassword == null || formPassword.isEmpty) {
      isLoading = false;
      return "Password is required.";
    }
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(formPassword)) {
      return '''
      Password must be at least 8 characters,
      include an uppercase letter, number and symbol.
      ''';
    }
    return null;
  }

  Container signInSignUpButton(
      BuildContext context, bool isLogin, Function onTap, bool isLoading) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(90),
          border: Border.all(
              width: 2, color: Theme.of(context).colorScheme.secondary)),
      child: ElevatedButton(
        onPressed: () {
          onTap();
        },
        style: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.pressed)) {
                return Colors.black26;
              }
              return Colors.white;
            }),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)))),
        child: isLoading
            ? const CircularProgressIndicator(color: Colors.black)
            : Text(
                isLogin ? 'LOG IN' : 'SIGN UP',
                style: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
      ),
    );
  }
}
