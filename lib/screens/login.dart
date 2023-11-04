import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/auth_services.dart';
import 'home.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool loading=false;
  TextEditingController emailController = TextEditingController();

  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login Here"),
          centerTitle: true,
          backgroundColor: Colors.purpleAccent.shade100,
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            margin: EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Email",
              ),
              controller: emailController,
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Password",
              ),
              controller: passController,
            ),
          ),
          Container(
            height: 45,
            margin: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: ()async{

                setState(() {
                  loading=true;
                });
                if(emailController.text==""||passController.text=="") {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Fill the fields")));
                }
                else{
                  User? result= await Auth_service().Login(emailController.text, passController.text,context);
                  if(result!=null){
                    print("Success");
                   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Home(result)), (route) => false);
                  }
                }
                setState(() {
                  loading=false;
                });
              },
              child:loading? CircularProgressIndicator(): Text("Submit"),
            ),
          ),
        ]));
  }
}
