import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.brown.shade50,
        appBar: AppBar(
          leading: IconButton(
              icon:Icon(Icons.arrow_back_outlined),
              onPressed: (){
                Navigator.pop(context);
              }),
          title: Text('Settings'),
          backgroundColor: Colors.green.shade900,
          elevation: 0.0,
        ),
      ),
    );
  }
}

