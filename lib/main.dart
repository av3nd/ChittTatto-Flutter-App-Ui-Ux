import 'package:chitto_tatto/core/app.dart';
import 'package:chitto_tatto/core/network/local/hive_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HiveServices().init();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}
