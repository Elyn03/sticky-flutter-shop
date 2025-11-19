import 'package:go_router/go_router.dart';
import 'package:sticky_flutter_shop/pages/cart_page.dart';
import 'package:sticky_flutter_shop/pages/catalog_page.dart';
import 'package:sticky_flutter_shop/pages/checkout_page.dart';
import 'package:sticky_flutter_shop/pages/home_page.dart';
import 'package:sticky_flutter_shop/pages/login_page.dart';
import 'package:sticky_flutter_shop/pages/orders_page.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (_, __) => const HomePage(),
    ),
    GoRoute(
      path: '/catalog',
      builder: (_, __) => const CatalogPage(),
    ),
    GoRoute(
      path: '/cart',
      builder: (_, __) => const CartPage(),
    ),
    GoRoute(
      path: '/orders',
      builder: (_, __) => const OrdersPage(),
    ),
    GoRoute(
      path: '/login',
      builder: (_, __) => const LoginPage(),
    ),
    GoRoute(
      path: '/checkout',
      builder: (_, __) => const CheckoutPage(),
    ),
  ],
);
