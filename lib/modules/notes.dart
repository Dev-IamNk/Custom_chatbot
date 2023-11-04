import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModule{
  String id;
  String title;
  String des;
  String userid;
  NoteModule({
    required this.id,
    required this.title,
    required this.des,
    required this.userid,
});
  factory NoteModule.fromJson(DocumentSnapshot snapshot){
    return NoteModule(id: snapshot.id, title: snapshot['title'], des: snapshot['des'], userid: snapshot['userid']);
  }
}