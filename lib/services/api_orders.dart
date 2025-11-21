import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/order.dart';

class ApiOrders {
  static const String _key = "orders";

  // fetch all
  static Future<List<Order>> fetchOrders() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key) ?? "[]";
    final List data = json.decode(jsonString);
    return data.map((e) => Order.fromJson(e)).toList();
  }

  // fetch by id
  static Future<Order?> fetchOrder(String id) async {
    final orders = await fetchOrders();
    try {
      return orders.firstWhere((o) => o.id == id);
    } catch (e) {
      return null;
    }
  }

  // create new
  static Future<void> createOrder(Order order) async {
    final orders = await fetchOrders();
    orders.add(order);

    final prefs = await SharedPreferences.getInstance();
    final jsonString =
    json.encode(orders.map((order) => order.toJson()).toList());
    await prefs.setString(_key, jsonString);
  }
}
