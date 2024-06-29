import 'package:notes/model/bid_model.dart';

class ItemModel {
  final String uid;
  final String name;
  final String descrription;
  final String ownerId;
  final String? itemPic;
  final double price;
  final List<BidModel> bids;

  ItemModel({
    required this.uid,
    required this.name,
    required this.descrription,
    required this.ownerId,
    required this.price,
    required this.bids,
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
      'bids': bids,
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
       bids: (map['bids'] as List<dynamic>)
          .map((bid) => BidModel.fromMap(bid as Map<String, dynamic>))
          .toList(),
    );
  }
}
