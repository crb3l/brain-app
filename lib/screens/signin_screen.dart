import 'package:bigbrain/screens/home_screen.dart';
import 'package:bigbrain/screens/signup_screen.dart';
import 'package:bigbrain/screens/forgot_screen.dart';
// import 'package:bigbrain/reusable_widgets/reusable_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _passwordTextController = TextEditingController();
  final _emailTextController = TextEditingController();
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
      body: Form(
        key: _key,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  20, MediaQuery.of(context).size.height * 0.2, 20, 0),
              child: Column(
                children: <Widget>[
                  logoWidget("assets/images/brain.png"),
                  const SizedBox(
                    height: 30,
                  ),
                  mailSignInTextFormField("Enter email", Icons.person_outline,
                      _emailTextController),
                  const SizedBox(
                    height: 15,
                  ),
                  passwordSignInTextFormField("Enter password",
                      Icons.lock_outline, _passwordTextController),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Center(
                        child: Text(
                            style: const TextStyle(color: Colors.red),
                            errorMessage)),
                  ),
                  signInSignUpButton(context, true, () async {
                    setState(() {
                      isLoading = true;
                      errorMessage = '';
                    });
                    if (_key.currentState!.validate()) {
                      try {
                        await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: _emailTextController.text,
                                password: _passwordTextController.text)
                            .then((value) {
                          Navigator.push(
                              (context),
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        });
                        _clearTextFields();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()),
                            (Route<dynamic> route) => false);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'auth/user-not-found') {
                          errorMessage =
                              "No user with the provided email address.";
                        } else if (e.code == 'invalid-credential') {
                          setState(() {
                            isLoading = false;
                            errorMessage =
                                'The email or password are invalid. Please check and try again.';
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
                  signUpOption(),
                  forgotPasswordOption()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account?",
            style: TextStyle(color: Colors.black)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignUpScreen()));
          },
          child: const Text(
            " Sign up",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Row forgotPasswordOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Forgot your password?",
            style: TextStyle(color: Colors.black)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ForgotScreen()));
          },
          child: const Text(
            " Recover it",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  TextFormField passwordSignInTextFormField(
      String text, IconData icon, TextEditingController controller) {
    return TextFormField(
        controller: controller,
        validator: validateSignInPassword,
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

  TextFormField mailSignInTextFormField(
      String text, IconData icon, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      validator: validateSignInEmail,
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

  String? validateSignInEmail(String? formEmail) {
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

  String? validateSignInPassword(String? formPassword) {
    if (formPassword == null || formPassword.isEmpty) {
      isLoading = false;
      return "Password is required.";
    }
    return null;
  }
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
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
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

Image logoWidget(String imageName) {
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    width: 240,
    height: 240,
    color: Colors.black,
  );
}
