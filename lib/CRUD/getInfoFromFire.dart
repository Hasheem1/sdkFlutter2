import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class crudGetUserName extends StatelessWidget {
  final String documentId;

  crudGetUserName(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    TextEditingController name=TextEditingController();
    final credential = FirebaseAuth.instance.currentUser!;
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Name: ${data['name']}"),
                  IconButton(icon: Icon(CupertinoIcons.pen) , onPressed: () {
                    showDialog(context: context, builder: (context){
                      return AlertDialog(
                        title: Text("update"),
                        content: TextField(controller: name,

                        ),
                        actions: [
                          TextButton(onPressed: (){users.doc(FirebaseAuth.instance.currentUser!.uid).update({'name':name.text});
                            Navigator.pop(context);
                            }, child: Text("update")),
                          TextButton(onPressed: (){Navigator.pop(context);}, child: Text("cancle"))

                        ],
                      );
                    });
                  },),
                  IconButton(icon: Icon(CupertinoIcons.delete) , onPressed: () {users.doc(FirebaseAuth.instance.currentUser!.uid).update({'name':FieldValue.delete()});
                    },),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Age: ${data['age']}"),
                  IconButton(icon: Icon(CupertinoIcons.pen) , onPressed: () {
                    showDialog(context: context, builder: (context){
                      return AlertDialog(
                        title: Text("update"),
                        content: TextField(controller: name,

                        ),
                        actions: [
                          TextButton(onPressed: (){users.doc(FirebaseAuth.instance.currentUser!.uid).update({'age':name.text});
                          Navigator.pop(context);
                          }, child: Text("update")),
                          TextButton(onPressed: (){Navigator.pop(context);}, child: Text("cancle"))

                        ],
                      );
                    });
                  },),IconButton(icon: Icon(CupertinoIcons.delete) , onPressed: () {users.doc(FirebaseAuth.instance.currentUser!.uid).update({'age':FieldValue.delete()});  },),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Major: ${data['major']}"),
                  IconButton(icon: Icon(CupertinoIcons.pen) , onPressed: () {
                    showDialog(context: context, builder: (context){
                      return AlertDialog(
                        title: Text("update"),
                        content: TextField(controller: name,

                        ),
                        actions: [
                          TextButton(onPressed: (){users.doc(FirebaseAuth.instance.currentUser!.uid).update({'major':name.text});
                          Navigator.pop(context);
                          }, child: Text("update")),
                          TextButton(onPressed: (){Navigator.pop(context);}, child: Text("cancle"))

                        ],
                      );
                    });
                  },),IconButton(icon: Icon(CupertinoIcons.delete) , onPressed: () { users.doc(FirebaseAuth.instance.currentUser!.uid).delete(); },),
                ],
              ),
              Row(
                children: [
                  Text("email : ${credential.email}\n"),
                  Text("create data ${credential.metadata.creationTime}"),

                ],
              )





            ],

          );
        }

        return Text("loading");
      },
    );


  }
  Showdilog(){

  }
}