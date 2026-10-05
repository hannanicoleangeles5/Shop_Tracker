import 'package:flutter/material.dart';
import '../state.dart';
import '../theme.dart';
import 'add_item_screen.dart';
import 'home_shell.dart' show ProgressBar;

class ShoppingListScreen extends StatefulWidget {
  const ShoppingListScreen({super.key, this.showBack = true});
  final bool showBack;
  @override
  State<ShoppingListScreen> createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final body = ListenableBuilder(
      listenable: appState,
      builder: (context, _) {
        final trip = appState.current;
        if (trip == null) {
          return const Center(
            child: Text('No active trip.\nStart one from the Home tab.',
                textAlign: TextAlign.center, style: TextStyle(color: kGrey)),
          );
        }
        final items = trip.items
            .where((i) => i.name.toLowerCase().contains(_query.toLowerCase()))
            .toList();
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              if (widget.showBack)
                GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.chevron_left, size: 30)),
              Expanded(
                child: Text(trip.name,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
              ),
              IconButton(
                tooltip: 'Complete trip',
                icon: const Icon(Icons.check_circle_outline, color: kGreen),
                onPressed: () {
                  appState.completeTrip();
                  if (widget.showBack) Navigator.pop(context);
                },
              ),
            ]),
            const SizedBox(height: 14),
            Text('${peso(trip.remaining)} remaining',
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.w700, color: kGreen)),
            Text('${peso(trip.spent)} of ${peso(trip.budget)} spent',
                style: const TextStyle(fontSize: 10, color: kGrey)),
            const SizedBox(height: 6),
            ProgressBar(value: trip.progress),
            const SizedBox(height: 14),
            TextField(
              onChanged: (v) => setState(() => _query = v),
              decoration: fieldDecoration(
                hint: 'Search shopping items',
                suffix: const Icon(Icons.search, size: 20),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Shopping items',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.separated(
                itemCount: items.length,
                separatorBuilder: (_, _) => const SizedBox(height: 8),
                itemBuilder: (_, i) => _ItemTile(item: items[i]),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const AddItemScreen())),
                style: ElevatedButton.styleFrom(
                  backgroundColor: kGreen,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('+ Add Item',
                    style: TextStyle(fontWeight: FontWeight.w600)),
              ),
            ),
          ]),
        );
      },
    );
    return widget.showBack ? Scaffold(body: SafeArea(child: body)) : body;
  }
}

class _ItemTile extends StatelessWidget {
  const _ItemTile({required this.item});
  final ShopItem item;

  @override
  Widget build(BuildContext context) {
    final done = item.checked;
    final style = TextStyle(
      fontSize: 13,
      color: done ? kGrey : Colors.black,
      decoration: done ? TextDecoration.lineThrough : null,
    );
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: cardBox(),
      child: Row(children: [
        Checkbox(
          value: done,
          activeColor: kGreen,
          visualDensity: VisualDensity.compact,
          onChanged: (_) => appState.toggle(item),
        ),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(item.name, style: style),
            Text('${peso(item.price)} × ${item.qty}',
                style: const TextStyle(fontSize: 10, color: kGrey)),
          ]),
        ),
        Text(peso(item.total),
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: done ? kGrey : Colors.black)),
      ]),
    );
  }
}