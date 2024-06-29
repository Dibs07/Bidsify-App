class UserModel {
  final String uid;
  final String name;
  final String email;
  final String profilePic;
  final int balance;
  final List<String> preferences;
  final String phoneNumber;
  // final

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.profilePic,
    required this.balance,
    required this.preferences,
    required this.phoneNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'profilePic': profilePic,
      'balance': balance,
      'preferences': preferences,
      'phoneNumber':phoneNumber,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      profilePic: map['profilePic'] ?? '',
      balance: map['balance'] ?? false,
      preferences: List<String>.from(map['preferences']),
      phoneNumber: map['phoneNumber']
    );
  }
}
