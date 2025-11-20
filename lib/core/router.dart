import 'package:go_router/go_router.dart';
import 'package:sticky_flutter_shop/core/guard.dart';
import 'package:sticky_flutter_shop/pages/cart_page.dart';
import 'package:sticky_flutter_shop/pages/catalog_page.dart';
import 'package:sticky_flutter_shop/pages/checkout_page.dart';
import 'package:sticky_flutter_shop/pages/home_page.dart';
import 'package:sticky_flutter_shop/pages/login_page.dart';
import 'package:sticky_flutter_shop/pages/orders_page.dart';
import 'package:sticky_flutter_shop/pages/product_page.dart';
import 'package:sticky_flutter_shop/pages/register_page.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/catalog',
      builder: (context, state) => const CatalogPage(),
    ),
    GoRoute(
      path: '/product/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return ProductPage(productId: id);
      },
    ),
    GoRoute(
      path: '/cart',
      builder: (context, state) => const CartPage(),
    ),
    GoRoute(
      path: '/orders',
      builder: (context, state) => const OrdersPage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const AuthGuard(child: LoginPage()),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const AuthGuard(child: RegisterPage()),
    ),
    GoRoute(
      path: '/checkout',
      builder: (context, state) => const CheckoutPage(),
    ),
  ],
);
