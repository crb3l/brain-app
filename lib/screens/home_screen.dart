import 'package:bigbrain/reusable_widgets/reusable_widgets.dart';
import 'package:bigbrain/screens/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bigbrain/reusable_widgets/reusable_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchController = TextEditingController();
  @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       body: Center(
  //     child: ElevatedButton(
  //       child: const Text("Logout"),
  //       onPressed: () {
  //         FirebaseAuth.instance.signOut().then((vasclue) {
  //           print("Signed Out");
  //           Navigator.push(context,
  //               MaterialPageRoute(builder: (context) => const SignInScreen()));
  //         });
  //       },
  //     ),
  //   ));
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
            decoration: const BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.notifications, size: 30, color: Colors.white),
                  ],
                ),
                // const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 20),
                  child: Text(
                    "Oy, cunt!",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                        wordSpacing: 2,
                        color: Colors.white),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 5, bottom: 20),
                    width: MediaQuery.of(context).size.width,
                    height: 55,
                    // decoration: const BoxDecoration(
                    //   color: Colors.white,
                    //   borderRadius: BorderRadius.all(
                    //     Radius.circular(20),
                    //   ),
                    // ),
                    child: sampleTextFormField(
                        "Search here...", Icons.search, searchController)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
