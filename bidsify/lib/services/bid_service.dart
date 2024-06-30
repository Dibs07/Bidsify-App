import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:notes/model/bid_model.dart';
import 'package:notes/model/item_model.dart';
import 'package:notes/services/auth_service.dart';

class BidService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  late AuthService _authService;
  CollectionReference? items;
  CollectionReference? bids;
  void setUp() {
    items = _db.collection('items').withConverter<ItemModel>(
          fromFirestore: (snapshots, _) => ItemModel.fromMap(
            snapshots.data()!,
          ),
          toFirestore: (item, _) => item.toMap(),
        );
    bids = _db.collection('bids').withConverter<BidModel>(
          fromFirestore: (snapshots, _) => BidModel.fromMap(
            snapshots.data()!,
          ),
          toFirestore: (bid, _) => bid.toMap(),
        );
  }

  BidService() {
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

  Stream<QuerySnapshot<ItemModel>> getItems() {
    return items!
        .where('ownerId', isNotEqualTo: _authService.user!.uid)
        .snapshots() as Stream<QuerySnapshot<ItemModel>>;
  }

  Stream<QuerySnapshot<ItemModel>> getItemsbyownerid(
      ) {
    return items!.where('ownerId', isEqualTo: _authService.user!.uid).snapshots()
        as Stream<QuerySnapshot<ItemModel>>;
  }

  Stream<List<BidModel>> getallBids() {
    return bids!
        .where('ownerId', isNotEqualTo: _authService.user!.uid)
        .snapshots() as Stream<List<BidModel>>;
  }

  Stream<QuerySnapshot<BidModel>> getBidsbyownerID() {
    return bids!.where('ownerId', isEqualTo: _authService.user!.uid).snapshots()
        as Stream<QuerySnapshot<BidModel>>;
  }

  Future<bool> updateItem ({required ItemModel item}) async {
    try {
      await items?.doc(item.uid).update(item.toMap());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
