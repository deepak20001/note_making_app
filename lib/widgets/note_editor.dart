import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_making_app/utils/utils.dart';
import 'package:intl/intl.dart';

class NoteEditorScreen extends StatefulWidget {
  const NoteEditorScreen({super.key});

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  bool _loading = false;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contetController = TextEditingController();
  String date = DateFormat("yyyy-MM-dd kk:mm:ss").format(DateTime.now());

  @override
  void dispose() {
    // TODO: implement dispose
    _titleController.dispose();
    _contetController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const BackButton(color: Colors.brown),
        elevation: 0,
        title: const Text(
          "Add a new Note",
          style: TextStyle(
            color: Color.fromARGB(255, 2, 65, 117),
            fontSize: 35,
          ),
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Note Title",
                      ),
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 110, 64, 47),
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      date,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 110, 64, 47),
                      ),
                    ),
                    const SizedBox(height: 28.0),
                    TextField(
                      controller: _contetController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Note Content",
                      ),
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 109, 32, 5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          String str1 = _titleController.text;
          String str2 = _contetController.text;
          if (str1 != "" && str2 != "") {
            setState(() {
              _loading = true;
            });
            FirebaseFirestore.instance.collection("notes").add({
              "note_title": _titleController.text,
              "creation_date": date,
              "note_content": _contetController.text,
            }).then((value) {
              print(value.id);
              Utils().toastMessage("Note Added");

              Navigator.pop(context);
            }).onError((error, stackTrace) {
              _loading = false;
              Utils().toastMessage("Failed to add note");
            });
          } else {
            Utils().toastMessage("Note not filled properly.");
          }
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
