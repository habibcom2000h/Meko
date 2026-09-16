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
        scaffoldBackgroundColor: const Color(0xFF090A16),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF7C4DFF),
          brightness: Brightness.dark,
        ),
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
      'subtitle': 'سهر • ضحك • تعارف',
      'people': 128,
      'speakers': 8,
      'icon': Icons.nightlife_rounded,
      'color': Color(0xFF7C4DFF),
    },
    {
      'title': 'موسيقى وسهر',
      'subtitle': 'استمع وشاركنا الجو 🎵',
      'people': 94,
      'speakers': 6,
      'icon': Icons.music_note_rounded,
      'color': Color(0xFFE040FB),
    },
    {
      'title': 'تعرف ودردشة',
      'subtitle': 'ناس جديدة • سوالف جديدة',
      'people': 67,
      'speakers': 5,
      'icon': Icons.forum_rounded,
      'color': Color(0xFF00BFA6),
    },
    {
      'title': 'جلسة الأصدقاء',
      'subtitle': 'مكانك مع أصحابك ❤️',
      'people': 42,
      'speakers': 4,
      'icon': Icons.people_alt_rounded,
      'color': Color(0xFFFF6D00),
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
        backgroundColor: const Color(0xFF0E1020),
        indicatorColor: const Color(0xFF30205F),
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
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 8),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF7C4DFF),
                        Color(0xFFE040FB),
                      ],
                    ),
                  ),
                  child: const Icon(
                    Icons.person_rounded,
                    size: 27,
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
                          fontSize: 14,
                          color: Colors.white60,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Meko',
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                _topButton(Icons.search_rounded),
                const SizedBox(width: 8),
                _topButton(Icons.mail_outline_rounded),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
            child: Container(
              height: 170,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF5E35B1),
                    Color(0xFF7C4DFF),
                    Color(0xFFE040FB),
                  ],
                ),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 25,
                    offset: Offset(0, 10),
                    color: Color(0x55000000),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: -35,
                    top: -45,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.08),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '🎙️ عالمك الصوتي',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'ادخل، تكلم،\nوخلي صوتك يوصل',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                            height: 1.1,
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
                            foregroundColor: const Color(0xFF5E35B1),
                          ),
                          child: const Text('اكتشف الغرف'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  '🔥 الغرف النشطة',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Text(
                  'عرض الكل',
                  style: TextStyle(
                    color: Color(0xFFB388FF),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
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

  Widget _roomCard(Map<String, dynamic> room) {
    final Color roomColor = room['color'] as Color;

    return GestureDetector(
      onTap: () {
        _openRoom(room);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF111326),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: roomColor.withOpacity(0.22),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    gradient: LinearGradient(
                      colors: [
                        roomColor,
                        roomColor.withOpacity(0.45),
                      ],
                    ),
                  ),
                  child: Icon(
                    room['icon'] as IconData,
                    size: 29,
                  ),
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
                      const SizedBox(height: 5),
                      Text(
                        room['subtitle'] as String,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white54,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 7,
                        height: 7,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.greenAccent,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '${room['people']}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                SizedBox(
                  width: 110,
                  height: 30,
                  child: Stack(
                    children: [
                      _avatar(0, 'A'),
                      _avatar(26, 'M'),
                      _avatar(52, 'S'),
                      _avatar(78, '+'),
                    ],
                  ),
                ),
                const Spacer(),
                Text(
                  '${room['speakers']} متحدثين',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white54,
                  ),
                ),
                const SizedBox(width: 10),
                const Icon(
                  Icons.mic_rounded,
                  size: 16,
                  color: Colors.white54,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _avatar(double left, String letter) {
    return Positioned(
      left: left,
      top: 0,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFF292C44),
          border: Border.all(
            color: const Color(0xFF111326),
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            letter,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _topButton(IconData icon) {
    return Container(
      width: 43,
      height: 43,
      decoration: BoxDecoration(
        color: const Color(0xFF14172A),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Icon(icon, size: 21),
    );
  }

  Widget _discoverPage() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'اكتشف ✨',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'اكتشف ناس وغرف جديدة',
          style: TextStyle(color: Colors.white54),
        ),
        const SizedBox(height: 25),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            _category('🎵 موسيقى'),
            _category('😂 ترفيه'),
            _category('❤️ تعارف'),
            _category('🎮 ألعاب'),
            _category('⚽ رياضة'),
            _category('🌙 سهر'),
          ],
        ),
        const SizedBox(height: 28),
        const Text(
          'الغرف المقترحة',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 14),
        ...rooms.map((room) => _roomCard(room)),
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
        color: const Color(0xFF14172A),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFF272A40),
        ),
      ),
      child: Text(text),
    );
  }

  Widget _createPage() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 105,
              height: 105,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF7C4DFF),
                    Color(0xFFE040FB),
                  ],
                ),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 35,
                    color: Color(0x557C4DFF),
                  ),
                ],
              ),
              child: const Icon(
                Icons.mic_rounded,
                size: 48,
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              'أنشئ غرفتك',
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'ابدأ جلسة صوتية خاصة بك\nوادعُ الآخرين للانضمام',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white54,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: FilledButton.icon(
                onPressed: () {
                  _showCreateRoomDialog();
                },
                icon: const Icon(Icons.add_rounded),
                label: const Text(
                  'إنشاء غرفة جديدة',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCreateRoomDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF15182B),
          title: const Text('غرفة جديدة 🎙️'),
          content: const Text(
            'هذه الواجهة جاهزة، وسنربط إنشاء الغرفة الحقيقي في المرحلة القادمة.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('حسنًا'),
            ),
          ],
        );
      },
    );
  }

  Widget _notificationsPage() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'الإشعارات',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 22),
        _notification(
          Icons.favorite_rounded,
          'أعجب شخص بمنشورك',
          'منذ 5 دقائق',
        ),
        _notification(
          Icons.person_add_rounded,
          'لديك متابع جديد',
          'منذ 20 دقيقة',
        ),
        _notification(
          Icons.mic_rounded,
          'بدأت غرفة جديدة قد تهمك',
          'منذ ساعة',
        ),
      ],
    );
  }

  Widget _notification(
    IconData icon,
    String title,
    String time,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF111326),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFF27203F),
            child: Icon(
              icon,
              color: const Color(0xFFB388FF),
              size: 20,
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: const TextStyle(
                    color: Colors.white38,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _profilePage() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const SizedBox(height: 20),
        Center(
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF7C4DFF),
                  Color(0xFFE040FB),
                ],
              ),
            ),
            child: const Icon(
              Icons.person_rounded,
              size: 52,
            ),
          ),
        ),
        const SizedBox(height: 15),
        const Center(
          child: Text(
            'مستخدم Meko',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 5),
        const Center(
          child: Text(
            '@meko_user',
            style: TextStyle(color: Colors.white54),
          ),
        ),
        const SizedBox(height: 28),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _stat('0', 'المتابعون'),
            _stat('0', 'المتابَعون'),
            _stat('0', 'الغرف'),
          ],
        ),
        const SizedBox(height: 30),
        _profileButton(Icons.edit_rounded, 'تعديل الملف الشخصي'),
        _profileButton(Icons.settings_rounded, 'الإعدادات'),
        _profileButton(Icons.help_outline_rounded, 'المساعدة'),
      ],
    );
  }

  Widget _stat(String number, String title) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white54,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _profileButton(IconData icon, String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        tileColor: const Color(0xFF111326),
        leading: Icon(
          icon,
          color: const Color(0xFFB388FF),
        ),
        title: Text(text),
        trailing: const Icon(
          Icons.chevron_left_rounded,
          color: Colors.white38,
        ),
      ),
    );
  }

  void _openRoom(Map<String, dynamic> room) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF101225),
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.72,
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              children: [
                Container(
                  width: 45,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 25),
                Container(
                  width: 85,
                  height: 85,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(27),
                    gradient: LinearGradient(
                      colors: [
                        room['color'] as Color,
                        (room['color'] as Color).withOpacity(0.45),
                      ],
                    ),
                  ),
                  child: Icon(
                    room['icon'] as IconData,
                    size: 42,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  room['title'] as String,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  room['subtitle'] as String,
                  style: const TextStyle(color: Colors.white54),
                ),
                const SizedBox(height: 28),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 4,
                    mainAxisSpacing: 18,
                    crossAxisSpacing: 10,
                    children: List.generate(
                      8,
                      (index) {
                        return Column(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: const Color(0xFF292C44),
                              child: Text(
                                String.fromCharCode(65 + index),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'عضو ${index + 1}',
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.white54,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: FilledButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.mic_rounded),
                    label: const Text(
                      'دخول الغرفة',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
