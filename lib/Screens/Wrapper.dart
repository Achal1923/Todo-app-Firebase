import 'package:flutter/material.dart';
import 'package:my_todolistapp_firebase/Model/UserModel.dart';
import 'package:my_todolistapp_firebase/Screens/HomePage.dart';
import 'package:my_todolistapp_firebase/Screens/sign_in.dart';
import 'package:my_todolistapp_firebase/services/database.dart';
import 'package:provider/provider.dart';
import 'package:my_todolistapp_firebase/services/auth.dart';


class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // return either the Home or Authenticate widget

    final authService=Provider.of<AuthService>(context);
    return StreamBuilder<User?>(
      stream: authService.user,
      builder: (_,AsyncSnapshot<User?>snapshot){
        if(snapshot.connectionState==ConnectionState.active)
        {
          final User?user=snapshot.data;
          if(user==null)
            {
              return SignIn();
            }
          else{
            DatabaseService.userUID=user.uid;
            DatabaseService.userMail=user.email;
            return Home();
          }
          // return user==null?SignIn():Home();
        }else{
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}