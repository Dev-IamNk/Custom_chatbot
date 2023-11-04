import 'package:cloud_firestore/cloud_firestore.dart';

class Firestore_service{
  FirebaseFirestore firestore=FirebaseFirestore.instance;

  Future CreateNotes(String title,String des,String userid)async{
    try{
      await firestore.collection('notes').add({
        'title':title,
        'des':des,
        'userid':userid
      });
    }
    catch(e){

    }
  }
  Future UpdateNotes(String docid,String title,String des)async {
    try {
      await firestore.collection('notes').doc(docid).update({
        'title':title,
        'des':des
      });
    }
    catch (e) {

    }
  }
  Future DeleteNote(String docid)async {
    try {
      await firestore.collection('notes').doc(docid).delete();
    }
    catch (e) {

    }
  }

}