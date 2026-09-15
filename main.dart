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
        colorSchemeSeed: Colors.deepPurple,
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
  int currentIndex = 0;

  final List<Room> rooms = [
    Room(
      name: 'غرفة الأصدقاء',
      icon: Icons.people,
      speakers: 12,
      listeners: 24,
    ),
    Room(
      name: 'موسيقى وسهر',
      icon: Icons.music_note,
      speakers: 8,
      listeners: 31,
    ),
    Room(
      name: 'تعرف ودردشة',
      icon: Icons.chat,
      speakers: 6,
      listeners: 18,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Meko',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: _buildPage(),

      floatingActionButton: currentIndex == 0
          ? FloatingActionButton.extended(
              onPressed: _showCreateRoom,
              icon: const Icon(Icons.add),
              label: const Text('إنشاء غرفة'),
            )
          : null,

      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index;
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

  Widget _buildPage() {
    switch (currentIndex) {
      case 1:
        return const ExplorePage();

      case 2:
        return const ProfilePage();

      default:
        return _buildHomePage();
    }
  }

  Widget _buildHomePage() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'مرحبًا بك في Meko 👋',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          'ادخل إلى غرفة صوتية وتحدث مع الآخرين.',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey.shade700,
          ),
        ),

        const SizedBox(height: 24),

        const Text(
          'الغرف الصوتية المباشرة',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 12),

        ...rooms.map(
          (room) => _roomCard(room),
        ),
      ],
    );
  }

  Widget _roomCard(Room room) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),

        leading: CircleAvatar(
          radius: 29,
          child: Icon(room.icon),
        ),

        title: Text(
          room.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),

        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            '${room.speakers} متحدث • ${room.listeners} مستمع',
          ),
        ),

        trailing: const Icon(Icons.chevron_right),

        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => RoomPage(
                roomName: room.name,
              ),
            ),
          );
        },
      ),
    );
  }

  void _showCreateRoom() {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('إنشاء غرفة جديدة'),

          content: TextField(
            controller: controller,
            autofocus: true,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(
              hintText: 'اكتب اسم الغرفة',
              border: OutlineInputBorder(),
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                controller.dispose();
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
                controller.dispose();

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RoomPage(
                      roomName: name,
                    ),
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

class Room {
  final String name;
  final IconData icon;
  final int speakers;
  final int listeners;

  const Room({
    required this.name,
    required this.icon,
    required this.speakers,
    required this.listeners,
  });
}

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'اكتشف 🔎',
          style: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 10),

        const Text(
          'اكتشف غرفًا جديدة وتعرف على أشخاص جدد.',
          style: TextStyle(fontSize: 16),
        ),

        const SizedBox(height: 30),

        Card(
          child: ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.trending_up),
            ),
            title: const Text(
              'الغرف الشائعة',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text('الغرف الأكثر نشاطًا الآن'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
        ),

        Card(
          child: ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.music_note),
            ),
            title: const Text(
              'موسيقى',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text('استمع وتحدث مع الآخرين'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
        ),

        Card(
          child: ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.chat),
            ),
            title: const Text(
              'دردشة',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text('تحدث وتعرف على أشخاص جدد'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
        ),
      ],
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const SizedBox(height: 30),

        const Center(
          child: CircleAvatar(
            radius: 55,
            child: Icon(
              Icons.person,
              size: 60,
            ),
          ),
        ),

        const SizedBox(height: 18),

        const Center(
          child: Text(
            'مستخدم Meko',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const SizedBox(height: 8),

        Center(
          child: Text(
            'مرحبًا بك في Meko',
            style: TextStyle(
              color: Colors.grey.shade700,
            ),
          ),
        ),

        const SizedBox(height: 30),

        Card(
          child: ListTile(
            leading: const Icon(Icons.person),
            title: const Text('الملف الشخصي'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
        ),

        Card(
          child: ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('الإعدادات'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
        ),

        Card(
          child: ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('عن Meko'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
        ),
      ],
    );
  }
}

class RoomPage extends StatefulWidget {
  final String roomName;

  const RoomPage({
    super.key,
    required this.roomName,
  });

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  bool microphoneOn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.roomName),
        centerTitle: true,
      ),

      body: Column(
        children: [
          const SizedBox(height: 30),

          const CircleAvatar(
            radius: 50,
            child: Icon(
              Icons.groups,
              size: 55,
            ),
          ),

          const SizedBox(height: 15),

          Text(
            widget.roomName,
            style: const TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'غرفة صوتية',
            style: TextStyle(fontSize: 16),
          ),

          const SizedBox(height: 30),

          const Text(
            'المتحدثون',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          const Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.mic_none,
                    size: 60,
                  ),
                  SizedBox(height: 15),
                  Text(
                    'أنت داخل الغرفة',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'نظام الصوت الحقيقي سيتم ربطه لاحقًا.',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(
              left: 24,
              right: 24,
              bottom: 30,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton.large(
                  heroTag: 'microphone',
                  onPressed: () {
                    setState(() {
                      microphoneOn = !microphoneOn;
                    });
                  },
                  child: Icon(
                    microphoneOn
                        ? Icons.mic
                        : Icons.mic_off,
                  ),
                ),

                FloatingActionButton.large(
                  heroTag: 'leave',
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.call_end,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
