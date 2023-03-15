import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
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
              ElevatedButton(onPressed: login, child: const Text('Login')),
            ]),
          ),
        ],
      ),
    );
  }
}
