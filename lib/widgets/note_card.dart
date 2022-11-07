import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget noteCard(Function()? onTap, QueryDocumentSnapshot doc) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Color.fromARGB(255, 196, 228, 255),
        border: Border.all(color: Colors.deepPurple, width: 3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            doc["note_title"],
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color.fromARGB(255, 110, 64, 47)),
          ),
          Text(
            doc["creation_date"],
            style: const TextStyle(color: Color.fromARGB(255, 110, 64, 47)),
          ),
          const SizedBox(height: 20),
          Text(
            doc["note_content"],
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Color.fromARGB(255, 0, 71, 195)),
          ),
        ],
      ),
    ),
  );
}
