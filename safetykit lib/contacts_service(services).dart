import 'package:shared_preferences/shared_preferences.dart';

class ContactsService {
  ContactsService._();
  static final instance = ContactsService._();

  static const _key = 'emergency_contacts';
  final List<String> _contacts = [];

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList(_key);
    if (saved != null) {
      _contacts
        ..clear()
        ..addAll(saved);
    }
  }

  List<String> getContacts() => List.unmodifiable(_contacts);

  Future<void> addContact(String number) async {
    if (!_contacts.contains(number)) {
      _contacts.add(number);
      await _save();
    }
  }

  Future<void> removeContact(String number) async {
    _contacts.remove(number);
    await _save();
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_key, _contacts);
  }
}
