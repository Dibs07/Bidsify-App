

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:notes/model/bid_model.dart';
import 'package:notes/model/item_model.dart';
import 'package:notes/services/auth_service.dart';

class BidService{
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  late AuthService _authService;
  CollectionReference? items;
  CollectionReference? bids;
  void setUp() {
    items = _db.collection('items').withConverter<ItemModel>(
          fromFirestore: (snapshots, _) => ItemModel.fromMap(
            snapshots.data()!,
          ),
          toFirestore: (userProfile, _) => userProfile.toMap(),
        );
    bids = _db.collection('chats').withConverter<BidModel>(
          fromFirestore: (snapshots, _) => BidModel.fromMap(
            snapshots.data()!,
          ),
          toFirestore: (chat, _) => chat.toMap(),
        );
  }

  BidService(){
    setUp();
    _authService = GetIt.instance.get<AuthService>();
  }
  Future<void> createitem({required ItemModel item}) async {
    try {
      await items?.doc(item.uid).set(item);
    } catch (e) {
      print(e);
    }
  }

  Future<void> createbid({required BidModel bid}) async {
    try {
      await bids?.doc(bid.uid).set(bid);
    } catch (e) {
      print(e);
    }
  }
}