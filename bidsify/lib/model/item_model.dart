class ItemModel {
  final String uid;
  final String name;
  final String descrription;
  final String ownerId;
  final String itemPic;

  ItemModel({
    required this.uid,
    required this.name,
    required this.descrription,
    required this.ownerId,
    required this.itemPic,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'description': descrription,
      'ownerId': ownerId,
      'itemPic': itemPic,
    };
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      uid: map['uid'] ?? "",
      name: map['name'] ?? "",
      descrription: map['descrription'] ?? "",
      ownerId: map['ownerId'] ?? "",
      itemPic: map['itemPic'] ?? "",
    );
  }
}
