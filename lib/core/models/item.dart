class Item {
  String id;
  String title;
  String body;

  Item.fromMap(Map<String, dynamic> map, String id)
      : id = id,
        title = map['title'] ?? '',
        body = map['body'] ?? '';

  Item({this.title, this.body});

  toJson() {
    return {
      'title': title,
      'body': body,
    };
  }
}
