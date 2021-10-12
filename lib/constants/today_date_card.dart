import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class todayDateCard extends StatelessWidget {

  DateTime _today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 50,
      color: Color.fromRGBO(50, 69, 88,1),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(DateFormat('dd').format(_today),style: TextStyle(color: Colors.white,fontSize: 30),),
            SizedBox(width: 10,),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(DateFormat('MMMM').format(_today),style: TextStyle(color: Colors.white,fontSize: 20),),
                Text(DateFormat('yyyy').format(_today),style: TextStyle(color: Colors.white,fontSize: 20),),
              ],
            ),
            SizedBox(width: 10,),
            Text(DateFormat('EEEE').format(_today),style: TextStyle(color: Colors.white,fontSize: 30),),
          ],
        ),
      ),
    );
  }
}
