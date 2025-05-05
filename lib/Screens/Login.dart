
import 'package:base_test/Screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Startscreen.dart';
import 'ToDoApp.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Screen",style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Form(
          child: Column(

            children: [
              SizedBox(height: 60,),
              TextFormField(
                decoration: InputDecoration(

                    label: Text("email")
                ),
                controller: email,
              ),
              TextFormField(
                decoration: InputDecoration(
                    label: Text("Password")
                ),
                controller: pass,
              ),
              // TextFormField(),
              ElevatedButton(onPressed: () async {
                String msg = await LogFun(email.text, pass.text);
                if(msg ==""){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Startscreen ()));//
                }
                else{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
                }

              }, child: Text("Login")),
              TextButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Signup()));
              }, child: Text("If you dont have acout sign up")),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> LogFun(String email, String pass) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );
      return "";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      } else {
        return 'somthing wrong';
      }
    }
  }

}