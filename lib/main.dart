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
        scaffoldBackgroundColor: const Color(0xFF080912),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8B5CF6),
          brightness: Brightness.dark,
        ),
        fontFamily: 'Arial',
      ),
      home: const MekoHome(),
    );
  }
}

class MekoHome extends StatefulWidget {
  const MekoHome({super.key});

  @override
  State<MekoHome> createState() => _MekoHomeState();
}

class _MekoHomeState extends State<MekoHome> {
  int currentIndex = 0;

  final List<Map<String, dynamic>> rooms = [
    {
      'title': 'ليالي Meko',
      'subtitle': 'سهر وضحك وتعارف',
      'people': 328,
      'speakers': 8,
      'icon': Icons.nightlife_rounded,
      'color': Color(0xFF8B5CF6),
    },
    {
      'title': 'Meko Music',
      'subtitle': 'موسيقى وأجواء جميلة 🎵',
      'people': 241,
      'speakers': 6,
      'icon': Icons.music_note_rounded,
      'color': Color(0xFFEC4899),
    },
    {
      'title': 'تعرف ودردشة',
      'subtitle': 'ناس جديدة وسوالف جديدة',
      'people': 187,
      'speakers': 5,
      'icon': Icons.forum_rounded,
      'color': Color(0xFF06B6D4),
    },
    {
      'title': 'جلسة الأصدقاء',
      'subtitle': 'خلينا نسولف ❤️',
      'people': 96,
      'speakers': 4,
      'icon': Icons.people_alt_rounded,
      'color': Color(0xFFF97316),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: currentIndex,
          children: [
            _homePage(),
            _discoverPage(),
            _createPage(),
            _notificationsPage(),
            _profilePage(),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xFF0D0F1D),
        indicatorColor: const Color(0xFF34205F),
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'الرئيسية',
          ),
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore_rounded),
            label: 'اكتشف',
          ),
          NavigationDestination(
            icon: Icon(Icons.add_circle_outline_rounded),
            selectedIcon: Icon(Icons.add_circle_rounded),
            label: 'إنشاء',
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications_none_rounded),
            selectedIcon: Icon(Icons.notifications_rounded),
            label: 'الإشعارات',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'حسابي',
          ),
        ],
      ),
    );
  }

  Widget _homePage() {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 5),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF8B5CF6),
                        Color(0xFFEC4899),
                      ],
                    ),
                  ),
                  child: const Icon(
                    Icons.person_rounded,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'أهلًا بك 👋',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white54,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Meko',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
                _circleButton(Icons.search_rounded),
                const SizedBox(width: 8),
                _circleButton(Icons.mail_outline_rounded),
              ],
            ),
          ),
        ),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Container(
              height: 205,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF4C1D95),
                    Color(0xFF7C3AED),
                    Color(0xFFDB2777),
                  ],
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x55341263),
                    blurRadius: 25,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: -25,
                    top: -35,
                    child: Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.08),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 25,
                    bottom: -45,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.06),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '🎙️  Meko Voice',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'صوتك له مكان هنا',
                          style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'ادخل غرفة، تعرف على ناس\nواستمتع بالوقت.',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white70,
                            height: 1.4,
                          ),
                        ),
                        const Spacer(),
                        FilledButton(
                          onPressed: () {
                            setState(() {
                              currentIndex = 1;
                            });
                          },
                          style: FilledButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: const Color(0xFF6D28D9),
                          ),
                          child: const Text(
                            'اكتشف الآن',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              children: [
                const Text(
                  '🔥 الغرف المباشرة',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    setState(() {
                      currentIndex = 1;
                    });
                  },
                  child: const Text('عرض الكل'),
                ),
              ],
            ),
          ),
        ),

        SliverPadding(
          padding: const EdgeInsets.fromLTRB(18, 8, 18, 20),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return _roomCard(rooms[index]);
              },
              childCount: rooms.length,
            ),
          ),
        ),
      ],
    );
  }

  Widget _circleButton(IconData icon) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: const Color(0xFF141727),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Icon(icon, size: 21),
    );
  }

  Widget _roomCard(Map<String, dynamic> room) {
    final Color color = room['color'] as Color;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VoiceRoomPage(room: room),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 13),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFF111423),
          borderRadius: BorderRadius.circular(23),
          border: Border.all(
            color: color.withOpacity(0.20),
          ),
        ),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  width: 65,
                  height: 65,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      colors: [
                        color,
                        color.withOpacity(0.45),
                      ],
                    ),
                  ),
                  child: Icon(
                    room['icon'] as IconData,
                    size: 31,
                  ),
                ),
                Positioned(
                  right: -2,
                  top: -2,
                  child: Container(
                    width: 13,
                    height: 13,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.greenAccent,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    room['title'] as String,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    room['subtitle'] as String,
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.people_alt_rounded,
                        size: 15,
                        color: Colors.white54,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${room['people']} موجود',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.white54,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Icon(
                        Icons.mic_rounded,
                        size: 15,
                        color: Colors.white54,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${room['speakers']} متحدث',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.white54,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_left_rounded,
              color: Colors.white30,
            ),
          ],
        ),
      ),
    );
  }

  Widget _discoverPage() {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const SizedBox(height: 5),
        const Text(
          'اكتشف ✨',
          style: TextStyle(
            fontSize: 29,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          'اختار جوّك وادخل المكان اللي يعجبك',
          style: TextStyle(
            color: Colors.white54,
          ),
        ),
        const SizedBox(height: 22),

        SizedBox(
          height: 48,
          child: TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFF141727),
              hintText: 'ابحث عن غرفة أو شخص...',
              prefixIcon: const Icon(Icons.search_rounded),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(17),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),

        const SizedBox(height: 22),

        const Text(
          'التصنيفات',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 12),

        Wrap(
          spacing: 9,
          runSpacing: 9,
          children: [
            _category('🎵 موسيقى'),
            _category('😂 ترفيه'),
            _category('❤️ تعارف'),
            _category('🎮 ألعاب'),
            _category('⚽ رياضة'),
            _category('🌙 سهر'),
          ],
        ),

        const SizedBox(height: 25),

        const Text(
          'الغرف المقترحة',
          style: TextStyle(
            fontSize: 20,
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

  Widget _category(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 11,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF141727),
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: Colors.white.withOpacity(0.05),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _createPage() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF8B5CF6),
                    Color(0xFFEC4899),
                  ],
                ),
              ),
              child: const Icon(
                Icons.mic_rounded,
                size: 55,
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              'أنشئ غرفتك 🎙️',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'ابدأ غرفتك الخاصة واجمع أصحابك\nوتكلموا واستمتعوا مع بعض.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white54,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: FilledButton.icon(
                onPressed: _showCreateRoomDialog,
                icon: const Icon(Icons.add_rounded),
                label: const Text(
                  'إنشاء غرفة جديدة',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCreateRoomDialog() {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFF15182A),
          title: const Text('إنشاء غرفة 🎙️'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'اسم الغرفة',
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
                Navigator.pop(dialogContext);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'سيتم تفعيل إنشاء الغرف الحقيقي في المرحلة القادمة 🔥',
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

  Widget _notificationsPage() {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const SizedBox(height: 5),
        const Text(
          'الإشعارات',
          style: TextStyle(
            fontSize: 29,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 20),
        _
