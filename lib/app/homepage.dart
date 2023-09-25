import 'package:flutter/material.dart';
import 'package:restaurantapp/app/features/my_account_page/myaccountpage.dart';
import 'package:restaurantapp/app/features/tables_page_content/pages/tablespage.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _RootPageState();
}

var currentIndex = 0;

class _RootPageState extends State<HomePage> {
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