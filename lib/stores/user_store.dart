import 'package:cointacao/repositories/auth_repository.dart';
import '../models/user_model.dart';
import '../repositories/user_repository.dart';

class UserStore {
  final UserRepository userRepository;
  final AuthRepository authRepository;

  UserModel? _user;

  UserModel? get user => _user;

  UserStore({required this.userRepository, required this.authRepository});

  Future<void> fetchUser(String userId) async {
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

    return _user;
  }
}
