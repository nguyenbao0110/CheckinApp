import 'package:checkin_app/presentation/cubits/auth_cubit.dart';
import 'package:checkin_app/presentation/screens/auth_screen.dart';
import 'package:checkin_app/setup_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'data/services/auth_service.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider<AuthCubit>(
          create: (context) =>
              AuthCubit(authService: GetIt.instance<AuthService>())
                ..checkAuthentication(),
          child: const AuthScreen()
      ),
    );
  }
}
