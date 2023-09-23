import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:restaurantapp/features/Table/cubit/tablepage_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TableWidget extends StatelessWidget {
  const TableWidget({
    Key? key,
    required this.tableNumber,
  }) : super(key: key);
  final String tableNumber;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
          ),
          color: Colors.orange,
        ),
        child: Text(tableNumber),
      ),
    );
  }
}
