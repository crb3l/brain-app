import 'package:bigbrain/screens/home_screen.dart';
import 'package:bigbrain/screens/signup_screen.dart';
import 'package:bigbrain/utils/color_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bigbrain/reusable_widgets/reusable_widgets.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          hexStringToColor("F0F0F2"),
          // hexStringToColor("FFFFFF"),
          hexStringToColor("FFD301")
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
                logoWidget("assets/images/brain.png"),
                SizedBox(
                  height: 30,
                ),
                mailTextFormField("Enter username/email", Icons.person_outline,
                    _emailTextController),
                SizedBox(
                  height: 20,
                ),
                passwordTextFormField("Enter password", Icons.lock_outline,
                    _passwordTextController),
                SizedBox(
                  height: 20,
                ),
                signInSignUpButton(context, true, () {
                  FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text)
                      .then((value) {
                    Navigator.push((context),
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  }).onError((error, stackTrace) {
                    print(
                        "Error ${error.toString()}"); //in cazul erorilor legate de emial gresit/parola gresita, firebase va da o eroare generica legata de credentialele auth pentru a nu leakui iinformatii legate de existenta adreseii de email
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: (Text("Error! ${error.toString()}") ==
                                  Text(
                                      "Error [firebase_auth/invalid-credential] The supplied auth credential is incorrect, malformed or has expired."))
                              ? Text("E-mail or password are incorrect!")
                              : Text("Error! ${error.toString()}"),
                          behavior: SnackBarBehavior.floating),
                    );
                  });
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
                MaterialPageRoute(builder: (context) => SignUpScreen()));
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
