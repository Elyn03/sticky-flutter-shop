import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';
import 'dart:io' show Platform;
import 'package:share_plus/share_plus.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  void _go(BuildContext context, String route) {
    Navigator.pop(context);
    context.go(route);
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Drawer(
      child: Column(
        children: [
          SizedBox(
            height: 70,
            child: Container(
              color: Colors.transparent,
              child: Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.blueGrey),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ),

          const Divider(height: 24, thickness: 1),

          _navItem("Home", () => _go(context, '/')),
          _navItem("Catalog", () => _go(context, '/catalog')),
          _navItem("Cart", () => _go(context, '/cart')),
          _navItem("Orders", () => _go(context, '/orders')),
          _navItem("Checkout", () => _go(context, '/checkout')),

          const Spacer(),
          const Divider(height: 24, thickness: 1),

          if (user == null) ...[
            _navItem("Login", () => _go(context, '/login')),
            _navItem("Register", () => _go(context, '/register')),
          ] else ...[
            _navItem("Logout", () async {
              await FirebaseAuth.instance.signOut();
              _go(context, '/');
            }),
          ],

          if (kIsWeb) ...[
            const Divider(height: 24, thickness: 1),
            ElevatedButton(
              onPressed: () {
                Clipboard.setData(const ClipboardData(text: "https://sticky-flutter-shop.vercel.app/"));
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text("Lien copié !")));
              },
              child: const Text("Partager le site"),
            ),
            const SizedBox(height: 16)
          ],

          if (!kIsWeb && Platform.isAndroid) ...[
            ElevatedButton(
              onPressed: () {
                Share.share("Check out this shop: https://sticky-flutter-shop.vercel.app/");
              },
              child: const Text("Partager l'app"),
            ),
            const SizedBox(height: 16)
          ],
        ],
      ),
    );
  }

  Widget _navItem(String label, VoidCallback onTap) {
    return ListTile(
      title: Text(
        label,
        style: const TextStyle(fontSize: 16),
      ),
      onTap: onTap,
      dense: true,
      visualDensity: const VisualDensity(vertical: -1),
    );
  }
}
