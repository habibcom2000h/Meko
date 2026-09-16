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
  State<HomePage> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  final List<Map<String, dynamic>> rooms = [
    {
      'title': 'غرفة الأصدقاء',
      'speakers': 12,
      'listeners': 24,
      'icon': Icons.people,
    },
    {
      'title': 'موسيقى وسهر',
      'speakers': 8,
      'listeners': 31,
      'icon': Icons.music_note,
    },
    {
      'title': 'تعرف ودردشة',
      'speakers': 6,
      'listeners': 18,
      'icon': Icons.chat,
    },
    {
      'title': 'سهرة Meko',
      'speakers': 10,
      'listeners': 27,
      'icon': Icons.mic,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Meko',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none),
          ),
        ],
      ),
      body: IndexedStack(
        index: currentIndex,
        children: [
          buildHomePage(),
          buildDiscoverPage(),
          buildMessagesPage(),
          buildProfilePage(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showCreateRoomDialog();
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (int index) {
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
            label: 'اكتشاف',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline),
            selectedIcon: Icon(Icons.chat_bubble),
            label: 'الرسائل',
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

  Widget buildHomePage() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Colors.deepPurple,
                Colors.deepPurpleAccent,
              ],
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'أهلاً بك في Meko 👋',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'تحدث، استمع وتعرف على أصدقاء جدد',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'الغرف الصوتية',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ...rooms.map(
          (Map<String, dynamic> room) {
            return buildRoomCard(room);
          },
        ),
      ],
    );
  }

  Widget buildRoomCard(Map<String, dynamic> room) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      elevation: 1,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          openRoom(room['title'] as String);
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                child: Icon(
                  room['icon'] as IconData,
                  size: 28,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      room['title'] as String,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.mic,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${room['speakers']} متحدث',
                        ),
                        const SizedBox(width: 12),
                        const Icon(
                          Icons.people,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${room['listeners']} مستمع',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDiscoverPage() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.explore,
            size: 70,
          ),
          SizedBox(height: 16),
          Text(
            'اكتشف غرف وأصدقاء جدد',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMessagesPage() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.chat_bubble_outline,
            size: 70,
          ),
          SizedBox(height: 16),
          Text(
            'لا توجد رسائل حالياً',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProfilePage() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 45,
            child: Icon(
              Icons.person,
              size: 50,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'حساب Meko',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text('ملفك الشخصي'),
        ],
      ),
    );
  }

  void openRoom(String roomName) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return RoomPage(
            roomName: roomName,
          );
        },
      ),
    );
  }

  void showCreateRoomDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('إنشاء غرفة'),
          content: const Text(
            'سيتم إضافة إنشاء الغرف الصوتية في الخطوة القادمة.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('حسناً'),
            ),
          ],
        );
      },
    );
  }
}

class RoomPage extends StatelessWidget {
  final String roomName;

  const RoomPage({
    super.key,
    required this.roomName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(roomName),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 50,
                    child: Icon(
                      Icons.mic,
                      size: 55,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    roomName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'الغرفة الصوتية جاهزة',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  heroTag: 'micButton',
                  onPressed: () {},
                  child: const Icon(Icons.mic),
                ),
                FloatingActionButton(
                  heroTag: 'peopleButton',
                  onPressed: () {},
                  child: const Icon(Icons.people),
                ),
                FloatingActionButton(
                  heroTag: 'closeButton',
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(Icons.close),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
