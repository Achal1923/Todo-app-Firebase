        import 'package:flutter/material.dart';
        import 'package:cloud_firestore/cloud_firestore.dart';
        import 'package:my_todolistapp_firebase/Widgets/Edit_Todo_widget.dart';
        import 'package:my_todolistapp_firebase/services/database.dart';
        import 'package:intl/intl.dart';
import 'package:my_todolistapp_firebase/services/notification_services.dart';

        class TodoItemList extends StatelessWidget {

          @override
          Widget build(BuildContext context) {
            return StreamBuilder<QuerySnapshot>(
                stream:DatabaseService.ReadTodo(),
                builder: (context,snapshots){
                  if(snapshots.hasError){
                    return Center(child: Text("Something went Wrong"));
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
                            var IsDone = todoInfo['IsDone'];
                            var todayDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, DateTime.now().weekday);
                            bool _outDated = todayDate.compareTo(taskDate)>=0 ? true : false;

                            return IsDone==false?
                                          Ink(
                                            padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: _outDated ? Color(0x99000000) : Color(0xffFFFFFF),
                                            borderRadius: BorderRadius.circular(15.0),
                                          ),
                                            child: ListTile(
                                              contentPadding: EdgeInsets.symmetric(horizontal:10,),
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
                                                  Text(DateFormat('EE').format(taskDate),style: TextStyle(fontWeight: FontWeight.bold,fontSize:15,color: _outDated?Colors.red:Colors.black87),),
                                                  Text(DateFormat('dd-MMM').format(taskDate),style: TextStyle(fontWeight: FontWeight.bold,fontSize:15,color: _outDated?Colors.red:Colors.black87),),
                                                  Text(DateFormat('yyyy').format(taskDate),style: TextStyle(fontWeight: FontWeight.bold,fontSize:15,color: _outDated?Colors.red:Colors.black87),),
                                                ],
                                              ),
                                              title: Text(
                                                title,style: TextStyle(color: _outDated?Colors.red:Colors.pink,fontWeight: FontWeight.bold,fontSize: 22,),
                                                maxLines: 1,
                                              ),
                                              subtitle: Text(
                                                description,style: TextStyle(color:_outDated?Colors.redAccent:Colors.black54,fontSize: 15),
                                                maxLines: 2,
                                              ),
                                              trailing: Checkbox(
                                                hoverColor: Colors.lightBlueAccent,
                                                activeColor: Colors.indigoAccent,
                                                value: IsDone,
                                                onChanged: (val) {
                                                  DatabaseService.UpdateTodo(title: title, description: description, taskDate: taskDate, docId: docId,IsDone: val);
                                                  _outDated?NotificationService.taskCompletedNotification():NotificationService.taskCompletedonTimeNotification();
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
