import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pro/screens/home.dart';
import 'package:pro/screens/register.dart';
import 'package:pro/services/auth_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Firebase',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  StreamBuilder(
          stream: Auth_service().auth.authStateChanges(),
          builder: (context,AsyncSnapshot snaphot){
            if(snaphot.hasData){
              return Home(snaphot.data);
            }
            return Register();
          }
      ),
    );
  }
}
