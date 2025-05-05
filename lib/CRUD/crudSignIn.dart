
import 'package:base_test/CRUD/crudHomeScreen.dart';
import 'package:base_test/Screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'crudSignUp.dart';


class crudSignIn extends StatefulWidget {
  @override
  State<crudSignIn> createState() => _crudSignInState();
}

class _crudSignInState extends State<crudSignIn> {
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
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> crudHomeScreen(FirebaseAuth.instance.currentUser!.uid)));//
                }
                else{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
                }

              }, child: Text("Login")),
              TextButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>crudSignUp()));
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