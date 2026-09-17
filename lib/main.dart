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
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF090A12),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF7C4DFF),
          brightness: Brightness.dark,
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
  int currentIndex = 0;

  final List<Map<String, dynamic>> rooms = [
    {
      'name': 'غرفة الأصدقاء',
      'people': '24',
      'speakers': '12',
      'emoji': '🎙️',
    },
    {
      'name': 'موسيقى وسهر',
      'people': '31',
      'speakers': '8',
      'emoji': '🎵',
    },
    {
      'name': 'تعرف ودردشة',
      'people': '18',
      'speakers': '6',
      'emoji': '💬',
    },
    {
      'name': 'سهرة Meko',
      'people': '42',
      'speakers': '10',
      'emoji': '🔥',
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
            fontSize: 25,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: IndexedStack(
        index: currentIndex,
        children: [
          homePage(),
          discoverPage(),
          createPage(),
          profilePage(),
        ],
      ),
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
            icon: Icon(Icons.add_circle_outline),
            selectedIcon: Icon(Icons.add_circle),
            label: 'إنشاء',
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

  Widget homePage() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'أهلاً بك في Meko 👋',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'ادخل غرفة وتعرف على أشخاص جدد',
          style: TextStyle(
            color: Colors.white.withOpacity(0.65),
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 22),
        const Text(
          'الغرف النشطة 🔥',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ...rooms.map(
          (room) => roomCard(room),
        ),
      ],
    );
  }

  Widget roomCard(Map<String, dynamic> room) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VoiceRoom(room: room),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: const Color(0xFF7C4DFF).withOpacity(0.18),
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.center,
                child: Text(
                  room['emoji'],
                  style: const TextStyle(fontSize: 28),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      room['name'],
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      '${room['speakers']} متحدثين • ${room['people']} مستمع',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_left),
            ],
          ),
        ),
      ),
    );
  }

  Widget discoverPage() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'اكتشف 🔎',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 18),
        TextField(
          decoration: InputDecoration(
            hintText: 'ابحث عن غرفة...',
            prefixIcon: const Icon(Icons.search),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'التصنيفات',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            category('🎵 موسيقى'),
            category('💬 دردشة'),
            category('❤️ تعارف'),
            category('🎮 ألعاب'),
            category('⚽ رياضة'),
            category('😂 ترفيه'),
          ],
        ),
      ],
    );
  }

  Widget category(String text) {
    return Chip(
      label: Text(text),
      padding: const EdgeInsets.all(8),
    );
  }

  Widget createPage() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.mic,
              size: 80,
              color: Color(0xFF9C6CFF),
            ),
            const SizedBox(height: 20),
            const Text(
              'إنشاء غرفة صوتية',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'أنشئ غرفتك وابدأ الدردشة مع الآخرين',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withOpacity(0.65),
              ),
            ),
            const SizedBox(height: 25),
            FilledButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('سيتم تفعيل إنشاء الغرف قريباً 🚀'),
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('إنشاء غرفة'),
            ),
          ],
        ),
      ),
    );
  }

  Widget profilePage() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const CircleAvatar(
          radius: 48,
          child: Icon(
            Icons.person,
            size: 52,
          ),
        ),
        const SizedBox(height: 14),
        const Center(
          child: Text(
            'عضو Meko',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 22),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            Stat(
              number: '0',
              title: 'المتابعون',
            ),
            Stat(
              number: '0',
              title: 'أتابعهم',
            ),
            Stat(
              number: '0',
              title: 'الغرف',
            ),
          ],
        ),
        const SizedBox(height: 30),
        Card(
          child: ListTile(
            leading: const Icon(Icons.star),
            title: const Text('النقاط'),
            trailing: const Text(
              '0',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
        Card(
          child: ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('الإعدادات'),
            trailing: const Icon(Icons.chevron_left),
          ),
        ),
      ],
    );
  }
}

class Stat extends StatelessWidget {
  final String number;
  final String title;

  const Stat({
    super.key,
    required this.number,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            color: Colors.white.withOpacity(0.6),
          ),
        ),
      ],
    );
  }
}

class VoiceRoom extends StatefulWidget {
  final Map<String, dynamic> room;

  const VoiceRoom({
    super.key,
    required this.room,
  });

  @override
  State<VoiceRoom> createState() => _VoiceRoomState();
}

class _VoiceRoomState extends State<VoiceRoom> {
  bool micOn = false;
  int likes = 126;

  final List<String> messages = [
    'أهلاً بالجميع 👋',
    'شو الأخبار؟ ❤️',
    'أجواء حلوة اليوم 🔥',
    'مين جديد بالغرفة؟',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.room['name']),
      ),
      body: Column(
        children: [
          const SizedBox(height: 18),
          Text(
            widget.room['emoji'],
            style: const TextStyle(fontSize: 55),
          ),
          const SizedBox(height: 8),
          Text(
            '${widget.room['people']} شخص داخل الغرفة',
            style: TextStyle(
              color: Colors.white.withOpacity(0.65),
            ),
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              speaker('أحمد', '🧑🏻', true),
              speaker('سارة', '👩🏻', false),
              speaker('محمد', '👨🏻', false),
              speaker('ليان', '👩🏻', true),
            ],
          ),
          const SizedBox(height: 25),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color(0xFF10121C),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
              ),
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      messages[index],
                      style: const TextStyle(fontSize: 16),
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 18),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'اكتب رسالة...',
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () {
                    setState(() {
                      likes++;
                    });
                  },
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.pink,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      micOn = !micOn;
                    });
                  },
                  icon: Icon(
                    micOn ? Icons.mic : Icons.mic_off,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget speaker(
    String name,
    String emoji,
    bool active,
  ) {
    return Column(
      children: [
        Container(
          width: 62,
          height: 62,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: active
                  ? const Color(0xFF9C6CFF)
                  : Colors.transparent,
              width: 3,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            emoji,
            style: const TextStyle(fontSize: 30),
          ),
        ),
        const SizedBox(height: 6),
        Text(name),
      ],
    );
  }
}
