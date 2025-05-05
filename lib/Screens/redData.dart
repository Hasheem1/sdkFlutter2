import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GetUserName extends StatelessWidget {
  final String documentId;

  GetUserName(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    TextEditingController newname = TextEditingController();

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
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Name: ${data['name']}"),
                    InkWell(
                        onTap: (){
                          showDialog(context: context, builder: (context){
                            return AlertDialog(
                              title: Text("Update"),
                              content: TextField(
                                controller: newname,
                              ),
                              actions: [
                                TextButton(onPressed: (){
                                  users.doc(FirebaseAuth.instance.currentUser!.uid).update(
                                      {'name':newname.text}
                                  );
                                  Navigator.pop(context);
                                }, child: Text("Update")),
                                TextButton(onPressed: (){}, child: Text("Cancel"))

                              ],
                            );
                          });
                        },
                        child: Icon(Icons.edit))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Age: ${data['age']}"),
                    InkWell(
                        onTap: (){},
                        child: Icon(Icons.edit))                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Major: ${data['major']}"),
                    InkWell(
                        onTap: (){},
                        child: Icon(Icons.edit))                  ],
                ),
              ],
            ),
          );
        }

        return Text("loading");
      },
    );
  }
}