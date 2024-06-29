import 'package:notes/model/item_model.dart';

class BidModel {
  final String uid;
  final String ownerId;
  final double maxBid;
  final bool isEnded;
  final String lastBidder;
  final String item;
  final String state;

  BidModel({
    required this.uid,
    required this.ownerId,
    required this.maxBid,

    required this.isEnded,
    required this.lastBidder,
    required this.item,
    this.state = 'pending',
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'ownerId': ownerId,
      'maxBid': maxBid,
      'isEnded': isEnded,
      'lastBidder': lastBidder,
      'item': item,
      'state': state,
    };
  }

  factory BidModel.fromMap(Map<String, dynamic> map) {
    return BidModel(
      uid: map['uid'] ?? '',
      ownerId: map['ownerId'] ?? '',
      maxBid: map['maxBid'] ?? '',
      isEnded: map['isEnded'] ?? false,
      lastBidder: map['lastBidder'] ?? '',
      item: map['item'] ?? '',
      state: map['state'] ?? 'pending',
    );
  }
}
