import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/contacts_screen.dart';
import 'screens/logs_screen.dart';
import 'screens/settings_screen.dart';
import 'services/contacts_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ContactsService.instance.init(); // ✅ Make absolutely sure contacts are loaded
  runApp(const SafetyKitAppMain());
}

class SafetyKitAppMain extends StatelessWidget {
  const SafetyKitAppMain({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        useMaterial3: true,
      ),
      home: const SafetyKitApp(),
    );
  }
}

class SafetyKitApp extends StatefulWidget {
  const SafetyKitApp({super.key});

  @override
  State<SafetyKitApp> createState() => _SafetyKitAppState();
}

class _SafetyKitAppState extends State<SafetyKitApp> {
  int _selectedIndex = 0;
  bool _loading = true;

  final List<Widget> _pages = const [
    HomeScreen(),
    ContactsScreen(),
    LogsScreen(),
    SettingsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _initContacts();
  }

  Future<void> _initContacts() async {
    await ContactsService.instance.init();
    print("✅ Contacts loaded at app start: ${ContactsService.instance.getContacts()}");
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(color: Colors.red)),
      );
    }

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.contacts), label: "Contacts"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "Logs"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
    );
  }
}
