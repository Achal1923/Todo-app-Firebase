import 'package:flutter/material.dart';
import 'package:my_todolistapp_firebase/Widgets/Logs_Item_widget.dart';

class LogsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Log\'s',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 27),
        ),
        backgroundColor: Color.fromRGBO(50, 69, 88, 1),
        elevation: 20.0,
      ),
      body: Logs_Item_List(),
    );
  }
}
