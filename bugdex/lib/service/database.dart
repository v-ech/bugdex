import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseMethod{
  Future addBug(Map<String, dynamic> bugList, String id) async{
    return await FirebaseFirestore.instance
      .collection("Bugs")
      .doc(id)
      .set(bugList);
  }

  Future<Stream<QuerySnapshot>> getBugList()async{
    return await FirebaseFirestore.instance.collection("Bugs").snapshots();
  }
}