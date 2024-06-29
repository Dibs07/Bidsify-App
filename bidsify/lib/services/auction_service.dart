import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:notes/model/auction_model.dart';
import 'package:notes/model/bid_model.dart';
import 'package:notes/model/item_model.dart';
import 'package:notes/services/auth_service.dart';

class AuctionService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  late AuthService _authService;
  CollectionReference? auctions;
  void setUp() {
    auctions = _db.collection('auctions').withConverter<AuctionModel>(
          fromFirestore: (snapshots, _) => AuctionModel.fromMap(
            snapshots.data()!,
          ),
          toFirestore: (auction, _) => auction.toMap(),
        );
  }

  AuctionService() {
    setUp();
    _authService = GetIt.instance.get<AuthService>();
  }

  Future<void> createitem({required AuctionModel auction}) async {
    try {
      
      await auctions?.doc(auction.uid).set(auction);
    } catch (e) {
      print(e);
    }
  }

  
}
