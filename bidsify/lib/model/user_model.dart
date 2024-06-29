class UserModel {
  final String? uid;
  final String? name;
  final String? email;
  final String profilePic;
  // final List<String> preferences;
  final String? phoneNumber;
  // final

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.profilePic,
    // required this.preferences,
    required this.phoneNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'profilePic': profilePic,
      // 'preferences': preferences,
      'phoneNumber': phoneNumber,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      profilePic: map['profilePic'] ?? '',
      // preferences: List<String>.from(map['preferences']),
      phoneNumber: map['phoneNumber'] ?? "",
    );
  }
}
