class Item {
  String id;
  String title;
  String body;

  Item.fromMap(Map<String, dynamic> map, String id)
      : id = id,
        title = map['title'] ?? '',
        body = map['body'] ?? '';

  Item({this.title, this.body});

  void copy(Item item) {
    id = item.id;
    title = item.title;
    body = item.body;
  }

  Item.clone(Item item)
      : id = item.id,
        title = item.title,
        body = item.body;

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
    };
  }
}
