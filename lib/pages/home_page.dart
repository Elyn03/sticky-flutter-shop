import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Homepage")
      ),
      drawer: const NavBar(),
      body: Consumer(builder: (context, viewmodel, child) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                user != null
                    ? 'Welcome, ${user.email}!'
                    : 'Welcome, Guest! Please log in.',
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
        );
      }),
    );
  }
}
