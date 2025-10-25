import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'models/sleep_record.dart';
import 'providers/sleep_provider.dart';
import 'screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(SleepRecordAdapter());
  await Hive.openBox<SleepRecord>('sleep_records');

  runApp(const SleepSyncApp());
}

class SleepSyncApp extends StatelessWidget {
  const SleepSyncApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SleepProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SleepSync',
        theme: ThemeData(
           useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  scaffoldBackgroundColor: Colors.grey[50],
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.deepPurple,
    foregroundColor: Colors.white,
    centerTitle: true,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.deepPurple,
    foregroundColor: Colors.white,
        ),
        ),
        home: const HomeScreen(),
      ),
      
    );
  }
}
