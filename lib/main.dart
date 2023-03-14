import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:assignment1/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const MyLoginPage(title: 'My Login Page',)
    );
  }
}

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
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
            margin: const EdgeInsets.all(5.0),//outer
            padding: const EdgeInsets.all(5.0),//inner
            decoration: BoxDecoration(
                border: Border.all(color: Colors.red),
                borderRadius: BorderRadius.circular(5.0)),
            child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.center, 
                  children: [

              const Text('Username: '),
              const TextField(
                  decoration: InputDecoration(prefixIcon: Icon(Icons.person))),


              const SizedBox(height: 12),
              const Text('Password: '),
              const TextField(
                  obscureText: true,
                  decoration:
                      InputDecoration(prefixIcon: Icon(Icons.security))),
              const SizedBox(height: 12),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Home(),
                        ));
                  },
                  child: const Text('Login')),
            ]),
          ),
        ],
      ),
    );
  }
}