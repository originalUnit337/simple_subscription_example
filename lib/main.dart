import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_subscription_example/navigation/app_router.dart';
import 'package:simple_subscription_example/services/local_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await LocalStorage.init();
  final appRouter = AppRouter(storage).router;
  runApp(MainApp(router: appRouter));
}

class MainApp extends StatelessWidget {
  final GoRouter router;
  const MainApp({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: router);
  }
}
