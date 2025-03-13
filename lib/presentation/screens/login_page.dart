import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                'https://img.pikbest.com/origin/10/41/85/35HpIkbEsTU62.png!f305cw',
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
                  decoration: InputDecoration(
                    labelText: "Email Address",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              SizedBox(
                width: 400,
                height: 60,
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    suffixIcon: const Icon(Icons.visibility),
                  ),
                ),
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
                onPressed: () {},
                child: const Text("Log in", ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
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
        ),
      ),
    );
  }
}
