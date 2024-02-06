import 'package:chitto_tatto/config/router/app_routes.dart';
import 'package:chitto_tatto/config/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Student App',
//       initialRoute: AppRoute.splashRoute,
//       routes: AppRoute.getAppRoutes(),
//       theme: AppTheme.getApplicationTheme(),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return KhaltiScope(
        publicKey: "test_public_key_81a307a56ad84e49a71e027c3f6e3dab",
        enabledDebugging: true,
        builder: (context, navKey) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Student App',
            initialRoute: AppRoute.splashRoute,
            routes: AppRoute.getAppRoutes(),
            theme: AppTheme.getApplicationTheme(),
            navigatorKey: navKey,
            localizationsDelegates: const [
              KhaltiLocalizations.delegate,
            ],
          );
        });
  }
}
