import 'package:my_todolistapp_firebase/Model/UserModel.dart';
import 'package:my_todolistapp_firebase/Screens/sign_in.dart';
import 'package:my_todolistapp_firebase/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:my_todolistapp_firebase/constants/loading.dart';
import 'package:my_todolistapp_firebase/services/database.dart';
import 'package:provider/provider.dart';
import 'HomePage.dart';

class Register extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);

    return loading
        ? Loading()
        : Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'The Todo App',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
              backgroundColor: Color(0x44000000),
              elevation: 0,
            ),
            body: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/todo_auth.jfif'),
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.topCenter)),
                ),

                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(top: 220),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 25, right: 25, top: 110),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(bottom: 15),
                            child: Container(
                              color: Color(0xfff5f5f5),
                              child: TextFormField(
                                // controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'SFUIDisplay'),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Username',
                                    prefixIcon: Icon(Icons.person_outline),
                                    labelStyle: TextStyle(fontSize: 15)),
                                validator: (val) =>
                                    val!.isEmpty ? 'Enter an Email' : null,
                                onChanged: (val) {
                                  setState(() => _email = val);
                                },
                              ),
                            ),
                          ),
                          Container(
                            color: Color(0xfff5f5f5),
                            child: TextFormField(
                              obscureText: true,
                              // controller: _passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'SFUIDisplay'),
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Password',
                                  prefixIcon: Icon(Icons.lock_outline),
                                  labelStyle: TextStyle(fontSize: 15)),
                              validator: (val) => val!.length < 6
                                  ? 'Enter a password 6+ chars long'
                                  : null,
                              onChanged: (val) {
                                setState(() => _password = val);
                              },
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: 70),
                              child: MaterialButton(
                                  child: Text(
                                    'SIGN UP',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'SFUIDisplay',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  color: Color(0xffff2d55),
                                  elevation: 0,
                                  minWidth: 400,
                                  height: 50,
                                  textColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate())
                                    {
                                      User? result;
                                                    setState(() => loading = true);
                                                    await authService
                                                        .createUserWithEmailAndPassword(
                                                            _email, _password).then((value) => result = value);

                                                    if (result == null) {
                                                      setState(() {
                                                        loading = false;
                                                      });
                                                    } else {
                                                      DatabaseService.userUID = result!.uid  ;
                                                      DatabaseService.userMail = result!.email;
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (context) => Home()));
                                                    }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'Please Enter valid Email and Password!'),
                                        ),
                                      );
                                    }
                                  })),
                          Padding(
                            padding: EdgeInsets.only(top: 120),
                            child: Center(
                              child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Already have an account?",
                                      style: TextStyle(
                                        fontFamily: 'SFUIDisplay',
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                    ),
                                    TextButton(
                                        child: Text(
                                          "SignIn!",
                                          style: TextStyle(
                                            fontFamily: 'SFUIDisplay',
                                            color: Color(0xffff2d55),
                                            fontSize: 15,
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        SignIn(),
                                              ));
                                        }),
                                  ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 30,
                  top: 255,
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          );
  }
}
