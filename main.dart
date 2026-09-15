import 'package:flutter/material.dart';

void main() {
  runApp(const MekoApp());
}

class MekoApp extends StatelessWidget {
  const MekoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meko',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
      ),
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

  final List<Map<String, String>> rooms = [
    {
      'icon': '🎙️',
      'name': 'غرفة الأصدقاء',
      'info': '12 متحدثًا • 24 مستمعًا',
    },
    {
      'icon': '🎵',
      'name': 'موسيقى وسهر',
      'info': '8 متحدثين • 31 مستمعًا',
    },
    {
      'icon': '💬',
      'name': 'تعرف ودردشة',
      'info': '6 متحدثين • 18 مستمعًا',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meko'),
        centerTitle: true,
      ),
      body: _buildBody(),
      floatingActionButton: tab == 0
          ? FloatingActionButton.extended(
              onPressed: _createRoom,
              icon: const Icon(Icons.add),
              label: const Text('إنشاء غرفة'),
            )
          : null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab,
        onDestinationSelected: (value) {
          setState(() {
            tab = value;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'الرئيسية',
          ),
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore),
            label: 'اكتشف',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'حسابي',
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (tab == 1) {
      return const Center(
        child: Text(
          'اكتشف غرفًا جديدة',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    if (tab == 2) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 45,
              child: Icon(Icons.person, size: 50),
            ),
            SizedBox(height: 16),
            Text(
              'حسابي',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text('مرحبًا بك في Meko'),
          ],
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'غرف صوتية مباشرة',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text('ادخل غرفة وتحدث مع الآخرين بالصوت.'),
        const SizedBox(height: 20),
        ...rooms.map(
          (room) => Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: CircleAvatar(
                radius: 28,
                child: Text(
                  room['icon']!,
                  style: const TextStyle(fontSize: 24),
                ),
              ),
              title: Text(
                room['name']!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(room['info']!),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RoomPage(
                      name: room['name']!,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  void _createRoom() {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('إنشاء غرفة'),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: const InputDecoration(
              labelText: 'اسم الغرفة',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('إلغاء'),
            ),
            FilledButton(
              onPressed: () {
                final name = controller.text.trim();

                if (name.isEmpty) {
                  return;
                }

                Navigator.pop(dialogContext);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RoomPage(name: name),
                  ),
                );
              },
              child: const Text('إنشاء'),
            ),
          ],
        );
      },
    );
  }
}

class RoomPage extends StatefulWidget {
  final String name;

  const RoomPage({
    super.key,
    required this.name,
  });

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  bool muted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          const CircleAvatar(
            radius: 45,
            child: Icon(
              Icons.groups,
              size: 45,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            widget.name,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text('غرفة صوتية'),
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
              onPressed: () {
                setState(() {
                  muted = !muted;
                });
              },
              child: Icon(
                muted ? Icons.mic_off : Icons.mic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
