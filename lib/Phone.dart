import 'package:ar_headset_gui/Structs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'Utilities.dart';

class Phone extends StatefulWidget {
  @override
  State<Phone> createState() => PhoneState();
}

class PhoneState extends State<Phone> {
  String number = '';
  var hoverNum = -1;

  var addHover = false;
  var cancelConHover = false;
  var addConHover = false;
  var newContact = Contact('', '', '', '', '');

  final _controller = PageController(
    initialPage: 0,
  );

  List<Widget> keypad() {
    List<Widget> buttons = [];
    for (int i = 1; i < 13; i++) {
      buttons.add(
        Container(
          margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          width: 50,
          height: 50,
          color: Colors.black,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              shape: (i == 12 || i == 10)
                  ? null
                  : RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      side: BorderSide(
                        color: Colors.white,
                        width: hoverNum == i ? 4 : 1,
                      ),
                    ),
            ),
            onPressed: () {
              if (i < 10) {
                number += i.toString();
              } else if (i == 10) {
                number += 0.toString();
              } else {
                number = number.substring(0, number.length - 1);
              }
            },
            onHover: (hover) {
              setState(() {
                if (hover) {
                  hoverNum = i;
                }
                else if (hoverNum == i) {
                  hoverNum = -1;
                }
              });
            },
            child: i == 12
                ? Icon(Icons.backspace_outlined, size: hoverNum == 12 ? 20.0 : 16.0,)
                : Text(i < 10 ? i.toString() : (i == 11 ? '0' : '')),
          ),
        ),
      );
    }
    return buttons;
  }

  Widget CustomTextField(text, label, changed) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: TextFormField(
        initialValue: text,
        decoration: InputDecoration(
          hintText: label,
          hintStyle: const TextStyle(
              color: Colors.black
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white.withOpacity(0.8)),
            borderRadius: const BorderRadius.all(Radius.circular(25.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white.withOpacity(0.8)),
            borderRadius: const BorderRadius.all(Radius.circular(25.0)),
          ),
          fillColor: Colors.white.withOpacity(0.8),
          filled: true,
        ),
        onChanged: changed
      ),
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
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 300,
              height: 500,
              child: Column(
                children: <Widget>[
                  Text(
                    number,
                    style: const TextStyle(
                      color: Colors.white
                    ),
                  ),
                  Wrap(
                    spacing: 30,
                    children: keypad(),
                  )
                ],
              ),
            ),
            Container(
              width: 400,
              height: 500,
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
              child: PageView(
                scrollDirection: Axis.vertical,
                controller: _controller,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: 320,
                        height: 500,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          // shape: RoundedRectangleBorder(
                          //   borderRadius: BorderRadius.circular(25.0),
                          //   side: BorderSide(
                          //     color: Colors.white,
                          //     width: 1.0,
                          //   ),
                          // ),
                        ),
                        onPressed: () {
                          newContact = Contact('', '', '', '', '');
                          _controller.nextPage(duration: const Duration(milliseconds: 1000), curve: Curves.linearToEaseOut);
                        },
                        child: Icon(
                          Icons.add,
                          size: addHover == true ? 20.0 : 16.0,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 400,
                    height: 500,
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 185,
                              child: CustomTextField(newContact.firstName, 'First Name', (String val) => newContact.firstName = val),
                            ),
                            const Spacer(),
                            SizedBox(
                              width: 185,
                              child: CustomTextField(newContact.lastName, 'Last Name', (String val) => newContact.lastName = val),
                            ),
                          ]
                        ),
                        SizedBox(
                          width: 380,
                          child: CustomTextField(newContact.mobileNum, 'Mobile Number', (String val) => newContact.mobileNum = val),
                        ),
                        SizedBox(
                          width: 380,
                          child: CustomTextField(newContact.email, 'Email', (String val) => newContact.email = val),
                        ),
                        Row(
                          children: <Widget>[
                            TextButton(
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: cancelConHover ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                              onHover: (hover) {
                                if (hover) {
                                  cancelConHover = true;
                                }
                                else {
                                  cancelConHover = false;
                                }
                              },
                              onPressed: () {
                                _controller.previousPage(duration: const Duration(milliseconds: 500), curve: Curves.linear);
                              },
                            ),
                            const Spacer(),
                            TextButton(
                              child: Text(
                                'Add',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: addConHover ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                              onHover: (hover) {
                                if (hover) {
                                  addConHover = true;;
                                }
                                else {
                                  addConHover = false;
                                }
                              },
                              onPressed: () async {
                                sqfliteFfiInit();
                                var databaseFactory = databaseFactoryFfi;
                                var db = await databaseFactory.openDatabase('contacts.dll');
                                try {
                                  await db.execute('''
                                  CREATE TABLE Contact (
                                    id INTEGER PRIMARY KEY,
                                    profile_pic TEXT,
                                    first_name TEXT,
                                    last_name TEXT,
                                    mobile_num TEXT,
                                    email TEXT
                                  )
                                ''');
                                } catch (err) {}
                                await db.insert('Contact', <String, Object?>{'profile_pic': newContact.profilePic, 'first_name': newContact.firstName, 'last_name': newContact.lastName,
                                'mobile_num': newContact.mobileNum, 'email': newContact.email});

                                var result = await db.query('Contact');
                                print(result);
                                _controller.previousPage(duration: const Duration(milliseconds: 500), curve: Curves.linear);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            HomeButton(),
          ],
        ),
      ),
    );
  }
}
