
import 'package:flutter/material.dart';
import '../model/notes_model.dart';

class EditNotesScreen extends StatefulWidget {
  final NotesModel notes;
  const EditNotesScreen({super.key, required this.notes});

  @override
  State<StatefulWidget> createState() => _EditNotesScreenState();
}

class _EditNotesScreenState extends State<EditNotesScreen> {
  late TextEditingController titleController = TextEditingController();
  late TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(text: widget.notes.title);
    messageController = TextEditingController(text: widget.notes.message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Update Notes",
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 8, right: 10),
            child: TextField(
              controller: titleController,
              minLines: 1,
              maxLines: 2,
              autofocus: true,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              decoration: const InputDecoration(
                hintText: "Write Title",
                border: InputBorder.none,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 10),
            child: SizedBox(
              height: 320,
              child: TextField(
                controller: messageController,
                minLines: 1,
                maxLines: 10,
                style: const TextStyle(fontSize: 20),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Write Notes",
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: const BorderSide(width: 2, color: Colors.red))),
                  child: const Text("Cancel")),
              ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          ) , backgroundColor: Colors.greenAccent),
                  child: const Text("Update")),
            ],
          )
        ],
      ),
    );
  }
}
