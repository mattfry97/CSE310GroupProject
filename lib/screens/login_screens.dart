import 'package:flutter/material.dart';
import 'home_screen.dart'; // Import the HomeScreen to navigate after login

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Email text field
            TextField(
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            // Password text field
            TextField(
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            // Login button (can be custom or default)
            ElevatedButton(
              onPressed: () {
                // Navigate to HomeScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HomeScreen()),
                );
              },
              child: const Text('Login'),
            ),

            // OPTIONAL: If using your custom button widget
            // CustomButton(
            //   text: 'Login',
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => const HomeScreen()),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}

