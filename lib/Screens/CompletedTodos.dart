import 'package:flutter/material.dart';
import 'package:my_todolistapp_firebase/Widgets/Completed_Todo_item_list.dart';
import 'package:my_todolistapp_firebase/constants/today_date_card.dart';

class CompletedTodos extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/home_back.jpg') as ImageProvider,
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Color(0x22FFFFFF),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Completed ToDo\'s',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 27),
          ),
          backgroundColor: Color.fromRGBO(50, 69, 88,1),
          elevation: 50.0,
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 110),
          child: Stack(
            children: [
              todayDateCard(),
              Padding(padding: EdgeInsets.only(top: 75,left: 10,right: 10),
                child: Completetd_Todo_item_list(),),
            ],),
        ),

      ),
    );
  }
}

