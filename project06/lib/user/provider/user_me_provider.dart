import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project06/common/const/data.dart';
import 'package:project06/common/provider/secure_storage_provider.dart';
import 'package:project06/user/model/user_model.dart';
import 'package:project06/user/provider/user_me_repository_provider.dart';
import 'package:project06/user/repository/auth_repository.dart';
import 'package:project06/user/repository/user_me_repository.dart';

final userMeProvider = StateNotifierProvider<UserMeStateNotifier, UserModelBase?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final userMeRepository = ref.watch(userMeRepositoryProvider);
  final storage = ref.watch(secureStorageProvider);
  return UserMeStateNotifier(authRepository: authRepository, userMeRepository: userMeRepository, storage: storage);
});

class UserMeStateNotifier extends StateNotifier<UserModelBase?> {
  final AuthRepository authRepository;
  final UserMeRepository userMeRepository;
  final FlutterSecureStorage storage;

  UserMeStateNotifier(
      {required this.authRepository,
      required this.userMeRepository,
      required this.storage})
      : super(UserModelLoading()) {
    getMe();
  }

  Future<void> getMe() async {
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    if (refreshToken == null || accessToken == null) {
      state = null;
      return;
    }

    final response = await userMeRepository.getMe();
    state = response;
  }

  Future<UserModelBase> login(
      {required String username, required String password}) async {
    state = UserModelLoading();
    try {
      final response =
          await authRepository.login(username: username, password: password);

      // AT와 RT를 storage에 저장하기
      await storage.write(key: ACCESS_TOKEN_KEY, value: response.accessToken);
      await storage.write(key: REFRESH_TOKEN_KEY, value: response.refreshToken);

      // 내 AT를 보내서 내 정보를 줘
      final userResponse = await userMeRepository.getMe();

      // 내 정보 저장
      state = userResponse;
      return userResponse;
    } catch (err) {
      state = UserModelError(message: err.toString());
      return Future.value(state);
    }
  }

  Future<void> logout() async {
    state = null;

    await Future.wait([
      storage.delete(key: REFRESH_TOKEN_KEY),
      storage.delete(key: ACCESS_TOKEN_KEY)
    ]);
  }
}
