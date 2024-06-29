import 'package:firebase_core/firebase_core.dart';
import 'package:notes/firebase_options.dart';
import 'package:notes/services/auth_service.dart';
import 'package:get_it/get_it.dart';
import 'package:notes/services/data_service.dart';
import 'package:notes/services/media_service.dart';
import 'package:notes/services/storage_service.dart';
Future<void> setupFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
Future<void> registerService() async {
  final GetIt getIt = GetIt.instance;
  getIt.registerSingleton<AuthService>(
    AuthService(),
  );
  getIt.registerSingleton<DataService>(
    DataService(),
  );
  getIt.registerSingleton<MediaService>(
    MediaService(),
  );
  getIt.registerSingleton<StorageService>(
    StorageService(),
  );
}

String generateChatId({required String uid1, required String uid2}) {
  List uids=[uid1,uid2];
  uids.sort();
  String chatId = uids.fold("",(id,uid)=>"$id$uid");
  return chatId;
}