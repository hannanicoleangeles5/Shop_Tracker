import 'package:flutter/material.dart';
import '../state.dart';
import '../theme.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});
  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _name = TextEditingController();
  final _price = TextEditingController();
  String _category = 'Groceries';
  int _qty = 1;
  static const _categories = [
    'Groceries', 'Beverages', 'Household', 'Personal Care', 'School', 'Other'
  ];

  double get _total => (double.tryParse(_price.text) ?? 0) * _qty;

  @override
  void dispose() {
    _name.dispose();
    _price.dispose();
    super.dispose();
  }

  void _add() {
    final price = double.tryParse(_price.text);
    if (_name.text.trim().isEmpty || price == null || price <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Enter an item name and a valid price.')));
      return;
    }
    appState.addItem(ShopItem(
        name: _name.text.trim(), category: _category, price: price, qty: _qty));
    Navigator.pop(context);
  }

  Widget _label(String t) => Padding(
        padding: const EdgeInsets.only(top: 14, bottom: 6),
        child: Text(t, style: const TextStyle(fontSize: 11, color: kGrey)),
      );

  Widget _qtyButton(IconData icon, VoidCallback onTap) => InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Container(
          width: 30, height: 30,
          decoration: const BoxDecoration(color: kGreenSoft, shape: BoxShape.circle),
          child: Icon(icon, color: kGreen, size: 18),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Row(children: [
                Icon(Icons.chevron_left, size: 30),
                Text('Add Item',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
              ]),
            ),
            const SizedBox(height: 14),
            const Text('Add a product',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
            const Text('Enter the details below.',
                style: TextStyle(fontSize: 11, color: kGrey)),
            _label('Item Name'),
            TextField(controller: _name, decoration: fieldDecoration(hint: 'e.g. Gardenia White Bread')),
            _label('Category'),
            DropdownButtonFormField<String>(
              initialValue: _category,
              decoration: fieldDecoration(),
              items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
              onChanged: (v) => setState(() => _category = v ?? _category),
            ),
            _label('Price'),
            TextField(
              controller: _price,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              onChanged: (_) => setState(() {}),
              decoration: fieldDecoration(hint: 'Price', prefix: const Padding(
                  padding: EdgeInsets.only(left: 14, right: 4),
                  child: Text('₱', style: TextStyle(fontSize: 16)))).copyWith(
                  prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0)),
            ),
            _label('Quantity'),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFE0E0E0)),
              ),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                _qtyButton(Icons.remove, () => setState(() { if (_qty > 1) _qty--; })),
                Text('$_qty', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                _qtyButton(Icons.add, () => setState(() => _qty++)),
              ]),
            ),
            _label('Total'),
            Text(peso(_total),
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: kGreen)),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _add,
                style: ElevatedButton.styleFrom(
                  backgroundColor: kGreen,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Add to List', style: TextStyle(fontWeight: FontWeight.w600)),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}