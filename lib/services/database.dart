import 'package:cloud_firestore/cloud_firestore.dart';

final CollectionReference _taskCollection = FirebaseFirestore.instance.collection('tasks');
final CollectionReference _logsCollection = FirebaseFirestore.instance.collection('logs');

class DatabaseService {

  static String? userUID;
  static String? userMail;

  static Future<void> CreateTodo({required String title, required String description,required DateTime taskDate})async
  {
    DocumentReference documentDataReference = _taskCollection.doc(userUID).collection('tasks').doc();
    DocumentReference documentLogReference = _logsCollection.doc(userUID).collection('logs').doc();

    Map<String,dynamic> data = <String,dynamic>{"title":title,"description":description,"taskDate":taskDate,"IsDone":false};
    Map<String,dynamic> logsData = <String,dynamic>{"action":'Created',"title":title,"description":description,"taskDate":taskDate,"created": DateTime.now(),"IsDone":false};

    await documentDataReference.set(data).whenComplete(() => print("Todo Task added to the database")).catchError((e)=>print(e));
    await documentLogReference.set(logsData).whenComplete(() => print("Todo Task added to the database")).catchError((e)=>print(e));

  }

  static Future<void> UpdateTodo({required String title,required String description,required DateTime taskDate,required String docId,bool? IsDone=false})async{
    DocumentReference documentReference = _taskCollection.doc(userUID).collection('tasks').doc(docId);
    Map<String,dynamic> data = <String,dynamic>{"title":title,"description":description,"taskDate":taskDate,"IsDone":IsDone};

    DocumentReference documentLogReference = _logsCollection.doc(userUID).collection('logs').doc();
    Map<String,dynamic> logsData = <String,dynamic>{"action":'Updated',"title":title,"description":description,"taskDate":taskDate,"created": DateTime.now(),"IsDone":IsDone};

    await documentReference.set(data).whenComplete(() => print("Todo Task updated in the database")).catchError((e)=>print(e));
    await documentLogReference.set(logsData).whenComplete(() => print("Todo Task added to the database")).catchError((e)=>print(e));
  }

  static Stream<QuerySnapshot> ReadTodo(){
    CollectionReference todoItemCollection = _taskCollection.doc(userUID).collection('tasks');
    return todoItemCollection.orderBy("taskDate", descending: false).snapshots();
  }

  static Stream<QuerySnapshot> ReadLogs(){
    CollectionReference todoLogsCollection = _logsCollection.doc(userUID).collection('logs');
    return todoLogsCollection.orderBy("created", descending: true).snapshots();
  }

  static Future<void> deleteTodo({required String docId,required String title,required String description,required DateTime taskDate,required bool IsDone})async {
    DocumentReference documentReference = _taskCollection.doc(userUID).collection('tasks').doc(docId);

    DocumentReference documentLogReference = _logsCollection.doc(userUID).collection('logs').doc();
    Map<String,dynamic> logsData = <String,dynamic>{"action":'Deleted',"title":title,"description":description,"taskDate":taskDate,"created": DateTime.now(),"IsDone":IsDone};

    await documentLogReference.set(logsData).whenComplete(() => print("Todo Task updated in the database")).catchError((e)=>print(e));
    await documentReference.delete().whenComplete(() => print('Todo item deleted from the database')).catchError((e)=> print(e));
  }
}