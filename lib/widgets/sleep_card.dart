import 'package:flutter/material.dart';
import '../models/sleep_record.dart';

class SleepCard extends StatelessWidget {
  final SleepRecord record;
  final VoidCallback onDelete;
  const SleepCard({super.key, required this.record, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        title: Text(
          'Date: ${record.date.toLocal().toString().split(' ')[0]}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('Duration: ${record.duration.toStringAsFixed(1)} hrs\nQuality: ${record.quality}'),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.redAccent),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
