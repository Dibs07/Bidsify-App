import 'package:notes/model/item_model.dart';

class BidModel {
  final String uid;
  final String ownerId;
  final double maxBid;
  final DateTime startTime;
  final DateTime endTime;
  final bool isEnded;
  final String lastBidder;
  final ItemModel item;

  BidModel({
    required this.uid,
    required this.endTime,
    required this.ownerId,
    required this.maxBid,
    required this.startTime,
    required this.isEnded,
    required this.lastBidder,
    required this.item,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'ownerId': ownerId,
      'maxBid': maxBid,
      'startTime': startTime,
      'endTime': endTime,
      'isEnded': isEnded,
      'lastBidder': lastBidder,
      'item': item.toMap(),
    };
  }

  factory BidModel.fromMap(Map<String, dynamic> map) {
    return BidModel(
      uid: map['uid'] ?? '',
      ownerId: map['ownerId'] ?? '',
      maxBid: map['maxBid'] ?? '',
      startTime: DateTime.fromMillisecondsSinceEpoch(map['startTime']),
      endTime: DateTime.fromMillisecondsSinceEpoch(map['endTime']),
      isEnded: map['isEnded'] ?? false,
      lastBidder: map['lastBidder'] ?? '',
      item: ItemModel.fromMap(map['item']),
    );
  }
}
