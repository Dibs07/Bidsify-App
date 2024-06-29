class ItemModel {
  final String uid;
  final String name;
  final String descrription;
  final String ownerId;
  final String? itemPic;
  final double? price;

  ItemModel({
    required this.uid,
    required this.name,
    required this.descrription,
    required this.ownerId,
    required this.price,
    this.itemPic,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'description': descrription,
      'ownerId': ownerId,
      'itemPic': itemPic,
      'price': price,
    };
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      uid: map['uid'] ?? "",
      name: map['name'] ?? "",
      descrription: map['descrription'] ?? "",
      ownerId: map['ownerId'] ?? "",
      itemPic: map['itemPic'] ?? "",
      price: map['price'] ?? 0.0,
    );
  }
}
