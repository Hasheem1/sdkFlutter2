import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'SupTask.dart';



class TodoApp extends StatefulWidget {
  TodoApp({super.key});

  @override
  State<TodoApp> createState() => _SimpleTodoAppState();
}
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
CollectionReference taskCollection = firebaseFirestore.collection('task');

class _SimpleTodoAppState extends State<TodoApp> {

  addFun(String id){
    taskCollection.add({
      'TaskName' : taskController.text,
      'status' : false,
      'uid' : id
    });
    data.clear();
    getFun();
  }
  List<QueryDocumentSnapshot> data = [];
  getFun()async{
    data.clear();
    QuerySnapshot snapshot = await taskCollection.where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();
    setState(() {
      data.addAll(snapshot.docs);
    });
  }



  deletFun(String id){
    taskCollection.doc(id).delete();
  }


  updateFun(String id,bool stat){
    taskCollection.doc(id).update({
      'status': stat
    });
  }
  @override
  void initState() {
    getFun();
    super.initState();
  }

  TextEditingController taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Simple To Do App"),
        backgroundColor: Colors.blueGrey,
      ),

      body: ListView.builder(itemBuilder: (context, i){
        return taskCard(data[i]['TaskName'] ,data[i]['status'],data[i].id);
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
                      addFun(FirebaseAuth.instance.currentUser!.uid);
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
    return InkWell(onTap: (){
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Subtask(docid: id)));
    },
      child: Card(

        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:[
              IconButton(onPressed: (){
                setState(() {
                  bool newstat = !status;
                  updateFun(id, newstat);
                  getFun();
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
                  deletFun(id);
                  getFun();

                });
              }, icon: Icon(Icons.delete))


            ]

        ),
      ),
    );
  }
}



