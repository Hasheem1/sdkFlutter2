import 'package:base_test/Screens/redData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Login.dart';

class Startscreen extends StatefulWidget {
  const Startscreen({super.key});

  @override
  State<Startscreen> createState() => _StartscreenState();
}

class _StartscreenState extends State<Startscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(onPressed: (){
            setState(() {

            });
          }, child: Icon(Icons.refresh))
        ],
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blueGrey,
              ),
              child: Center(
                child: Text(
                  'Auth info',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            GetUserName(FirebaseAuth.instance.currentUser!.uid),






            SizedBox(height: 50,),

            ElevatedButton(onPressed: (){
              setState(() {
                FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Login()), (route) => false,);
              });

            }, child: Text("Logout"))
          ],
        ),
      ),
    );
  }
}
