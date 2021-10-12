import 'package:flutter/material.dart';
import 'package:my_todolistapp_firebase/Widgets/Todo_Items_List.dart';
import 'package:my_todolistapp_firebase/constants/today_date_card.dart';
import 'package:my_todolistapp_firebase/Widgets/SideMenuDrawer.dart';
import 'package:my_todolistapp_firebase/Widgets/Add_Todo_widget.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {

    return Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/home_back.jpg'),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Color(0x22FFFFFF),
        extendBodyBehindAppBar: true,
        drawer: SideMenuDrawer(),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'ToDo\'s',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30),
          ),
          backgroundColor: Color.fromRGBO(50, 69, 88,1),
          elevation: 50.0,
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 110),
          child: Stack(
            children: [
                    todayDateCard(),
              Padding(padding: EdgeInsets.only(top: 67,left: 10,right: 10),
                  child: TodoItemList()),
            ],),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.pink,
          child: Icon(Icons.add),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AddTodoWidget();
                });
          },
        ),
      ),
    );
  }
}
