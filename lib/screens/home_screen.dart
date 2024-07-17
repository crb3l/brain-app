import 'package:bigbrain/models/category_model.dart';
import 'package:bigbrain/screens/signin_screen.dart';
import 'package:bigbrain/screens/categories/memory_screen.dart';
import 'package:bigbrain/screens/categories/sharpness/sharpness.dart';
import 'package:bigbrain/screens/categories/attention/attention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchController = TextEditingController();

  List<CategoryModel> categories = [];

  void _getCategories() {
    categories = CategoryModel.getCategories();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final Map<int, Widget Function(BuildContext)> screenMap = {
    0: (context) => const AttentionScreen(),
    1: (context) => const MemoryScreen(),
    2: (context) => const SharpnessScreen()
  };

  @override
  Widget build(BuildContext context) {
    _getCategories();
    return PopScope(
      canPop: true,
      onPopInvoked: (bool didPop) async {
        if (didPop) return;
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        // bottomNavigationBar: NavigationBar(),
        drawer: Drawer(
            child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration:
                  BoxDecoration(color: Theme.of(context).colorScheme.secondary),
              child: const Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
            ...screenMap.entries.map((entry) {
              int index = entry.key;
              Widget Function(BuildContext) builder = entry.value;
              return Container(
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border:
                      Border.all(color: categories[index].boxColor, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListTile(
                  title: Text(categories[index].name),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: builder),
                    );
                  },
                ),
              );
            }),
          ],
        )),
        body: Column(
          children: [
            _welcomeBox(context),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: _categoriesSection(context),
            )
          ],
        ),
      ),
    );
  }

  Column _categoriesSection(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0),
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
                border: Border(
              bottom: BorderSide(color: Colors.black, width: 3),
            )),
            child: const Text(
              'Category',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Flexible(
          child: ListView.separated(
            itemCount: categories.length,
            scrollDirection: Axis.vertical,
            padding:
                const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
            separatorBuilder: (context, index) =>
                const SizedBox(width: 90, height: 30),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: screenMap[index]!,
                    ),
                  );
                },
                child: Container(
                    width: double.infinity,
                    height: 220,
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
                              color: Colors.white, shape: BoxShape.circle),
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
                              color: Colors.white,
                              fontSize: 14),
                        )
                      ],
                    )),
              );
            },
          ),
        ),
      ],
    );
  }

  Container _welcomeBox(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        border: const Border(),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            _drawerIcon(context),
            const Spacer(),
            _exitIcon(context)
          ]),
          const SizedBox(height: 20),
          _welcomeText()
          // _searchField(context),
        ],
      ),
    );
  }

  GestureDetector _exitIcon(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FirebaseAuth.instance.signOut().then((vasclue) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const SignInScreen()));
        });
      },

      // mainAxisAlignment: MainAxisAlignment.end,
      child: const Icon(Icons.exit_to_app, size: 30, color: Colors.white),
    );
  }

  GestureDetector _drawerIcon(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _scaffoldKey.currentState?.openDrawer();
      },
      child: const Icon(Icons.menu, size: 30, color: Colors.white),
    );
  }

  Padding _welcomeText() {
    return const Padding(
      padding: EdgeInsets.only(top: 5, bottom: 20),
      child: Text(
        "Welcome to BrainApp.",
        style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
            wordSpacing: 0,
            color: Colors.white),
      ),
    );
  }
}
