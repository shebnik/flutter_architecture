import 'package:flutter_architecture_data/src/api/services.dart';
import 'package:flutter_architecture_model/flutter_architecture_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: UserService)
class DummyUserService implements UserService {
  @override
  Future<UserData> getDefaultUser() async {
    await Future.delayed(
      const Duration(
        seconds: 3,
      ),
    );

    return const UserData(id: 1, name: 'Default');
  }

  @override
  Future<UserData> getUserById(int id) async {
    await Future.delayed(
      const Duration(
        seconds: 3,
      ),
    );

    return UserData(id: id, name: 'User id $id');
  }
}
