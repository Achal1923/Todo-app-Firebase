import 'package:flutter/material.dart';
import 'package:my_todolistapp_firebase/services/database.dart';
import 'package:intl/intl.dart';
import 'package:my_todolistapp_firebase/services/notification_services.dart';

class AddTodoWidget extends StatefulWidget {

  @override
  _AddTodoWidgetState createState() => _AddTodoWidgetState();
}

class _AddTodoWidgetState extends State<AddTodoWidget> {

  late String _title;
  late String _description;
  DateTime _taskDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, DateTime.now().weekday);
  bool _isAdding=false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Task', style: TextStyle(color: Color.fromRGBO(50, 69, 88,1),fontWeight: FontWeight.bold),),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              maxLines: 2,
              validator: (val) => val!.isEmpty ? 'Title must not be Empty!' : null,
              onChanged: (String value) {
                _title = value;
              },
            ),
            TextFormField(
              maxLines: 5,
              validator: (val) => val!.isEmpty ? 'Description must not be Empty!' : null,
              onChanged: (String value) {
                _description = value;
              },
            ),
            Row(
              children: [
                IconButton(icon: Icon(Icons.today_outlined,color: Colors.pink,size: 30,),
                  onPressed: () async{
                        DateTime dt = ( await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(DateTime.now().year-2),
                              lastDate: DateTime(2220),)
                        )!;
                        setState(() {
                          _taskDate=dt;
                        });
                  },
                ),
                Text(DateFormat('dd/MMM/yyyy - EE').format(_taskDate),style: TextStyle(fontWeight: FontWeight.bold,),),
              ],
            ),
          ],
        ),
      ),
      actions: [_isAdding ? CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent,), strokeWidth: 3,)
                             : RaisedButton(
                                    child: Text('Add To-Do', style: TextStyle(color: Colors.white),),
                                    color: Colors.pink,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40.0),),
                                    onPressed: () async {
                                              if (_formKey.currentState!.validate())
                                              {
                                                setState(() {
                                                  _isAdding=true;
                                                });
                                                await DatabaseService.CreateTodo(
                                                    title: _title, description: _description, taskDate: _taskDate);
                                                setState(() {
                                                   _isAdding=false;
                                                });
                                                NotificationService.taskCreatedNotification();
                                              Navigator.of(context).pop();
                                              }
                                              },
                                            ),
      ],
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
