import 'package:bigbucks/common/screens/error_screen.dart';
import 'package:bigbucks/common/screens/loader.dart';
import 'package:bigbucks/features/auth/controllers/auth_controller.dart';
import 'package:bigbucks/features/auth/screens/login_screen.dart';
import 'package:bigbucks/firebase_options.dart';
import 'package:bigbucks/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Big Moni',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.indigo,
        ).copyWith(
          secondary: Colors.amber,
        ),
      ),
      home: ref.watch(userProvider).when(
          data: (user) {
            if (user == null) return const LoginScreen();
            return const Loader();
          },
          error: (error, trace) {
            return ErrorScreen(
              error: error.toString(),
            );
          },
          loading: () {
            return const Loader();
          }),
      onGenerateRoute: (settings) => generateRoute(settings),
    );
  }
}
