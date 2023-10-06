import 'package:flutter/material.dart';
import 'package:restaurantapp/app/features/tables_page_content/pages/reciptpage/recipt_tablepage.dart';

import 'package:restaurantapp/app/features/tables_page_content/pages/tablecontentpage/tables_screenpage.dart';
//a

class TableHomePage extends StatefulWidget {
  const TableHomePage({
    required this.tableModel,
    super.key,
  });
  final String tableModel;

  @override
  State<TableHomePage> createState() => _RootPageState();
}

var currentIndex = 0;

class _RootPageState extends State<TableHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        if (currentIndex == 0) {
          return TableScreenPage(
            tableModel: widget.tableModel,
          );
        }
        return ReciptTablePage(
          tableModel: widget.tableModel,
        );
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
            icon: Icon(Icons.book),
            label: "Receipt",
          ),
        ],
      ),
    );
  }
}
