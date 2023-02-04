import 'package:ar_headset_gui/AppScreen.dart';
import 'package:ar_headset_gui/Home.dart';
import 'package:ar_headset_gui/Phone.dart';
import 'package:flutter/material.dart';

class HomeButton extends StatefulWidget {
  @override
  HomeButtonState createState() => HomeButtonState();
}

class HomeButtonState extends State<HomeButton> {
    var hovering = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      color: Colors.black,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
            side: BorderSide(
              color: Colors.white,
              width: hovering == true ? 4.0 : 1.0,
            ),
          ),
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home(appsUp: true,)));
        },
        onHover: (hover) {
          setState(() {
            hovering = hover;
          });
        },
        child: const Icon(
          Icons.home_outlined,
          size: 20.0,
          color: Colors.white,
        ),
      ),
    );
  }
}