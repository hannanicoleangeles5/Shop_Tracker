import 'package:flutter/material.dart';
import '../state.dart';
import '../theme.dart';

class NewTripScreen extends StatefulWidget {
  const NewTripScreen({super.key});
  @override
  State<NewTripScreen> createState() => _NewTripScreenState();
}

class _NewTripScreenState extends State<NewTripScreen> {
  final _name = TextEditingController();
  final _budget = TextEditingController();
  DateTime _date = DateTime.now();
  String _store = 'Robinsons Angeles';
  static const _stores = [
    'Robinsons Angeles', 'SM Clark', 'Puregold Angeles', 'Walter Mart'
  ];

  @override
  void dispose() {
    _name.dispose();
    _budget.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final d = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (d != null) setState(() => _date = d);
  }

  void _create() {
    final budget = double.tryParse(_budget.text.replaceAll(',', ''));
    if (_name.text.trim().isEmpty || budget == null || budget <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Enter a trip name and a valid budget.')));
      return;
    }
    appState.startTrip(Trip(
        name: _name.text.trim(), budget: budget, date: _date, store: _store));
    Navigator.pop(context);
  }

  Widget _label(String t) => Padding(
        padding: const EdgeInsets.only(top: 14, bottom: 6),
        child: Text(t, style: const TextStyle(fontSize: 11, color: kGrey)),
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
              // FIX: Expanded + ellipsis so the title can't overflow the Row
              child: const Row(children: [
                Icon(Icons.chevron_left, size: 30),
                Expanded(
                  child: Text(
                    'New Shopping Trip',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ),
              ]),
            ),
            const SizedBox(height: 14),
            const Text('Create a new trip',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
            const Text('Set your budget before you start shopping.',
                style: TextStyle(fontSize: 11, color: kGrey)),
            _label('Trip Name'),
            TextField(
                controller: _name,
                decoration: fieldDecoration(hint: 'e.g. Weekend Grocery Run')),
            _label('Budget'),
            TextField(
              controller: _budget,
              keyboardType: TextInputType.number,
              decoration: fieldDecoration(
                  hint: 'Budget',
                  prefix: const Padding(
                      padding: EdgeInsets.only(left: 14, right: 4),
                      child: Text('₱', style: TextStyle(fontSize: 16)))).copyWith(
                  prefixIconConstraints:
                      const BoxConstraints(minWidth: 0, minHeight: 0)),
            ),
            _label('Shopping Date'),
            InkWell(
              onTap: _pickDate,
              child: InputDecorator(
                decoration: fieldDecoration(
                    suffix: const Icon(Icons.calendar_today_outlined, size: 18)),
                child: Text(longDate(_date), style: const TextStyle(fontSize: 14)),
              ),
            ),
            _label('Store'),
            DropdownButtonFormField<String>(
              isExpanded: true, // FIX: lets long store names shrink instead of overflow
              initialValue: _store,
              decoration: fieldDecoration(),
              items: _stores
                  .map((s) => DropdownMenuItem(
                        value: s,
                        child: Text(s, overflow: TextOverflow.ellipsis),
                      ))
                  .toList(),
              onChanged: (v) => setState(() => _store = v ?? _store),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _create,
                style: ElevatedButton.styleFrom(
                  backgroundColor: kGreen,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Create Shopping Trip',
                    style: TextStyle(fontWeight: FontWeight.w600)),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel', style: TextStyle(color: kGrey)),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}