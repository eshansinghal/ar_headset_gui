import 'package:ar_headset_gui/AppScreen.dart';
import 'package:ar_headset_gui/main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  bool appsUp;
  Home({required this.appsUp});

  @override
  State<Home> createState() => HomeState(appsUp);
}

class HomeState extends State<Home> {
  bool appsUp;
  HomeState(this.appsUp);

  DateTime now = DateTime.now();

  late var _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = PageController(
      initialPage: appsUp == true ? 1 : 0,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 1000,
        height: 500,
        color: Colors.black,
        child: Column(
          children: <Widget>[
            Container(
              width: 800,
              height: 390,
              color: Colors.black,
              child: PageView(
                scrollDirection: Axis.vertical,
                controller: _controller,
                children: <Widget>[
                  Container(
                    width: 800,
                    height: 390,
                    color: Colors.black,
                  ),
                  AppScreen(),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                const SizedBox(
                  width: 800,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Column(
                    children: <Widget>[
                      Text(
                        DateFormat('kk:mm').format(DateTime.now()),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                        ),
                      ),
                      Text(
                        DateFormat.MMMMEEEEd().format(DateTime.now()),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
