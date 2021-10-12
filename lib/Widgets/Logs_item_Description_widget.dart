import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class LogsItemDescription extends StatelessWidget {

  String title;
  DateTime created;
  String description;
  String action;
  DateTime taskDate;
  bool isDone;

  LogsItemDescription({required this.title,required this.created,required this.action,required this.description,required this.taskDate,required this.isDone});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22,),
            maxLines: 1,
          ),
          Text(DateFormat('yyyy-MM-dd – kk:mm').format(created),style: TextStyle(color: Colors.grey,fontSize: 18,),),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
               Text('Description - ',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              Expanded(child: Text(description,maxLines: 5,style: TextStyle(fontSize: 18,),),),
            ],
          ),
          SizedBox(height: 20,),
          Row(
              children:[
          Text('Task Date - ',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
          Text(DateFormat('yyyy-MM-dd').format(taskDate),style: TextStyle(fontSize: 18),),
              ],
          ),
          SizedBox(height: 20,),
          Row(
            children:[
              Text('Status - ',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              isDone ? Text('Completed',style: TextStyle(fontSize: 18,color: Colors.green),) : Text('Pending',style: TextStyle(fontSize: 18,color: Colors.red),) ,
            ],
          ),
        ]
      ),
      actions: [
         Container(
            width: double.infinity,
            padding: EdgeInsets.all(8),
            child: Text(
              action,
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22,
                  color: (action=='Created' ?Colors.pink : (action=='Updated' ? Colors.indigoAccent : Colors.black87) ),),
              textAlign: TextAlign.center,
            ),
          ),
      ],
    );
  }
}
