import 'package:get_storage/get_storage.dart';

import '../model/scc_module_models/login_model.dart';

class Storage {
  static final box = GetStorage();

  static void clear() {
    box.erase();
  }

  static void setToken(String? token) {
    box.write(StorageKey.token, token);
  }

  static String? getToken() {
    return box.read(StorageKey.token);
  }

  static void setRole(String? role) {
    box.write(StorageKey.role, role);
  }

  static String? getRole() {
    return box.read(StorageKey.role);
  }
 static void setRoleType(List<String>? roleType) {
    box.write(StorageKey.roleType, roleType);
  }

  static List<String>? getRoleType() {
    final data = box.read(StorageKey.roleType);
    if (data == null) return null;
    return List<String>.from(data);
  }

  static void setUserId(String? id) {
    box.write(StorageKey.userId, id);
  }

  static String? getUserId() {
    return box.read(StorageKey.userId);
  }

  static void setUserData(User? data) {
    box.write(StorageKey.userData, data?.toJson());
  }

  static User? getUserData() {
    return User.fromJson(box.read(StorageKey.userData));
  }

  static void setName(String? name) {
    box.write(StorageKey.name, name);
  }

  static String? getName() {
    return box.read(StorageKey.name);
  }

  static void setPhone(int? phone) {
    box.write(StorageKey.phone, phone);
  }

  static int? getPhone() {
    return box.read(StorageKey.phone);
  }

  static void setProfilePic(String? picture) {
    box.write(StorageKey.picture, picture);
  }

  static String? getProfilePic() {
    return box.read(StorageKey.picture);
  }
}

class StorageKey {
  static const String token = "token";
  static const String role = "role";
  static const String roleType = "roleType";
  static const userId = "userId";
  static const userData = "userData";
  static const name = "name";
  static const phone = "phone";
  static const picture = "picture";
}
