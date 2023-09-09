import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test Firebase Auth',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const AuthPage(),
    );
  }
}

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';
  String feedbackText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTextField(
              label: 'Email',
              onChanged: (value) => email = value,
            ),
            const SizedBox(height: 8),
            _buildTextField(
              label: 'Password',
              obscure: true,
              onChanged: (value) => password = value,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _register,
              child: const Text('Register'),
            ),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
            ),
            Text(feedbackText),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    bool obscure = false,
    required ValueChanged<String> onChanged,
  }) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      obscureText: obscure,
      onChanged: onChanged,
    );
  }

  Future<void> _register() async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      setState(() {
        feedbackText = 'Registered: ${result.user!.email}';
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        setState(() {
          feedbackText = 'The password provided is too weak.';
        });
      } else if (e.code == 'email-already-in-use') {
        setState(() {
          feedbackText = 'The account already exists for that email.';
        });
      }
    }
  }

  Future<void> _login() async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      setState(() {
        feedbackText = 'Logged in: ${result.user!.email}';
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        setState(() {
          feedbackText = 'The password provided is too weak.';
        });
      } else if (e.code == 'email-already-in-use') {
        setState(() {
          feedbackText = 'The account already exists for that email.';
        });
      }
    }
  }
}
