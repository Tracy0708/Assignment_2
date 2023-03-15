import 'package:assignment1/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class Authentication extends StatefulWidget {
  const Authentication({super.key});

  @override
  State <Authentication> createState() =>  AuthenticationState();
}

class AuthenticationState extends State <Authentication> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges()
        ,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return const Home();
          } else {
            return const MyLoginPage(
              title : 'My Login Page'
            );
          }
        })));
  }
}