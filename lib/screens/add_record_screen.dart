import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/sleep_record.dart';
import '../providers/sleep_provider.dart';

class AddRecordScreen extends StatefulWidget {
  const AddRecordScreen({super.key});

  @override
  State<AddRecordScreen> createState() => _AddRecordScreenState();
}

class _AddRecordScreenState extends State<AddRecordScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now();
  double _duration = 8.0;
  String _quality = 'Good';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Sleep Record')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
        child: SingleChildScrollView(
  child: Column(
    children: [
      Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
        child: ListTile(
          title: Text('Date: ${_selectedDate.toLocal().toString().split(' ')[0]}'),
          trailing: const Icon(Icons.calendar_today),
          onTap: _pickDate,
        ),
      ),
      const SizedBox(height: 16),
      Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Sleep Duration (hours)", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Slider(
              min: 0,
              max: 12,
              divisions: 24,
              label: '${_duration.toStringAsFixed(1)} hrs',
              value: _duration,
              onChanged: (val) => setState(() => _duration = val),
            ),
          ],
        ),
      ),
      const SizedBox(height: 16),
      DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          labelText: "Sleep Quality",
          border: OutlineInputBorder(),
        ),
        value: _quality,
        items: const [
          DropdownMenuItem(value: 'Good', child: Text('Good')),
          DropdownMenuItem(value: 'Average', child: Text('Average')),
          DropdownMenuItem(value: 'Poor', child: Text('Poor')),
        ],
        onChanged: (val) => setState(() => _quality = val!),
      ),
      const SizedBox(height: 24),
      ElevatedButton.icon(
        icon: const Icon(Icons.save),
        label: const Text('Save Record'),
        style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
        onPressed: () {
          final record = SleepRecord(date: _selectedDate, duration: _duration, quality: _quality);
          Provider.of<SleepProvider>(context, listen: false).addRecord(record);
          Navigator.pop(context);
        },
      ),
    ],
  ),
),

        ),
      ),
    );
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }
}
