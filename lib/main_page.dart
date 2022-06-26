import 'package:example_api/artikel_page.dart';
import 'package:example_api/home_page.dart';
import 'package:example_api/profile_page.dart';
import 'package:example_api/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String? token;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (mounted) {
      setState(() {
        getInit();
      });
    }
  }

  getInit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
    });
    await Provider.of<AuthProvider>(context, listen: false).getData();
  }

  int currentIndex = 0;
  Widget customButtomNav() {
    return ClipRRect(
      child: BottomAppBar(
        clipBehavior: Clip.antiAlias,
        child: BottomNavigationBar(
            backgroundColor: Colors.white,
            currentIndex: currentIndex,
            onTap: (value) {
              setState(() {
                print(value);
                currentIndex = value;
              });
            },
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.lightGreen,
            unselectedItemColor: Colors.grey,
            items: [
              BottomNavigationBarItem(
                  icon: Container(
                    padding: const EdgeInsets.only(top: 5),
                    child: const Icon(Icons.home, size: 27),
                  ),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: Container(
                    padding: const EdgeInsets.only(top: 5),
                    child: const Icon(Icons.book, size: 27),
                  ),
                  label: 'Artikel'),
              BottomNavigationBarItem(
                  icon: Container(
                    padding: const EdgeInsets.only(top: 5),
                    child: const Icon(Icons.person, size: 27),
                  ),
                  label: 'Profile'),
            ]),
      ),
    );
  }

  Widget body() {
    switch (currentIndex) {
      case 0:
        return const HomePage();
      case 1:
        return const ArtikelPage();
      case 2:
        return const ProfilePage();
      default:
        return const HomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime timeBackPressed = DateTime.now();
    return WillPopScope(
      onWillPop: () async {
        final difference = DateTime.now().difference(timeBackPressed);
        final isExitWarning = difference >= const Duration(seconds: 2);
        timeBackPressed = DateTime.now();
        if (isExitWarning) {
          String message = 'Press back again to exit';
          Fluttertoast.showToast(msg: message, fontSize: 18);
          return false; // false will do nothing when back press
        } else {
          // handleLogout();
          Fluttertoast.cancel();
          return true; // true will exit the app
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: customButtomNav(),
        body: body(),
      ),
    );
  }
}
