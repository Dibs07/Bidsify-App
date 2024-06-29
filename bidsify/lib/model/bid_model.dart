import 'package:notes/model/item_model.dart';

class BidModel {
  final String uid;
  final double maxBid;
  final bool isEnded;
  final String lastBidder;
  final ItemModel item;


  BidModel({
    required this.uid,
    required this.maxBid,
    required this.isEnded,
    required this.lastBidder,
    required this.item,

  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,

      'maxBid': maxBid,
      'isEnded': isEnded,
      'lastBidder': lastBidder,
      'item': item,

    };
  }

  factory BidModel.fromMap(Map<String, dynamic> map) {
    return BidModel(
      uid: map['uid'] ?? '',

      maxBid: map['maxBid'] ?? '',
      isEnded: map['isEnded'] ?? false,
      lastBidder: map['lastBidder'] ?? '',
      item: map['item'] ?? '',

    );
  }
}
