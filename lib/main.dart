import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const ShortVaultApp());
}

class ShortVaultApp extends StatelessWidget {
  const ShortVaultApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShortVault',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        primaryColor: const Color(0xFF3B82F6),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF3B82F6),
          secondary: Color(0xFF10B981),
        ),
      ),
      home: const VaultHomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class VaultHomeScreen extends StatefulWidget {
  const VaultHomeScreen({super.key});

  @override
  State<VaultHomeScreen> createState() => _VaultHomeScreenState();
}

class _VaultHomeScreenState extends State<VaultHomeScreen> {
  final TextEditingController _keyController = TextEditingController();
  final TextEditingController _valController = TextEditingController();
  Map<String, String> _entries = {};

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  Future<void> _loadEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();
    Map<String, String> temp = {};
    for (String key in keys) {
      temp[key] = prefs.getString(key) ?? '';
    }
    setState(() {
      _entries = temp;
    });
  }

  Future<void> _saveEntry() async {
    if (_keyController.text.isEmpty || _valController.text.isEmpty) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyController.text, _valController.text);
    _keyController.clear();
    _valController.clear();
    _loadEntries();
    Navigator.pop(context);
  }

  Future<void> _deleteEntry(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
    _loadEntries();
  }

  void _showAddDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1E293B),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 20, right: 20, top: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Add New Vault Entry', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            TextField(
              controller: _keyController,
              decoration: const InputDecoration(labelText: 'Title / Key', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _valController,
              maxLines: 3,
              decoration: const InputDecoration(labelText: 'Data / Secret', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF3B82F6), padding: const EdgeInsets.all(14)),
                onPressed: _saveEntry,
                child: const Text('Save Entry', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ShortVault', style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF1E293B),
        elevation: 0,
      ),
      body: _entries.isEmpty
          ? Center(
              child: Text('Your vault is empty.\nTap "+" to add a secure note.', 
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(color: Colors.white54, fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _entries.length,
              itemBuilder: (context, index) {
                String key = _entries.keys.elementAt(index);
                String val = _entries[key]!;
                return Card(
                  color: const Color(0xFF1E293B),
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    title: Text(key, style: GoogleFonts.inter(fontWeight: FontWeight.bold, color: Colors.white)),
                    subtitle: Text(val, style: GoogleFonts.inter(color: Colors.white70)),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                      onPressed: () => _deleteEntry(key),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF3B82F6),
        onPressed: _showAddDialog,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
