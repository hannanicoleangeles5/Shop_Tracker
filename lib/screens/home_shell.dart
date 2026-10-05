import 'package:flutter/material.dart';
import '../state.dart';
import '../theme.dart';
import 'history_screen.dart';
import 'new_trip_screen.dart';
import 'shopping_list_screen.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});
  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(index: _tab, children: [
          HomeScreen(onHistory: () => setState(() => _tab = 2)),
          const ShoppingListScreen(showBack: false),
          const HistoryScreen(),
        ]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tab,
        onTap: (i) => setState(() => _tab = i),
        backgroundColor: Colors.white,
        selectedItemColor: kGreen,
        unselectedItemColor: Colors.black87,
        selectedFontSize: 11,
        unselectedFontSize: 11,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: 'Shopping'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.onHistory});
  final VoidCallback onHistory;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: appState,
      builder: (context, _) {
        final trip = appState.current;
        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('SPEND WISE',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
                Stack(children: [
                  const Icon(Icons.notifications_none, size: 30),
                  Positioned(
                    right: 4, top: 2,
                    child: Container(
                        width: 8, height: 8,
                        decoration: const BoxDecoration(
                            color: Colors.red, shape: BoxShape.circle)),
                  ),
                ]),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Good morning! 👋',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
            const Text('Ready to shop smarter?',
                style: TextStyle(fontSize: 12, color: kGrey)),
            const SizedBox(height: 14),
            _budgetCard(trip),
            const SizedBox(height: 20),
            const Text('Quick Actions',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            Row(children: [
              Expanded(
                child: _QuickAction(
                  label: 'New Trip',
                  icon: const Icon(Icons.add_circle_outline, size: 46, color: kGreen),
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const NewTripScreen())),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _QuickAction(
                  label: 'History',
                  icon: Container(
                    width: 46, height: 46,
                    decoration: const BoxDecoration(color: kYellow, shape: BoxShape.circle),
                    child: const Icon(Icons.access_time, color: Colors.white, size: 30),
                  ),
                  onTap: onHistory,
                ),
              ),
            ]),
            const SizedBox(height: 20),
            const Text('Current Trip',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            if (trip == null)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: cardBox(),
                child: const Text('No active trip. Tap "New Trip" to start one.',
                    style: TextStyle(color: kGrey, fontSize: 13)),
              )
            else
              _currentTripCard(context, trip),
          ],
        );
      },
    );
  }

  Widget _budgetCard(Trip? t) {
    final budget = t?.budget ?? 0;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: cardBox(),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Current Budget', style: TextStyle(fontSize: 11, color: kGrey)),
        Text(peso(budget),
            style: const TextStyle(
                fontSize: 26, fontWeight: FontWeight.w700, color: kGreen)),
        Text('${peso(t?.remaining ?? 0)} remaining',
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.w600, color: kGreen)),
        const SizedBox(height: 8),
        ProgressBar(value: t?.progress ?? 0, trackColor: kGrey.withValues(alpha: .6)),
        const SizedBox(height: 6),
        Text('${peso(t?.spent ?? 0)} spent', style: const TextStyle(fontSize: 12)),
      ]),
    );
  }

  Widget _currentTripCard(BuildContext context, Trip t) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (_) => const ShoppingListScreen())),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: cardBox(),
        child: Row(children: [
          const TripIcon(),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(t.name,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
              Text(t.store, style: const TextStyle(fontSize: 11, color: kGrey)),
              Text(longDate(t.date), style: const TextStyle(fontSize: 11, color: kGrey)),
              const SizedBox(height: 8),
              Text('${peso(t.spent)} / ${peso(t.budget)}',
                  style: const TextStyle(fontSize: 11, color: kGreen)),
              const SizedBox(height: 4),
              ProgressBar(value: t.progress),
            ]),
          ),
        ]),
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({required this.label, required this.icon, required this.onTap});
  final String label;
  final Widget icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        height: 96,
        decoration: cardBox(),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          icon,
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
        ]),
      ),
    );
  }
}

class TripIcon extends StatelessWidget {
  const TripIcon({super.key});
  @override
  Widget build(BuildContext context) => Container(
        width: 44, height: 44,
        decoration: const BoxDecoration(color: kGreenSoft, shape: BoxShape.circle),
        child: const Icon(Icons.shopping_cart_outlined, color: kGreen),
      );
}

class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key, required this.value, this.trackColor = kLavender});
  final double value;
  final Color trackColor;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: LinearProgressIndicator(
        value: value,
        minHeight: 6,
        backgroundColor: trackColor,
        valueColor: const AlwaysStoppedAnimation(kGreen),
      ),
    );
  }
}