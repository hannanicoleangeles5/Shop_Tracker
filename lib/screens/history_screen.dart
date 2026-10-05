import 'package:flutter/material.dart';
import '../state.dart';
import '../theme.dart';
import 'home_shell.dart' show TripIcon;

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: appState,
      builder: (context, _) {
        final trips = appState.history;
        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(height: 8),
            const Text('Shopping History',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
            const Text('Review your completed trips',
                style: TextStyle(fontSize: 11, color: kGrey)),
            const SizedBox(height: 16),
            if (trips.isEmpty)
              const Padding(
                padding: EdgeInsets.only(top: 40),
                child: Center(
                    child: Text('No completed trips yet.', style: TextStyle(color: kGrey))),
              ),
            for (final t in trips)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _HistoryCard(trip: t),
              ),
          ],
        );
      },
    );
  }
}

class _HistoryCard extends StatelessWidget {
  const _HistoryCard({required this.trip});
  final Trip trip;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: cardBox(),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const TripIcon(),
        const SizedBox(width: 12),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(trip.name,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
            Text(longDate(trip.date),
                style: const TextStyle(fontSize: 11, color: kGrey)),
            const SizedBox(height: 6),
            const Text('Spent', style: TextStyle(fontSize: 10, color: kGrey)),
            Text(peso(trip.spent),
                style: const TextStyle(
                    fontSize: 22, fontWeight: FontWeight.w700, color: kGreen)),
            Text('Budget: ${peso(trip.budget)}',
                style: const TextStyle(fontSize: 10, color: kGrey)),
          ]),
        ),
        const Icon(Icons.chevron_right),
      ]),
    );
  }
}