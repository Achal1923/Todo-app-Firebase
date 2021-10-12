import 'package:flutter/material.dart';
import 'package:my_todolistapp_firebase/Screens/LogsScreen.dart';
import 'package:my_todolistapp_firebase/Screens/Wrapper.dart';
import 'package:my_todolistapp_firebase/services/auth.dart';
import 'package:my_todolistapp_firebase/Screens/HomePage.dart';
import 'package:my_todolistapp_firebase/Screens/CompletedTodos.dart';
import 'package:my_todolistapp_firebase/services/database.dart';


class SideMenuDrawer extends StatelessWidget {

  String? _displayEmail = DatabaseService.userMail != null ? DatabaseService.userMail : 'Email';

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.white,
        child: ListView(
          children: [
            InkWell(
              child: Container(
                color: Color.fromRGBO(50, 69, 88,1),
                child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20,top: 20),
                          child: CircleAvatar(
                            radius: 70,
                            backgroundImage: AssetImage('assets/dp.jpg'),
                          ),
                        ),
                        SizedBox(height: 30),
                        Padding(
                          padding: EdgeInsets.only(left: 20,bottom: 20),
                          child: Text(
                          _displayEmail!,
                            style: TextStyle(fontSize: 25, color: Colors.white,fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 25.0),
              leading: Icon(
                Icons.notes_sharp,
                color: Colors.black87,
                size: 25,
              ),
              title: Text(
                'ToDo\'s',
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              onTap: () {
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (context) => Home()));
              },
            ),
            // ListTile(
            //   contentPadding:
            //   EdgeInsets.symmetric(horizontal: 25),
            //   leading: Icon(
            //     Icons.notes_sharp,
            //     color: Colors.black87,
            //     size: 25,
            //   ),
            //   title: Text(
            //     'Browse ToDo\'s by Date',
            //     style: TextStyle(
            //         color: Colors.black87,
            //         fontWeight: FontWeight.bold,
            //         fontSize: 18),
            //   ),
            //   onTap: () {
            //     Navigator.of(context).pop();
            //     Navigator.of(context).push(
            //         MaterialPageRoute(builder: (context) => BrowseTaskByDate()));
            //   },
            // ),
            ListTile(
              contentPadding:
              EdgeInsets.symmetric(horizontal: 25),
              leading: Icon(
                Icons.playlist_add_check_sharp,
                color: Colors.black87,
                size: 30,
              ),
              title: Text(
                'Completed ToDo\'s',
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => CompletedTodos()));
              },
            ),
            ListTile(
              contentPadding:
              EdgeInsets.symmetric(horizontal: 25),
              leading: Icon(
                Icons.history_sharp,
                color: Colors.black87,
                size: 30,
              ),
              title: Text(
                'Logs',
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LogsScreen() ));
              },
            ),
            SizedBox(height: 240,),
            ListTile(
              tileColor: Colors.redAccent,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 25),
              leading: Icon(
                Icons.logout_sharp,
                color: Colors.white,
                size: 30,
              ),
              title: Text(
                'Logout',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              onTap: () async {
                await AuthService().signOut();
                //Navigator.of(context).pop();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) =>Wrapper() ),
                    (route)=>false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
