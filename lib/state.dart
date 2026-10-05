import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopItem {
  ShopItem({
    required this.name,
    required this.category,
    required this.price,
    this.qty = 1,
    this.checked = false,
  });
  String name, category;
  double price;
  int qty;
  bool checked;
  double get total => price * qty;

  Map<String, dynamic> toJson() => {
        'name': name,
        'category': category,
        'price': price,
        'qty': qty,
        'checked': checked,
      };

  factory ShopItem.fromJson(Map<String, dynamic> j) => ShopItem(
        name: j['name'] as String,
        category: j['category'] as String,
        price: (j['price'] as num).toDouble(),
        qty: j['qty'] as int,
        checked: j['checked'] as bool,
      );
}

class Trip {
  Trip({
    required this.name,
    required this.budget,
    required this.date,
    required this.store,
    List<ShopItem>? items,
    this.finalSpent,
  }) : items = items ?? [];
  String name, store;
  double budget;
  DateTime date;
  List<ShopItem> items;
  double? finalSpent; // set when the trip is completed

  double get spent =>
      finalSpent ?? items.where((i) => i.checked).fold(0.0, (s, i) => s + i.total);
  double get remaining => budget - spent;
  double get progress => budget == 0 ? 0 : (spent / budget).clamp(0.0, 1.0);

  Map<String, dynamic> toJson() => {
        'name': name,
        'store': store,
        'budget': budget,
        'date': date.toIso8601String(),
        'items': items.map((i) => i.toJson()).toList(),
        'finalSpent': finalSpent,
      };

  factory Trip.fromJson(Map<String, dynamic> j) => Trip(
        name: j['name'] as String,
        store: j['store'] as String,
        budget: (j['budget'] as num).toDouble(),
        date: DateTime.parse(j['date'] as String),
        items: (j['items'] as List)
            .map((e) => ShopItem.fromJson(e as Map<String, dynamic>))
            .toList(),
        finalSpent: (j['finalSpent'] as num?)?.toDouble(),
      );
}

class AppState extends ChangeNotifier {
  static const _storageKey = 'spend_wise_data_v1';

  // Sample data, used only until something has been saved.
  Trip? current = Trip(
    name: 'Weekend Grocery Run',
    budget: 3000,
    date: DateTime(2026, 9, 20),
    store: 'Robinsons Angeles',
    items: [
      ShopItem(name: 'Bear Brand Milk', category: 'Groceries', price: 95, qty: 2, checked: true),
      ShopItem(name: 'Argentina Corned Beef', category: 'Groceries', price: 45, qty: 2, checked: true),
      ShopItem(name: 'Gardenia White Bread', category: 'Groceries', price: 78),
      ShopItem(name: 'Lucky Me Pancit Canton', category: 'Groceries', price: 15, qty: 5),
      ShopItem(name: 'C2 Green Tea', category: 'Beverages', price: 25, qty: 2),
    ],
  );

  final List<Trip> history = [
    Trip(name: 'Monthly Essentials', budget: 2000, date: DateTime(2026, 9, 5),
        store: 'SM Clark', finalSpent: 1850),
    Trip(name: 'School Supplies', budget: 1500, date: DateTime(2026, 8, 28),
        store: 'National Book Store', finalSpent: 1240),
  ];

  /// Loads saved data from shared_preferences. Call once before runApp.
  Future<void> load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_storageKey);
      if (raw == null) return; // nothing saved yet: keep the sample data
      final map = jsonDecode(raw) as Map<String, dynamic>;
      current = map['current'] == null
          ? null
          : Trip.fromJson(map['current'] as Map<String, dynamic>);
      history
        ..clear()
        ..addAll((map['history'] as List)
            .map((e) => Trip.fromJson(e as Map<String, dynamic>)));
      notifyListeners();
    } catch (e) {
      debugPrint('Could not load saved data: $e');
    }
  }

  Future<void> _save() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        _storageKey,
        jsonEncode({
          'current': current?.toJson(),
          'history': history.map((t) => t.toJson()).toList(),
        }),
      );
    } catch (e) {
      debugPrint('Could not save data: $e');
    }
  }

  void _changed() {
    notifyListeners();
    _save();
  }

  void startTrip(Trip t) {
    current = t;
    _changed();
  }

  void addItem(ShopItem i) {
    current?.items.add(i);
    _changed();
  }

  void toggle(ShopItem i) {
    i.checked = !i.checked;
    _changed();
  }

  void completeTrip() {
    final t = current;
    if (t == null) return;
    t.finalSpent = t.spent;
    history.insert(0, t);
    current = null;
    _changed();
  }
}

final appState = AppState();