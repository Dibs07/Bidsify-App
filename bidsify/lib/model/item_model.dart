import 'package:notes/model/bid_model.dart';

class ItemModel {
  final String uid;
  final String name;
  final String descrription;
  final String ownerId;
  final String? itemPic;
  late double? price;
  late String lastBid;
  final List<BidModel> bids;
  late bool? isSold;

  ItemModel({
    required this.uid,
    required this.name,
    required this.descrription,
    required this.ownerId,
    required this.price,
    required this.bids,
    required this.lastBid,
    this.isSold=false,
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
      'bids': bids.map((bid) => bid.toMap()).toList(),
      'lastBid': lastBid,
      'isSold': isSold,
      
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
      lastBid: map['lastBid'] ?? "",
      bids: List<BidModel>.from(map['bids']?.map((x) => BidModel.fromMap(x))),
      isSold: map['isSold'] ?? false,
    );
  }
}
