class Item {
  String? title;
  String? price;
  String? subtitle;
  String? describe;
  String? thumbnail;
  List<String>? ingredient;
  List<String>? meaning;

  Item(
      {this.title,
      this.price,
      this.subtitle,
      this.describe,
      this.thumbnail,
      this.ingredient,
      this.meaning});

  Item.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    price = json['price'];
    subtitle = json['subtitle'];
    describe = json['describe'];
    thumbnail = json['thumbnail'];
    ingredient = json['ingredient'].cast<String>();
    meaning = json['meaning'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['price'] = price;
    data['subtitle'] = subtitle;
    data['describe'] = describe;
    data['thumbnail'] = thumbnail;
    data['ingredient'] = ingredient;
    data['meaning'] = meaning;
    return data;
  }
}
