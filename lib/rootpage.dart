import 'package:flutter/material.dart';
import 'package:restaurantapp/myaccountpage.dart';
import 'package:restaurantapp/tablespage.dart';

class RootPage extends StatefulWidget {
  const RootPage({
    super.key,
  });

  @override
  State<RootPage> createState() => _RootPageState();
}

var currentIndex = 0;

class _RootPageState extends State<RootPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        if (currentIndex == 0) {
          return const TablesPage();
        } else {
          return MyAccountPage(onSave: () {
            setState(() {
              currentIndex = 0;
            });
          });
        }
      }),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (newIndex) {
          setState(() {
            currentIndex = newIndex;
            print(newIndex);
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Tables",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "My account",
          )
        ],
      ),
    );
  }
}
