class Diary {
  String title = '';
  String body = '';
  DateTime dateCreated = DateTime.now();
  Diary(this.title, this.body, this.dateCreated);

  Diary.fromMap(Map<String, dynamic> data) {
    title = data['title'];
    body = data['body'];
    dateCreated = DateTime.parse(data['dateCreated']);
  }
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
      'dateCreated': dateCreated.toString()
    };
  }
}
