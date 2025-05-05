import 'dart:math';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Login.dart';



class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController major = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Signup Screen",style: TextStyle(fontWeight: FontWeight.bold),),
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
              TextFormField(
                decoration: InputDecoration(
                    label: Text("name")
                ),
                controller: name,
              ),
              TextFormField(
                decoration: InputDecoration(
                    label: Text("age")
                ),

                controller: age,
              ),
              TextFormField(
                decoration: InputDecoration(
                    label: Text("major")
                ),
                controller: major,
              ),
              // TextFormField(),
              ElevatedButton(onPressed: ()async {
                String msg = await sign(email.text, pass.text);
                if(msg == "Account created successfully!"){
                  //addData();


                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Login()));
                }
                else{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
                }
              }, child: Text("Signup")),
              ElevatedButton(onPressed: (){}, child: Text("Signup With Google"))
            ],
          ),
        ),
      ),
    );
  }
  Future<String> sign(String email, String pass) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      return 'Account created successfully!';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      }
      else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      else {
        return 'An error occurred: ${e.message}';
      }
    }
    catch (e) {
      return 'An unexpected error occurred.';
    }
  }

// addData(){
//   FirebaseFirestore userInstance = FirebaseFirestore.instance;
//   CollectionReference users = userInstance.collection('users');
//   users.doc(FirebaseAuth.instance.currentUser!.uid).set({
//     'name': name.text,
//     'age' : age.text,
//     'major' : major.text
//   });
// }

}

