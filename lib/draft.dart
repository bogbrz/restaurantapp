//  //  Padding(
//                                 padding: const EdgeInsets.only(left: 10),
//                                 child: InkWell(
//                                   onTap: () {
//                                     setState(() {
//                                       currentValue++;
//                                     });

//                                     print(currentValue.toString());
//                                   },
//                                   child: Container(
//                                     color: Colors.red,
//                                     height: 50,
//                                     width: 50,
//                                     alignment: Alignment.center,
//                                     child: const Text(
//                                       "+",
//                                       style: TextStyle(fontSize: 30),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 10),
//                                 child: InkWell(
//                                   onTap: () {
//                                     setState(() {
//                                       currentValue == 0
//                                           ? 0
//                                           : currentValue = currentValue - 1;
//                                     });
//                                   },
//                                   child: Container(
//                                     color: Colors.red,
//                                     height: 50,
//                                     width: 50,
//                                     alignment: Alignment.center,
//                                     child: const Text(
//                                       "-",
//                                       style: TextStyle(fontSize: 30),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 10),
//                                 child: Container(
//                                   color: Colors.green,
//                                   height: 50,
//                                   width: 60,
//                                   alignment: Alignment.center,
//                                   child: Text(
//                                     currentValue.toString(),
//                                     style: const TextStyle(fontSize: 30),
//                                   ),
//                                 ),
//                               ),
  //  Column(
  //                 children: [
  //                   ElevatedButton(
  //                       onPressed: () {
  //                         FirebaseFirestore.instance.collection('order').add({
  //                           'tablenumber': widget.tableModel,
  //                           'quantity': currentValue,
  //                           'drink': ''
  //                         });
  //                       },
  //                       child: const Text("Order")),
  //                 ],
  //               )