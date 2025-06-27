import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  void incrementuser(){//fake data for checkin
    final user = {
      "firstname": "steve",
      "lastname":"austin",
      "born": 0,
    };
    db.collection("users").add(user).then((DocumentReference doc)=>print("user add with ID : ${doc.id}"));
  }
  @override
  void initState() {
    incrementuser();
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('s'),
    );
  }
}
