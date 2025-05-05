import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'ToDoApp.dart';

class Subtask extends StatefulWidget {
  String docid;
  Subtask({required this.docid});

  @override
  State<Subtask> createState() => _SubtaskState();
}


FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

class _SubtaskState extends State<Subtask> {

  CollectionReference taskCollection = firebaseFirestore.collection('task');

  // addFun(String id){
  //   taskCollection.add({
  //     'TaskName' : taskController.text,
  //     'status' : false,
  //     'uid' : id
  //   });
  //   data.clear();
  //   getFun();
  // }
  addTask(String did,String name , bool status){
    taskCollection.doc(did).collection('subtask').add({
      'name' : taskController.text,
      'status' : status
    });
    data.clear();
    getFun();

  }


  List<QueryDocumentSnapshot> data = [];
  getFun()async{
    data.clear();
    QuerySnapshot snapshot = await taskCollection.doc(widget.docid).collection('subtask').get();
    setState(() {
      data.addAll(snapshot.docs);
    });
  }



  // deletFun(String id){
  //   taskCollection.doc(id).delete();
  // }


  deletTask(String mainColl,subColl)async{
    await taskCollection.doc(mainColl).collection('subtask').doc(subColl).delete();
    data.clear();
    getFun();
  }
  //
  //
  // updateFun(String id,bool stat){
  //   taskCollection.doc(id).update({
  //     'status': stat
  //   });
  // }
  // @override
  // void initState() {
  //   //getFun();
  //   super.initState();
  // }


  updat(String mainColl,subColl,bool status)async{
    await taskCollection.doc(mainColl).collection('subtask').doc(subColl).update(
        {
          'status': status
        });
    setState(() {
      data.clear();
      getFun();
    });
  }

  TextEditingController taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Sub Tasks"),
        backgroundColor: Colors.blueGrey,
      ),

      body:ListView.builder(itemBuilder: (context, i){
        return taskCard(data[i]['name'] ,data[i]['status'],data[i].id);
      },
        itemCount:  data.length,

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title:  Text("Add Task"),
              content: TextField(
                controller: taskController,
                decoration:  InputDecoration(hintText: "Enter task"),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child:  Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      addTask(widget.docid!,taskController.text, false);
                      taskController.clear();
                    });
                    Navigator.pop(context);

                  },
                  child:  Text("Add"),
                ),
              ],
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
  Widget taskCard(String taskName, bool status,String id) {
    return Card(

      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:[
            IconButton(onPressed: (){
              setState(() {
                bool newstat = !status;
                updat(widget.docid,id, newstat);
                //getFun();
              });
            }, icon: status?(Icon(Icons.check_box)):Icon(Icons.check_box_outline_blank)),
            Text(
              taskName,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            IconButton(onPressed: (){
              setState(() {
                deletTask(widget.docid, id);

              });
            }, icon: Icon(Icons.delete))


          ]

      ),
    );
  }
}
