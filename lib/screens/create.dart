import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pro/services/firestore_services.dart';

class CreateNote extends StatefulWidget {
  User user;
  CreateNote(this.user);

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  TextEditingController title=TextEditingController();
  TextEditingController des=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Note"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("TITLE:"),
              TextField(
                controller: title,
                decoration: InputDecoration(
                  border: OutlineInputBorder()
                ),
              ),
              Text("Description:"),
              TextField(
                controller: des,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                minLines: 5,
                maxLines: 10,
              ),
              SizedBox(height: 25,),
              Center(child: ElevatedButton(onPressed: ()async{
                if(title.text=="" || des.text==""){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Fill the fields")));
                }
                else{
                  await Firestore_service().CreateNotes(title.text, des.text, widget.user.uid);
                  Navigator.pop(context);
                }
              }, child: Text("Create Note")))
            ],
          ),
        ),
      ),
    );
  }
}
