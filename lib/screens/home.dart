import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pro/modules/notes.dart';
import 'package:pro/screens/create.dart';
import 'package:pro/screens/edit.dart';
import 'package:pro/services/auth_services.dart';

class Home extends StatefulWidget {
  User user;
  Home(this.user);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirebaseFirestore firestore=FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
        centerTitle: true,
        actions: [TextButton(onPressed: ()async{
          await Auth_service().signOut();
        }, child: Text("Log Out"))],
      ),
      body:StreamBuilder(
        stream: FirebaseFirestore.instance.collection('notes').where('userid',isEqualTo: widget.user.uid).snapshots(),
        builder: (context,AsyncSnapshot sn){
          if(sn.hasData){
             if(sn.data.docs.length>0){
               return ListView.builder(
                   itemCount: sn.data.docs.length,
                   itemBuilder: (context,index){
                      NoteModule note =NoteModule.fromJson(sn.data.docs[index]);
                      return  Padding(
                        padding: const EdgeInsets.all(25),
                        child: Card(
                          child: ListTile(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>EditNote(note)));
                            },
                            title: Text(note.title),
                            subtitle: Text(note.des,overflow: TextOverflow.ellipsis,maxLines: 2,),
                            contentPadding: EdgeInsets.all(10),
                          ),
                        ),
                      );
               });
             }
          }
          return Center(
            child: Container(
              child: Text("No Notes Created",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w200,color: Colors.purple),),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateNote(widget.user)));
        },
      ),

    );
  }
}
