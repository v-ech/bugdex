// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:bugdex/service/database.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class Survey extends StatefulWidget{
  const Survey({super.key});
  @override
  State<Survey> createState() => _SurveyState();
}

class _SurveyState extends State<Survey>{
  TextEditingController namecontroller = new TextEditingController();
  TextEditingController locationcontroller = new TextEditingController();
  TextEditingController typecontroller = new TextEditingController();
  TextEditingController notecontroller = new TextEditingController();
  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 221, 236, 125),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
        automaticallyImplyLeading: false,
        title: Text('Enter bug information'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
        
              Text("Name your bug!", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(), borderRadius: BorderRadius.circular(5),
                ),
                padding: EdgeInsets.only(left: 10),
                child: TextField(
                  decoration: InputDecoration(border: InputBorder.none),
                  controller: namecontroller,
                  onTapOutside: (PointerDownEvent event) {
                     FocusManager.instance.primaryFocus?.unfocus();
                  },
                ),
              ),
        
              SizedBox(height: 30,),
              Text("Where did you find it?", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(), borderRadius: BorderRadius.circular(5),
                ),
                padding: EdgeInsets.only(left: 10),
                child: TextField(
                  decoration: InputDecoration(border: InputBorder.none),
                  controller: locationcontroller,
                  onTapOutside: (PointerDownEvent event) {
                     FocusManager.instance.primaryFocus?.unfocus();
                  },
                ),
              ),
        
              SizedBox(height: 30,),
              Text("What type of bug?", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(), borderRadius: BorderRadius.circular(5),
                ),
                padding: EdgeInsets.only(left: 10),
                child: TextField(
                  decoration: InputDecoration(border: InputBorder.none),
                  controller: typecontroller,
                  onTapOutside: (PointerDownEvent event) {
                     FocusManager.instance.primaryFocus?.unfocus();
                  },
                ),
              ),
        
              SizedBox(height: 30,),
              Text("Other notes?", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(), borderRadius: BorderRadius.circular(5),
                ),
                padding: EdgeInsets.only(left: 10),
                child: TextField(
                  decoration: InputDecoration(border: InputBorder.none),
                  controller: notecontroller,
                  onTapOutside: (PointerDownEvent event) {
                     FocusManager.instance.primaryFocus?.unfocus();
                  },
                ),
              ),
        
              SizedBox(height: 30,),
              Center(
                child: FloatingActionButton.extended(
                  onPressed: () async {
                    String id = randomAlphaNumeric(10);
                    Map<String, dynamic> bugSubmission={
                      "Description": notecontroller.text,
                      "Location": locationcontroller.text,
                      "Name": namecontroller.text,
                      "Type": typecontroller.text,
                      "Id":id,
                    };
                    await DatabaseMethod().addBug(bugSubmission, id).then((value) => Navigator.of(context).pop());
                  },
                  backgroundColor: Color.fromARGB(255, 166, 201, 70),
                  label: Text('Submit', style: TextStyle(color: Color.fromARGB(255, 221, 236, 125)),),
                  ),
                ),
            ]
          )
        ),
      ),
    );
  }
}