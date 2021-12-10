import 'package:flutter_architecture_model/flutter_architecture_model.dart';

abstract class UserService {
  Future<UserData> getDefaultUser();
  Future<UserData> getUserById(int id);
}
