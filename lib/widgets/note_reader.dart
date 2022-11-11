// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';

class NoteReaderScreen extends StatefulWidget {
  QueryDocumentSnapshot doc;
  NoteReaderScreen({
    Key? key,
    required this.doc,
  }) : super(key: key);

  @override
  State<NoteReaderScreen> createState() => _NoteReaderScreenState();
}

class _NoteReaderScreenState extends State<NoteReaderScreen> {
  bool _loading = false;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _titleController.text = widget.doc["note_title"];
    _contentController.text = widget.doc["note_content"];
    // print(widget.doc.id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const BackButton(color: Colors.brown),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Padding(
              padding: EdgeInsets.only(top: 5.0),
              child: Icon(
                Icons.image,
                color: Colors.brown,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _loading = true;
              });
              FirebaseFirestore.instance
                  .collection("notes")
                  .doc(widget.doc.id)
                  .update({
                "note_title": _titleController.text,
                "note_content": _contentController.text,
              }).then((value) {
                print("Updated");
              }).onError((error, stackTrace) {
                setState(() {
                  _loading = false;
                });
                print(error.toString());
              });
              print(widget.doc);
              Navigator.of(context).pop();
            },
            icon: const Padding(
              padding: EdgeInsets.only(top: 5),
              child: Icon(
                Icons.done,
                color: Colors.brown,
                size: 35,
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: _titleController,
                        style: const TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 110, 64, 47),
                        ),
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                      ),
                      Text(
                        widget.doc["creation_date"],
                        style: const TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 110, 64, 47),
                        ),
                      ),
                      const SizedBox(height: 30),
                      SingleChildScrollView(
                        child: TextField(
                          controller: _contentController,
                          maxLines: null,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 109, 32, 5),
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _loading = true;
          });
          FirebaseFirestore.instance
              .collection("notes")
              .doc(widget.doc.id)
              .delete()
              .then((value) {
            Utils().toastMessage("Note Deleted");
            Navigator.of(context).pop();
          }).onError((error, stackTrace) {
            setState(() {
              _loading = false;
            });
            Utils().toastMessage("Note not deleted.");
          });
        },
        child: const Icon(Icons.delete),
      ),
    );
  }
}
