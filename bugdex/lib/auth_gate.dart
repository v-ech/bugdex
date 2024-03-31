// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class AuthGate extends StatelessWidget{
  const AuthGate({super.key});
  @override
  Widget build(BuildContext context){
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot){
        if(!snapshot.hasData){
          return SignInScreen(
            providers: [
              EmailAuthProvider(),
            ],
            headerBuilder: (context, constraints, shrinkOffset) {
              return Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 235, 246, 163),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: Text('bugdex',
                      style: TextStyle(
                        fontSize: 30,
                        letterSpacing: 5,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 99, 140, 48)
                      ),
                    ),
                  ),
                )
              );
            },
          );
        }
        return const Home();
      }
    );
  }
}


