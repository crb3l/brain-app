import 'package:bigbrain/models/category_model.dart';
import 'package:bigbrain/reusable_widgets/reusable_widgets.dart';
//import 'package:bigbrain/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final searchController = TextEditingController();
  List<CategoryModel> categories = [];

  void _getCategories() {
    categories = CategoryModel.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    _getCategories();
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        // pot sa o fac si listview in loc de column, depinde de cum voi vrea eu sa imi aranjez in pagina lucrurile
        //pana la urma asta am si facut
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _welcomeBox(context),
          const SizedBox(
            height: 20,
          ),
          _categoriesSection()
        ],
      ),
    );
  }

  Column _categoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Text(
            'Category',
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          height: 250,
          child: ListView.separated(
            itemCount: categories.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 20, right: 20),
            separatorBuilder: (context, index) => const SizedBox(
              width: 30,
            ),
            itemBuilder: (context, index) {
              return Container(
                  width: 150,
                  decoration: BoxDecoration(
                    color: categories[index].boxColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 75,
                        height: 75,
                        decoration: const BoxDecoration(
                            color: Colors.white54, shape: BoxShape.circle),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: SvgPicture.asset(categories[index].iconPath),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        categories[index].name,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontSize: 14),
                      )
                    ],
                  ));
            },
          ),
        ),
      ],
    );
  }

  Container _welcomeBox(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 5),
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
          const SizedBox(height: 20),
          _notificationsIcon(),
          _welcomeText(),
          _searchField(context),
        ],
      ),
    );
  }

  Row _notificationsIcon() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(Icons.notifications, size: 30, color: Colors.white),
      ],
    );
  }

  Padding _welcomeText() {
    return const Padding(
      padding: EdgeInsets.only(top: 5, bottom: 20),
      child: Text(
        "Oy, dude!",
        style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
            wordSpacing: 2,
            color: Colors.white),
      ),
    );
  }

  Container _searchField(BuildContext context) {
    return Container(
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
            "Search here...", Icons.search, searchController));
  }
}

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