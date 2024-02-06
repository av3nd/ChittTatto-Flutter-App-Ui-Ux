import 'package:chitto_tatto/config/router/app_routes.dart';
import 'package:chitto_tatto/core/shared_prefs/user_shared_prefs.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

final splashViewModelProvider = StateNotifierProvider<SplashViewModel, void>(
  (ref) {
    return SplashViewModel(
      ref.read(userSharedPrefsProvider),
    );
  },
);

class SplashViewModel extends StateNotifier<void> {
  final UserSharedPrefs _userSharedPrefs;
  SplashViewModel(this._userSharedPrefs) : super(null);

  init(BuildContext context) async {
    final data = await _userSharedPrefs.getUserToken();

    data.fold((l) => null, (token) {
      if (token != null) {
        bool isTokenExpired = isValidToken(token);

        String isuseradmin = isUser(token);

        if (isTokenExpired) {
// We will not do navigation like this,

// we will use mixin and navigator class for this

          Navigator.popAndPushNamed(context, AppRoute.loginRegister);
        } else {
          // Navigator.popAndPushNamed(context, AppRoute.homeRoute);

          if (isuseradmin == 'admin') {
            Navigator.popAndPushNamed(context, AppRoute.adminBottomBarRoute);
          } else {
            Navigator.popAndPushNamed(context, AppRoute.loginRegister);
          }
        }
      } else {
        Navigator.popAndPushNamed(context, AppRoute.loginRegister);
      }
    });
  }

  bool isValidToken(String token) {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

    // 10 digit
    int expirationTimestamp = decodedToken['exp'];
    // 13
    final currentDate = DateTime.now().millisecondsSinceEpoch;
    // If current date is greater than expiration timestamp then token is expired
    return currentDate > expirationTimestamp * 1000;
  }
}

String isUser(String token) {
  Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

// 10 digit

  String type = decodedToken['type'];

  return type;
}
