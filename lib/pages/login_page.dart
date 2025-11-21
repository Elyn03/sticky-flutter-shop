import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:sticky_flutter_shop/widgets/button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // field values
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // states
  bool _isLoading = false;
  String _errorMessage = "";

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // login function
  Future<void> _logIn() async {
    if (_emailController.text.trim().isEmpty || _passwordController.text.isEmpty) {
      setState(() {
        _errorMessage = "Please fill in all fields";
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = "";
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Successful log in !'),
            backgroundColor: Colors.green,
          ),
        );
        context.go('/');
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = _getErrorMessage(e.code);
      });
    } catch (e) {
      setState(() {
        _errorMessage = "An unexpected error occurred";
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  String _getErrorMessage(String errorCode) {
    switch (errorCode) {
      case "user-not-found":
        return "No user found with this email address";
      case "wrong-password":
        return "Incorrect password";
      case "invalid-email":
        return "Invalid email address";
      case "user-disabled":
        return "This account has been disabled";
      case "too-many-requests":
        return "Too many attempts. Please try again later";
      default:
        return "An error occurred, try again";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Sticky Shop"),
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Image(
                      image: NetworkImage("https://plus.unsplash.com/premium_vector-1724060616786-5d9bfd1e0094?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwcm9maWxlLXBhZ2V8MjYzfHx8ZW58MHx8fHx8"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text("Log in"),
                  const SizedBox(height: 20),

                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: "Email",
                    ),
                    keyboardType: TextInputType.emailAddress,
                    enabled: !_isLoading,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                    obscureText: true,
                    enabled: !_isLoading,
                    onSubmitted: (_) => _logIn(),
                  ),
                  const SizedBox(height: 24),

                  if (_errorMessage.isNotEmpty)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.red[100],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.red[300]!),
                      ),
                      child: Text(
                        _errorMessage,
                        style: TextStyle(color: Colors.red[700]),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  if (_errorMessage.isNotEmpty)
                    const SizedBox(height: 16),

                  Button(
                    text: "Log in",
                    onPressed: _logIn
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: _isLoading ? null : () => context.go('/register'),
                    child: const Text('No account ? Sign up'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}