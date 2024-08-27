class NotesModel {
  final int? id;
  final String title;
  final String message;

  // Constructor
  NotesModel({this.id, required this.message, required this.title});

  //   to map
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "message": message,
    };
  }

//   from map

  factory NotesModel.fromMap(Map<String, dynamic> map) {
    return NotesModel(
        id: map['id'], message: map['message'], title: map['title']);
  }
}
