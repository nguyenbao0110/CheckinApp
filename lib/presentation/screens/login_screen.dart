import 'package:checkin_app/presentation/cubits/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.jpg',
                  height: 150,
                  width: 150,
                ),
                const Text(
                  "Log in to your Account",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const Text('Welcome back, please enter your details.'),
                const Row(children: [
                  Expanded(child: Divider()),
                  Text("  OR  "),
                  Expanded(child: Divider())
                ]),
                SizedBox(
                  width: 400,
                  height: 60,
                  child: TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      labelText: "Username",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                SizedBox(
                  width: 400,
                  height: 60,
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      suffixIcon: const Icon(Icons.visibility),
                    ),
                  ),
                ),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    if (state is AuthFailure) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          state.message,
                          style: const TextStyle(color: Colors.red, fontSize: 14),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(value: true, onChanged: (value) {}),
                        const Text("Remember me"),
                      ],
                    ),
                    const Text("Forgot Password?", style: TextStyle(color: Colors.blue)),
                  ],
                ),
                ElevatedButton(
                  onPressed: () async {
                    final cubit = context.read<AuthCubit>();
                    await cubit.authenticate(
                        username: usernameController.text,
                        password: passwordController.text
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text("Log in"),
                ),
                const SizedBox(height: 10 ,),
                const Text.rich(
                  TextSpan(
                    text: "Don't have an account? ",
                    children: [
                      TextSpan(
                        text: "Sign Up",
                        style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}