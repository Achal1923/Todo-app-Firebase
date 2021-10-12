import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_todolistapp_firebase/Widgets/Edit_Todo_widget.dart';
import 'package:my_todolistapp_firebase/services/database.dart';
import 'package:intl/intl.dart';

class Completetd_Todo_item_list extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream:DatabaseService.ReadTodo(),
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
                  var taskDate = todoInfo['taskDate']==null ? todoInfo['taskDate'] : todoInfo['taskDate'].toDate();
                  var IsDone = todoInfo['IsDone'];

                  return IsDone==true?
                      Ink(padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.green.shade500.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: ListTile(
                          onLongPress:(){
                            showDialog(
                                context: context,
                                builder: (context){
                                  return EditTodo(editableTitle: title,editableDescription: description,taskDate: taskDate,documentId: docId,isDone: IsDone,);
                                }
                            );
                          } ,
                          leading: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(DateFormat('EE').format(taskDate),style: TextStyle(fontWeight: FontWeight.bold,fontSize:15)),
                              Text(DateFormat('dd-MMM').format(taskDate),style: TextStyle(fontWeight: FontWeight.bold,fontSize:15)),
                              Text(DateFormat('yyyy').format(taskDate),style: TextStyle(fontWeight: FontWeight.bold,fontSize:15)),
                            ],
                          ),
                          title: Text(
                            title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22,
                              decoration:TextDecoration.lineThrough),
                            maxLines: 1,
                          ),
                          subtitle: Text(
                            description,style: TextStyle(color: Colors.black54,fontSize: 15,
                              decoration:TextDecoration.lineThrough,),
                            maxLines: 2,
                          ),
                          trailing: Checkbox(
                            activeColor: Colors.pink,
                            value: IsDone,
                            onChanged: (val) {
                              DatabaseService.UpdateTodo(title: title, description: description, taskDate: taskDate, docId: docId,IsDone: val);
                            },
                          ),
                        ),)
                      : Container();
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
