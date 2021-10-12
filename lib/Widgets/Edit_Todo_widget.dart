import 'package:flutter/material.dart';
import 'package:my_todolistapp_firebase/services/database.dart';
import 'package:intl/intl.dart';
import 'package:my_todolistapp_firebase/services/notification_services.dart';

class EditTodo extends StatefulWidget {

  late String editableTitle;
  late String editableDescription;
  final String documentId;
  late DateTime taskDate;
  late bool isDone;
  EditTodo({required this.editableTitle,required this.editableDescription,required this.taskDate,required this.documentId,required this.isDone});

  late String _orgTitle = editableTitle;
  late String _orgDescription = editableDescription;
  late DateTime _orgTaskDate = taskDate;

  @override
  _EditTodoState createState() => _EditTodoState();
}

class _EditTodoState extends State<EditTodo> {

  bool _isDeleting = false;
  bool _isUpdating = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Todo',style: TextStyle(color: Color.fromRGBO(50, 69, 88,1),fontWeight: FontWeight.bold),),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              initialValue: widget.editableTitle,
              validator: (val) => val!.isEmpty ? 'Title must not be Empty!' : null,
              onChanged: (String value) {
                widget.editableTitle = value;
              },
            ),
            TextFormField(
              maxLines: 5,
              initialValue: widget.editableDescription,
              validator: (val) => val!.isEmpty ? 'Description must not be Empty!' : null,
              onChanged: (String value) {
                widget.editableDescription = value;
              },
            ),
            Row(
              children: [
                IconButton(icon: Icon(Icons.today_outlined,color: Colors.pink,size: 30,),
                  onPressed: () async{
                    DateTime dt = ( await showDatePicker(
                      context: context,
                      initialDate: widget.taskDate,
                      firstDate: DateTime(DateTime.now().year-2),
                      lastDate: DateTime(2220),)
                    )!;
                    setState(() {
                      widget.taskDate=dt;
                    });
                  },
                ),
                Text(DateFormat('dd/MMM/yyyy - EE').format(widget.taskDate),style: TextStyle(fontWeight: FontWeight.bold),),
              ],
            ),
          ],
        ),
      ),
      actions: [
        _isDeleting ? CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent,), strokeWidth: 3,)
            : Padding(
          padding: EdgeInsets.only(right:75),
              child: RaisedButton(
                child: Text('Delete',style: TextStyle(color: Colors.white),),
              color: Colors.red.shade700,
              onPressed: () async{
                setState(() {
                  _isDeleting=true;
                });
                await DatabaseService.deleteTodo(docId: widget.documentId,title: widget._orgTitle,description: widget._orgDescription,taskDate: widget._orgTaskDate,IsDone:widget.isDone);
                setState(() {
                  _isDeleting=true;
                });
                NotificationService.taskDeletedNotification();
                Navigator.of(context).pop();
              },
              ),
            ),


        _isUpdating ? CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.indigoAccent.shade700,), strokeWidth: 3,)
        : RaisedButton(child: Text('Edit',style: TextStyle(color: Colors.white),),
            color: Colors.indigoAccent,
            onPressed: () async{
              if (_formKey.currentState!.validate())
                {
                  setState(() {
                  _isUpdating=true;
                  });
                  await DatabaseService.UpdateTodo(title: widget.editableTitle,description: widget.editableDescription,taskDate: widget.taskDate,docId: widget.documentId);
                  setState(() {
                  _isUpdating=false;
                  });
                  NotificationService.taskUpdateNotification();
                  Navigator.of(context).pop();
                }
            }
    ),
      ],
    );
  }
}
