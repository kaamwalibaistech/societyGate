import 'package:society_gate/constents/local_storage.dart';
import 'package:society_gate/models/login_model.dart';

class UserDetails {
  static final UserDetails _instance = UserDetails._internal();
  factory UserDetails() => _instance;
  UserDetails._internal();

  LoginModel? loginModel;

  Future<void> loadLoginModel() async {
    loginModel = LocalStoragePref().getLoginModel();
  }

  String get loginType => loginModel?.user?.role ?? '';
  String get societyId => loginModel?.user?.societyId.toString() ?? "";
  String get userId => loginModel?.user?.userId.toString() ?? "";
  String get flatId => loginModel?.user?.flatId.toString() ?? "";
  String get userName => loginModel?.user?.uname.toString() ?? "";
  String get societyName =>
      loginModel?.user?.societyName ?? "".toString() ?? "";
  String get profilePhoto =>
      loginModel?.user?.profileImage ??
      "https://ui-avatars.com/api/?background=edbdff&name=$userName";

  bool get isAdmin => loginType.toLowerCase() == 'admin';
  bool get isMember => loginType.toLowerCase() == 'member';
  bool get isWatchman => loginType.toLowerCase() == 'watchman';
}

/*
How to use in any widget or BLoC:

final userManager = UserManager();
final societyId = userManager.societyId;
final flatId = userManager.flatId;
final isAdmin = userManager.isAdmin;
 */
