import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  //Future async and await inside flutter
  //asynchronous function
  Future login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      const alert = AlertDialog(
        title: Text("ERROR Sign In "),
        content: Text("Wrong email or password."),
      );
      //Navigator & Retrieve theme data & Overlay
      return showDialog(context: context, builder: (context) => alert);
    }
  }

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('LOGIN TO YOUR APP',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30)),
          const SizedBox(height: 30),
          Container(
            margin: const EdgeInsets.all(5.0), //outer
            padding: const EdgeInsets.all(5.0), //inner
            decoration: BoxDecoration(
                border: Border.all(color: Colors.lightBlueAccent),
                borderRadius: BorderRadius.circular(5.0)),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text('Email: '),
              TextField(
                decoration:
                    const InputDecoration(prefixIcon: Icon(Icons.person)),
                controller: _emailController,
              ),
              const SizedBox(height: 12),
              const Text('Password: '),
              TextField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration:
                      const InputDecoration(prefixIcon: Icon(Icons.security))),
              const SizedBox(height: 12),
              Row (mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(onPressed: login, child: const Text('Login')),
              ElevatedButton(onPressed: signInWithGoogle, child: const Text('Login with GOOGLE'),),
              ])
            ]),
          ),
        ],
      ),
    );
  }
}
