import 'package:bigbrain/screens/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.3),
        elevation: 0,
      ),
      body: Form(
        key: _key,
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 80, 20, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                          "Please enter your email to reset your password.",
                          style: TextStyle(color: Colors.black)),
                      const SizedBox(
                        height: 10,
                      ),
                      mailForgotTextFormField("Enter email",
                          Icons.person_outline, _emailTextController),
                      const SizedBox(height: 5),
                      Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Visibility(
                              visible: errorMessage.isNotEmpty,
                              child: Text(errorMessage,
                                  style: const TextStyle(color: Colors.red),
                                  textAlign: TextAlign.left))),
                      const SizedBox(height: 10),
                      forgotButton(context, () async {
                        if (_key.currentState!.validate()) {
                          try {
                            await FirebaseAuth.instance
                                .sendPasswordResetEmail(
                              email: _emailTextController.text.trim(),
                            )
                                .then((value) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignInScreen()));
                            });
                            setState(() {
                              isLoading = true;
                              errorMessage = '';
                            });
                            _clearTextFields();
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignInScreen()),
                                (Route<dynamic> route) => false);
                          } on FirebaseAuthException catch (e) {
                            //TODO fix errors
                            if (e.code.toString() == 'invalid-email') {
                              setState(() {
                                isLoading = false;
                                errorMessage =
                                    'The email is not valid. Please check and try again.';
                              });
                            }
                            if (e.code.toString() == 'user-not-found') {
                              setState(() {
                                isLoading = false;
                                errorMessage =
                                    'There is no account associated with this email.';
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
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }

  TextFormField mailForgotTextFormField(
      String text, IconData icon, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      validator: validateForgotEmail,
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

  String? validateForgotEmail(String? formEmail) {
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

  String? validateForgotPassword(String? formPassword) {
    if (formPassword == null || formPassword.isEmpty) {
      isLoading = false;
      return "Password is required.";
    }
    return null;
  }

  Container forgotButton(BuildContext context, Function onTap, bool isLoading) {
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
        child: const Text(
          "Send email",
          style: TextStyle(
              color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
}
