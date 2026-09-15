import 'package:flutter/material.dart';

void main() => runApp(const MekoApp());

class MekoApp extends StatelessWidget {
  const MekoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meko',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.deepPurple),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int tab = 0;
  final rooms = const [
    ('🎙️', 'غرفة الأصدقاء', '12 متحدثًا • 24 مستمعًا'),
    ('🎵', 'موسيقى وسهر', '8 متحدثين • 31 مستمعًا'),
    ('💬', 'تعرف ودردشة', '6 متحدثين • 18 مستمعًا'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meko'), centerTitle: true),
      body: tab == 0
          ? ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text('غرف صوتية مباشرة',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text('ادخل غرفة وتحدث مع الآخرين بالصوت.'),
                const SizedBox(height: 20),
                ...rooms.map((r) => Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 28,
                          child: Text(r.$1, style: const TextStyle(fontSize: 24)),
                        ),
                        title: Text(r.$2),
                        subtitle: Text(r.$3),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => RoomPage(name: r.$2),
                          ),
                        ),
                      ),
                    )),
              ],
            )
          : Center(
              child: Text(
                tab == 1 ? 'اكتشف غرفًا جديدة' : 'الملف الشخصي',
                style: const TextStyle(fontSize: 22),
              ),
            ),
      floatingActionButton: tab == 0
          ? FloatingActionButton.extended(
              onPressed: _createRoom,
              icon: const Icon(Icons.add),
              label: const Text('إنشاء غرفة'),
            )
          : null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab,
        onDestinationSelected: (v) => setState(() => tab = v),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'الرئيسية'),
          NavigationDestination(icon: Icon(Icons.explore_outlined), label: 'اكتشف'),
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'حسابي'),
        ],
      ),
    );
  }

  void _createRoom() {
    final c = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('إنشاء غرفة'),
        content: TextField(
          controller: c,
          decoration: const InputDecoration(
            labelText: 'اسم الغرفة',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
          FilledButton(
            onPressed: () {
              final name = c.text.trim();
              Navigator.pop(context);
              if (name.isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => RoomPage(name: name)),
                );
              }
            },
            child: const Text('إنشاء'),
          ),
        ],
      ),
    );
  }
}

class RoomPage extends StatefulWidget {
  final String name;
  const RoomPage({super.key, required this.name});
  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  bool muted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.name)),
      body: Column(
        children: [
          const SizedBox(height: 30),
          const CircleAvatar(radius: 45, child: Icon(Icons.groups, size: 45)),
          const SizedBox(height: 12),
          Text(widget.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const Expanded(
            child: Center(
              child: Text(
                'غرفة صوتية تجريبية\nالصوت الحقيقي يحتاج ربط خدمة صوت خلفية.',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: FloatingActionButton.large(
              onPressed: () => setState(() => muted = !muted),
              child: Icon(muted ? Icons.mic_off : Icons.mic),
            ),
          ),
        ],
      ),
    );
  }
}
