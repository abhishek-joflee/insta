import 'dart:developer' as dev show log;

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'firebase_options.dart';
import 'provider_logger.dart';
import 'state/auth/providers/auth_state_provider.dart';
import 'state/auth/providers/is_logged_in_provider.dart';
import 'state/providers/is_loading_provider.dart';
import 'views/components/loading/loading_screen.dart';
import 'views/login/login_view.dart';

extension Log on Object {
  void log() => dev.log(toString());
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (kIsWeb) {
    await FacebookAuth.i.webAndDesktopInitialize(
      appId: '868513784603790',
      cookie: true,
      xfbml: true,
      version: 'v14.0',
    );
  }
  runApp(
    ProviderScope(
      observers: [ProviderLogger()],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
        indicatorColor: Colors.blueGrey,
      ),
      themeMode: ThemeMode.dark,
      home: Consumer(
        builder: (context, ref, child) {
          // manage loading state
          ref.listen<bool>(
            isLoadingProvider,
            (_, isLoading) {
              if (isLoading) {
                LoadingScreen.instance.show(context: context);
              } else {
                LoadingScreen.instance.hide();
              }
            },
          );

          final isLoggedIn = ref.watch(isLoggedInProvider);
          return isLoggedIn ? const MainView() : const LoginView();
        },
      ),
    );
  }
}

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insta'),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          return Center(
            child: FloatingActionButton.extended(
              onPressed: ref.read(authStateProvider.notifier).logOut,
              label: const Text('Logout'),
            ),
          );
        },
      ),
    );
  }
}
