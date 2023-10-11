import 'package:flutter/material.dart';

class BarmanPage extends StatefulWidget {
  const BarmanPage({super.key});

  @override
  State<BarmanPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<BarmanPage> {
  @override
  Widget build(BuildContext context) {
    return const OrdersPage();
  }
}

class OrdersPage extends StatelessWidget {
  const OrdersPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Incoming orders'),
        backgroundColor: Colors.orange,
      ),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.only(left: 50, right: 50, top: 20),
          child: Container(
            decoration: const BoxDecoration(color: Colors.orange),
            child: Column(
              children: [
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 8, top: 8, right: 8),
                      child: Text("NUMER STOLIKA"),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, bottom: 8, top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color: Colors.black,
                              ),
                            ),
                            child: const Text('Nazwa drinka'),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color: Colors.black,
                              ),
                            ),
                            child: const Text("ilość"),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
