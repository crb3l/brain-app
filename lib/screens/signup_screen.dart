import 'package:bigbrain/screens/home_screen.dart';
import 'package:bigbrain/screens/signin_screen.dart';
import 'package:bigbrain/utils/color_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bigbrain/reusable_widgets/reusable_widgets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  // TextEditingController _usernameTextController = TextEditingController();
  TextEditingController _vpasswordTextController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String errorMessage = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // title: const Text(
        //   "Sign up",
        //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        // ),
      ),
      body: Form(
        key: _key,
        child: Container(
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
              padding: EdgeInsets.fromLTRB(20, 80, 20, 0),
              child: Column(
                children: <Widget>[
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // reusableTextFormField("Enter username", Icons.person_outline,
                  //     false, _usernameTextController),
                  mailTextFormField("Enter e-mail", Icons.email_outlined,
                      _emailTextController),
                  Center(
                    child: Visibility(
                        visible: errorMessage.isNotEmpty,
                        child: Text(errorMessage,
                            style: TextStyle(color: Colors.red))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  passwordTextFormField("Choose password", Icons.lock_outline,
                      _passwordTextController),
                  SizedBox(
                    height: 10,
                  ),
                  passwordConfirmTextFormField(
                      "Confirm password",
                      Icons.lock_outline,
                      _passwordTextController,
                      _vpasswordTextController),
                  SizedBox(
                    height: 20,
                  ),
                  signInSignUpButton(context, false, () async {
                    if (_key.currentState!.validate()) {
                      try {
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: _emailTextController.text,
                                password: _passwordTextController.text)
                            .then((value) {
                          print("Created New Account");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        });
                        errorMessage = '';
                      } on FirebaseAuthException catch (error) {
                        errorMessage = error.message!;
                      }
                      // .onError((error, stackTrace) {
                      //   print("Error ${error.toString()}");
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     SnackBar(
                      //         content: Text("Error ${error.toString()}"),
                      //         behavior: SnackBarBehavior.floating),
                      //   );
                      // })
                      ;
                    }
                  }),
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
                MaterialPageRoute(builder: (context) => SignInScreen()));
          },
          child: const Text(
            " Log in",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
