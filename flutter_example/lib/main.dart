// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_core/firebase_core.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:flutter_example/presentation/core/app.dart';
import 'package:flutter_example/presentation/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // injection 정의
  configureInjection(Environment.prod);
  runApp(AppWidget());
}
