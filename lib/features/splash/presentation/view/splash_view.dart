import 'package:chitto_tatto/config/router/app_routes.dart';
import 'package:chitto_tatto/features/splash/presentation/viewmodel/splash_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.popAndPushNamed(context, AppRoute.loginRegister);
      ref.read(splashViewModelProvider.notifier).init(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 300,
                  width: 300,
                  child: ColorFiltered(
                    colorFilter:
                        ColorFilter.mode(Colors.redAccent, BlendMode.srcIn),
                    child: Image.asset('assets/images/chitotato.png'),
                  ),
                ),
                // const Text(
                //   'Chitto Tatto',
                //   style: TextStyle(
                //     fontSize: 25,
                //   ),
                // ),
                const SizedBox(height: 10),
                const CircularProgressIndicator(),
                const SizedBox(height: 10),
                const Text('version : 1.0.0')
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            left: MediaQuery.of(context).size.width / 4,
            child: const Text(
              'Developed by: Avend Tabdar',
              style: TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
