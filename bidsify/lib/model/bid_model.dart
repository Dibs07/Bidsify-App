class BidModel {
  final String ownerId;
  final double maxBid;
  final DateTime startTime;
  final DateTime endTime;
  final bool isEnded;
  final String lastBidder;

  BidModel({
    required this.endTime,
    required this.ownerId,
    required this.maxBid,
    required this.startTime,
    required this.isEnded,
    required this.lastBidder,
  });

  Map<String, dynamic> toMap() {
    return {
      'ownerId': ownerId,
      'maxBid': maxBid,
      'startTime': startTime,
      'endTime': endTime,
      'isEnded': isEnded,
      'lastBidder': lastBidder
    };
  }

  factory BidModel.fromMap(Map<String, dynamic> map) {
    return BidModel(
      ownerId: map['uid'] ?? '',
      maxBid: map['name'] ?? '',
      startTime: DateTime.fromMillisecondsSinceEpoch(map['startTime']),
      endTime: DateTime.fromMillisecondsSinceEpoch(map['endTime']),
      isEnded: map['balance'] ?? false,
      lastBidder: map['lastBidder'] ?? '',
    );
  }
}
