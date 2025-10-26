import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/sleep_provider.dart';
import '../widgets/sleep_card.dart';
import '../widgets/sleep_chart.dart';
import 'add_record_screen.dart';
import '../widgets/sleep_summary.dart';
import 'insights_screen.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SleepProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('SleepSync'),
        centerTitle: true,
        actions: [
  IconButton(
    icon: const Icon(Icons.analytics_outlined),
    tooltip: 'View Insights',
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const InsightsScreen()),
      );
    },
  ),
],

      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Your Sleep Overview",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                SleepSummary(records: provider.records),
                const SizedBox(height: 12),
                const Text("Track and analyze your daily sleep patterns"),
                const SizedBox(height: 16),

                // Chart container
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(color: Colors.grey.shade300, blurRadius: 6)
                    ],
                  ),
                  padding: const EdgeInsets.all(12),
                  height: 280,
                  child: SleepChart(records: provider.records),
                ),
                const SizedBox(height: 24),

                const Text(
                  "Recent Records",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),

                // Records list (non-scrollable inside scroll view)
                if (provider.records.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Center(
                      child: Text(
                        'No sleep records yet.\nTap + to add one.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  )
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: provider.records.length,
                    itemBuilder: (context, index) {
                      final record = provider.records[index];
                      return SleepCard(
                        record: record,
                        onDelete: () => provider.deleteRecord(index),
                      );
                    },
                  ),

                const SizedBox(height: 80), // space for FAB
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddRecordScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
