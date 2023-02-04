import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Phone.dart';
import 'Messages.dart';
import 'Maps.dart';
import 'Camera.dart';
import 'Web.dart';


class AppScreen extends StatefulWidget {
  @override
  State<AppScreen> createState() => AppScreenState();
}

class AppScreenState extends State<AppScreen> {

  int hoverIndex = -1;

  List<Widget> createAppButtons() {
    List<String> titles = ['Phone', 'Messages', 'Maps', 'Camera', 'Web'];
    // images = []
    List<Widget> appLocs = [Phone(), Messages(), Maps(), Camera(), Web()];
    List<Widget> apps = [];

    for (int i = 0; i < titles.length; i++) {
      apps.add(
        Container(
          width: 128,
          height: 128,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
              width: hoverIndex == i ? 3 : 0,
            )
          ),
          child: ElevatedButton(
            child: Text(
              titles[i],
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            onHover: (bool hover) {
              setState(() {
                if (hover) {
                  hoverIndex = i;
                }
                else if (hoverIndex == i) {
                  hoverIndex = -1;
                }
              });
            },
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => appLocs[i]));
            },
          )
        ),
      );
    }
    return apps;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        width: 1000,
        height: 400,
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Wrap(
          spacing: 20,
          children: createAppButtons(),
        ),
      ),
    );
  }
}