import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'model.dart';
import 'mechanics.page.dart';

class Mechanic extends StatefulWidget {
  String id;
  Mechanic({required this.id});
  @override
  _MechanicState createState() => _MechanicState(id: id);
}

class _MechanicState extends State<Mechanic> {
  String id;
  var category;
  var emaill;
  UserModel loggedInUser = UserModel(category: 'category', email: 'email', uid: 'uid',);

  _MechanicState({required this.id});
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
    }).whenComplete(() {
      const CircularProgressIndicator();
      setState(() {
        emaill = loggedInUser.email.toString();
        category = loggedInUser.category.toString();
        id = loggedInUser.uid.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Mechanic",
        ),
        actions: [
          IconButton(
            onPressed: () {
              logout(context);
            }, 
            icon: const Icon(Icons.logout),
           
      )
      ],
      ),
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
              const Text(
            "WELCOME TO SPANNER",
            style: TextStyle(
              color:Colors.blue,
              fontSize: 35,
            ),
          ),
        MaterialButton(
          onPressed :(){
            Navigator.of(context).push(
              MaterialPageRoute(
                builder:(context) =>mechanicspage() ,
                ),
            );
          },
          child: const Text(
            "Proceed",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          )),
          ]
      )
    )
    );
    }

  Future<void> logout(BuildContext context) async {
    const CircularProgressIndicator();
    await FirebaseAuth.instance.signOut();

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }
}