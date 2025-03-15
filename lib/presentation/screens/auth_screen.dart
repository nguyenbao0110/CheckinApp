import 'package:checkin_app/presentation/cubits/auth_cubit.dart';
import 'package:checkin_app/presentation/screens/home_screen.dart';
import 'package:checkin_app/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthAuthenticated) {
              return const HomeScreen();
            } else if (state is AuthLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return LoginScreen();
          },
        ),
      ),
    );
  }
}
