import 'package:bigbrain/screens/home_screen.dart';
import 'package:bigbrain/screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bigbrain/reusable_widgets/reusable_widgets.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _passwordTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  String errorMessage = '';

  void _clearTextFields() {
    _emailTextController.clear();
    _passwordTextController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.purple,
        // decoration: BoxDecoration(
        //     gradient: LinearGradient(colors: [
        //   hexStringToColor("F0F0F2"),
        //   // hexStringToColor("FFFFFF"),
        //   hexStringToColor("FFD301")
        // ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
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
                mailTextFormField(
                    "Enter email", Icons.person_outline, _emailTextController),
                const SizedBox(
                  height: 15,
                ),
                passwordTextFormField("Enter password", Icons.lock_outline,
                    _passwordTextController),
                const SizedBox(
                  height: 2,
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                    child: Visibility(
                        visible: errorMessage.isNotEmpty,
                        child: Text(errorMessage,
                            style: const TextStyle(color: Colors.red),
                            textAlign: TextAlign.left))),
                const SizedBox(
                  height: 10,
                ),
                //TODO password and email
                signInSignUpButton(context, true, () async {
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
                    setState(() {
                      errorMessage = '';
                    });

                    _clearTextFields();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                        (Route<dynamic> route) => false);
                  } on FirebaseAuthException catch (error) {
                    setState(() {
                      errorMessage = error.message!;
                      if (errorMessage ==
                          "The supplied auth credential is incorrect, malformed or has expired.") {
                        errorMessage = "Incorrect email or password.";
                      }
                    });
                  }
                  // .onError((error, stackTrace) {
                  //   print(
                  //       "Error ${error.toString()}"); //in cazul erorilor legate de emial gresit/parola gresita, firebase va da o eroare generica legata de credentialele auth pentru a nu leakui iinformatii legate de existenta adreseii de email
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     SnackBar(
                  //         content: (Text("Error! ${error.toString()}") ==
                  //                 Text(
                  //                     "Error [firebase_auth/invalid-credential] The supplied auth credential is incorrect, malformed or has expired."))
                  //             ? Text("E-mail or password are incorrect!")
                  //             : Text("Error! ${error.toString()}"),
                  //         behavior: SnackBarBehavior.floating),
                  //   );
                  // })
                }),
                signUpOption()
              ],
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
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignUpScreen()));
          },
          child: const Text(
            " Sign up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
