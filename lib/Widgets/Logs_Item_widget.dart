import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_todolistapp_firebase/Widgets/Logs_item_Description_widget.dart';
import 'package:my_todolistapp_firebase/services/database.dart';
import 'package:intl/intl.dart';

class Logs_Item_List extends StatefulWidget {

  @override
  _Logs_Item_ListState createState() => _Logs_Item_ListState();
}

class _Logs_Item_ListState extends State<Logs_Item_List> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream:DatabaseService.ReadLogs(),
        builder: (context,snapshots){
          if(snapshots.hasError){
            return Text("Something went Wrong");
          }
          else if(snapshots.hasData || snapshots.data!=null)
          {
            return ListView.separated(
                padding: EdgeInsets.all(10),
                separatorBuilder: (context, index)=>SizedBox(height:5,),
                itemCount: snapshots.data!.docs.length,
                itemBuilder: (context,index){
                  var todoInfo = snapshots.data!.docs[index].data() as Map<String,dynamic>;
                  var docId = snapshots.data!.docs[index].id;
                  var title = todoInfo['title'];
                  var description = todoInfo['description'];
                  var taskDate = todoInfo['taskDate']==null?todoInfo['taskDate']:todoInfo['taskDate'].toDate();
                  var created = todoInfo['created']==null?todoInfo['created']:todoInfo['created'].toDate();
                  var action = todoInfo['action'];
                  var isDone = todoInfo['IsDone'];

                  return ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal:10,),
                    leading:
                    Text(action,style: TextStyle(fontWeight: FontWeight.bold,fontSize:15,color: (action=='Created' ?Colors.pink : (action=='Updated' ? Colors.blueAccent : Colors.black) ),),
                    ),
                    title: Text(
                      title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,),
                      maxLines: 1,
                    ),
                    subtitle: Text(
                      DateFormat('yyyy-MM-dd – kk:mm').format(created).toString(),style: TextStyle(fontSize: 13),),
                    onTap:(){
                      showDialog(
                          context: context,
                          builder: (context){
                            return LogsItemDescription(title: title, created: created, action: action, description: description, taskDate: taskDate,isDone: isDone,);
                          }
                      );
                    } ,
                  );
                }
            );
          }
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green.shade400),
            ),
          );
        });
  }
}
