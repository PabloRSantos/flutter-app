import 'package:cointacao/repositories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../repositories/user_repository.dart';

class UserStore {
  final UserRepository userRepository;
  final AuthRepository authRepository;

  UserModel? _user;

  UserModel? get user => _user;

  UserStore({required this.userRepository, required this.authRepository});

  Future<void> fetchUser() async {
    var userId = _user?.id;
    if (userId == null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? storagedId = prefs.getString('userId');
      if (storagedId == null) return;

      userId = storagedId;
    }

    _user = await userRepository.getUser(userId);
  }

  Future<UserModel?> createUser(UserModel user) async {
    String? id = await authRepository.signUp(user.email, user.password);

    if (id == null) {
      throw Error();
    }

    user.id = id;
    await userRepository.create(user);

    _user = user;

    return _user;
  }

  Future<UserModel?> signIn(String email, String password) async {
    String? id = await authRepository.signIn(email, password);

    if (id == null) {
      throw Error();
    }

    _user = await userRepository.getUser(id);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', id);

    return _user;
  }
}
