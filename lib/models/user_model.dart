class UserModel {
  String? id;
  final String name;
  final String email;
  final String password;
  final String phone;
  final String birthday;
  List<String> coins;

  UserModel(
      {this.id,
      required this.name,
      required this.email,
      required this.password,
      required this.phone,
      required this.birthday,
      required this.coins});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'birthday': birthday,
      'coins': coins
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map, String documentId) {
    return UserModel(
        id: documentId,
        name: map['name'] ?? '',
        email: map['email'] ?? '',
        phone: map['phone'] ?? 0,
        birthday: map['birthday'] ?? '',
        coins: List<String>.from(map['coins'] ?? []),
        password: '');
  }

  pushCoin(String coinCode) {
    if (!coins.contains(coinCode)) {
      coins.add(coinCode);
    }
  }
}
