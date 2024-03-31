// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:bugdex/service/database.dart';
import 'package:bugdex/survey.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';



class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Stream? bugStream;
  onLoad()async{
    bugStream=await DatabaseMethod().getBugList();
    setState(() {
      
    });
  }

  @override
  void initState() {
    onLoad();
    super.initState();
  }

  Widget allBugInfo(){
    return StreamBuilder(
      stream: bugStream,
      builder: (context, AsyncSnapshot snapshot){
      return snapshot.hasData
      ? ListView.builder(
        itemCount: snapshot.data.docs.length,
        itemBuilder: (context, index){
        DocumentSnapshot ds=snapshot.data.docs[index];
        return Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Material(
             
              elevation: 2,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name: '+ds["Name"], style: TextStyle(color: Color.fromARGB(255, 103, 112, 23), fontSize: 20, fontWeight: FontWeight.bold),),
                    Text('Type: '+ds["Type"], style: TextStyle(color: Color.fromARGB(255, 106, 129, 40), fontSize: 15),),
                    Text('Location: '+ds["Location"], style: TextStyle(color: Color.fromARGB(255, 106, 129, 40), fontSize: 15),),
                    Text('Notes: '+ds["Description"], style: TextStyle(color: Color.fromARGB(255, 106, 129, 40), fontSize: 15),),
          
                  ],
                ),
              ),
            ),
        );
      })
      : Container();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Survey()));
      },
        backgroundColor: Color.fromARGB(255, 166, 201, 70),
        child: Icon(Icons.add, color: Color.fromARGB(255, 255, 255, 255),),
      ),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 221, 236, 125),
        leading: IconButton(
          icon: const Icon(Icons.logout),
          onPressed: (){
            signOut();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<ProfileScreen>(
                  builder: (context) => ProfileScreen(
                    actions: [
                      SignedOutAction((context) {
                        Navigator.of(context).pop();
                      })
                    ],
                  ),
                ),
              );
            },
          )
        ],
        automaticallyImplyLeading: false,
        title: Text('Bugs observed'),
        centerTitle: true,
      ),
     body: Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Expanded(child: allBugInfo()),
        ],
      ),
     ),
    );
  }
}

// class BugList extends StatefulWidget{
//   const BugList({Key? key}) : super(key: key);
//   @override
//   _BugListState createState() => _BugListState();
// }

// class _BugListState extends State<BugList>{

// }


signOut() async {
  await FirebaseAuth.instance.signOut();
}