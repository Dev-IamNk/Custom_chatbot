import 'package:flutter/material.dart';
import 'package:pro/modules/notes.dart';
import 'package:pro/services/firestore_services.dart';

class EditNote extends StatefulWidget {
  NoteModule note;
  EditNote(this.note);

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  TextEditingController title=TextEditingController();
  TextEditingController des=TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    title.text=widget.note.title;
    des.text=widget.note.des;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Note"),
        actions: [IconButton(icon: Icon(Icons.delete),onPressed: ()async{
          await showDialog(
            context: context,
            builder: (context)=>AlertDialog(

            title: Text("Are you sure?"),
            content: Text("Do you want to delete this note?"),
            actions: [
              TextButton(onPressed: ()async{
                Firestore_service().DeleteNote(widget.note.id);
                Navigator.pop(context);
                Navigator.pop(context);
              }, child: Text("Yes")),
              TextButton(onPressed: (){

                Navigator.pop(context);
              }, child: Text("No")),
            ],
            )
          );
        },)],
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
                await Firestore_service().UpdateNotes(widget.note.id, title.text, des.text);
                Navigator.pop(context);
              }, child: Text("Update Note")))
            ],
          ),
        ),
      ),
    );
  }
}
