import 'package:cinema_pedia_flutter/config/routes/app_router.dart';
import 'package:cinema_pedia_flutter/config/theme/app_theme.dart';
import 'package:cinema_pedia_flutter/presentation/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme().appTheme(),
    );
  }
}
