import 'package:notes/model/bid_model.dart';
import 'package:notes/model/item_model.dart';

class AuctionModel {
  final String uid;
  final String auctioneerId;
  final List<ItemModel> items;
  final DateTime startTime;
  final DateTime endTime;


  AuctionModel({
    required this.uid,
    required this.auctioneerId,
    required this.items,
    required this.startTime,
    required this.endTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'auctioneerId': auctioneerId,
      'items': items.map((item) => item.toMap()).toList(),
      'startTime': startTime,
      'endTime': endTime,

    };
  }

  factory AuctionModel.fromMap(Map<String, dynamic> map) {
    return AuctionModel(
      uid: map['uid'] ?? "",
      auctioneerId: map['auctioneerId'] ?? "",
      items: List<ItemModel>.from(map['items']?.map((x) => ItemModel.fromMap(x))),
      startTime: DateTime.fromMillisecondsSinceEpoch(map['startTime']),
      endTime: DateTime.fromMillisecondsSinceEpoch(map['endTime']),

    );
  }
}
