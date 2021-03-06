import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 1.0],
              colors: [const Color(0xFF543CBA),const Color(0xFF3FA5B1)],
            ),
          )
      ),
    );
  }
}

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Color(0xFF543CBA),
    elevation: 0,
    leading: IconButton(
      icon: Image.asset('assets/images/back.png'),
      onPressed: () => Navigator.pop(context),
    ),
    actions: <Widget>[

    ],
  );
}