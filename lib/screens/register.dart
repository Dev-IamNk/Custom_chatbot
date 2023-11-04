
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pro/screens/home.dart';
import 'package:pro/screens/login.dart';
import 'package:pro/services/auth_services.dart';

class Register extends StatefulWidget {
   Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
   TextEditingController emailController =TextEditingController();

  TextEditingController passController=TextEditingController();

   TextEditingController confirmPassword=TextEditingController();

  bool loading=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register Here"),
        centerTitle: true,
        backgroundColor: Colors.purpleAccent.shade100,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 250,
            margin: EdgeInsets.all(20),
            child:  ElevatedButton(
                onPressed: () async{
                  setState(() {
                    loading=true;
                  });
                  await Auth_service().signInWithGoogle();
                  setState(() {
                    loading=false;
                  });

                }, child: Row(
              children: [
                Image.network("https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-512.png",width: 25,height: 50,),
                loading? Container(
                    margin: EdgeInsets.only(left: 60),
                    child: CircularProgressIndicator()): Center(child: Text("Continue with Google"))
              ],
            )),
          ),
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
            margin: EdgeInsets.all(10),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Confirm Password",
              ),
              controller: confirmPassword,
            ),
          ),

         loading? CircularProgressIndicator(): Container(
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
                else if(passController.text!=confirmPassword.text){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Password doesnt match with confirm password")));
                }
                  else{
                 User? result= await Auth_service().Register(emailController.text, passController.text,context);
                 if(result!=null){
                   print("Success");
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Home(result)), (route) => false);
                 }
                }
                setState(() {
                  loading=false;
                });
              },
              child: Text("Submit"),
            ),
          ),
          SizedBox(height: 30),
          TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) =>Login() ));
          }, child: Text("Already have an account? Login here"))

        ],
      ),
    );
  }
}
