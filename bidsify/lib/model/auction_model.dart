import 'package:notes/model/bid_model.dart';

class AuctionModel {
  final String auctioneerId;
  final List<BidModel> bids;
  final DateTime startTime;
  final DateTime endTime;
  final String itemId;

  AuctionModel({
    required this.auctioneerId,
    required this.bids,
    required this.startTime,
    required this.endTime,
    required this.itemId,
  });

  Map<String, dynamic> toMap() {
    return {
      'auctioneerId': auctioneerId,
      'bids': bids,
      'startTime': startTime,
      'endTime': endTime,
      'itemId': itemId
    };
  }

  factory AuctionModel.fromMap(Map<String, dynamic> map) {
    return AuctionModel(
      auctioneerId: map['auctioneerId'] ?? "",
      bids: map['bids'] ?? "",
      startTime: DateTime.fromMillisecondsSinceEpoch(map['startTime']),
      endTime: DateTime.fromMillisecondsSinceEpoch(map['endTime']),
      itemId: map['itemId'] ?? "",
    );
  }
}
