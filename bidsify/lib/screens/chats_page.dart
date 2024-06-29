
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:notes/constants/chattile.dart';
import 'package:notes/model/user_model.dart';
import 'package:notes/screens/chat_page.dart';
import 'package:notes/services/auth_service.dart';
import 'package:notes/services/data_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GetIt _getIt = GetIt.instance;
  late AuthService _authService;
  late DataService _dataService;
  @override
  void initState() {
    super.initState();
    _authService = _getIt.get<AuthService>();

    _dataService = _getIt.get<DataService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chats"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          
        ],
      ),
      body: uiBuild(),
    );
  }

  Widget uiBuild() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 20.0,
        ),
        child: _chatsList(),
      ),
    );
  }

  Widget _chatsList() {
    return StreamBuilder(
      stream: _dataService.getUsers(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text("Unable to load"),
          );
        }
        if (snapshot.hasData && snapshot.data != null) {
          final users = snapshot.data!.docs;
          return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                UserModel userProfile = users[index].data();
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Chattile(
                    userProfile: userProfile,
                    ontap: () async {
                      final chatexists = await _dataService.checkChatexists(
                        _authService.user!.uid,
                        userProfile.uid!,
                      );
                      if (chatexists) {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatPage(
                              user: userProfile,
                            ),
                          ),
                        );
                      } else {
                        await _dataService.createChat(
                          _authService.user!.uid,
                          userProfile.uid!,
                        );
                      }
                    },
                  ),
                );
              });
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class NavigationService {
}