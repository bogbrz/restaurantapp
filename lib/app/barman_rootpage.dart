import 'package:flutter/material.dart';

import 'package:restaurantapp/app/features/bar_page/pages/barman_account_page.dart';
import 'package:restaurantapp/app/features/bar_page/pages/barman_page.dart';
//a

class BarmanHomePage extends StatefulWidget {
  const BarmanHomePage({
    super.key,
  });

  @override
  State<BarmanHomePage> createState() => _RootPageState();
}

var currentIndex = 0;

class _RootPageState extends State<BarmanHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        if (currentIndex == 0) {
          return const BarmanPage();
        }
        return const BarmanAccountPage();
      }),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            border: BorderDirectional(
                top: BorderSide(width: 4, color: Colors.black))),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (newIndex) {
            setState(() {
              currentIndex = newIndex;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: "Orders",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Account",
            ),
          ],
        ),
      ),
    );
  }
}
