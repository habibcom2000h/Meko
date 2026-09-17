
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
  int index = 0;

  final List<Map<String, dynamic>> rooms = [
    {
      'name': 'ليالي Meko',
      'info': 'سهر وضحك وتعارف',
      'people': 328,
      'color': Color(0xFF8B5CF6),
      'icon': Icons.nightlife_rounded,
    },
    {
      'name': 'Meko Music',
      'info': 'موسيقى وأجواء جميلة 🎵',
      'people': 241,
      'color': Color(0xFFEC4899),
      'icon': Icons.music_note_rounded,
    },
    {
      'name': 'تعرف ودردشة',
      'info': 'ناس جديدة وسوالف جديدة',
      'people': 187,
      'color': Color(0xFF06B6D4),
      'icon': Icons.forum_rounded,
    },
    {
      'name': 'جلسة الأصدقاء',
      'info': 'خلينا نسولف ❤️',
      'people': 96,
      'color': Color(0xFFF97316),
      'icon': Icons.people_alt_rounded,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: index,
          children: [
            home(),
            discover(),
            createRoom(),
            notifications(),
            profile(),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xFF0D0F1D),
        selectedIndex: index,
        onDestinationSelected: (value) {
          setState(() {
            index = value;
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
            icon: Icon(Icons.notifications_none),
            selectedIcon: Icon(Icons.notifications),
            label: 'الإشعارات',
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

  Widget home() {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        Row(
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
              child: const Icon(Icons.person),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'أهلًا بك 👋',
                    style: TextStyle(
                      color: Colors.white54,
                    ),
                  ),
                  Text(
                    'Meko',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            circleButton(Icons.search),
            const SizedBox(width: 8),
            circleButton(Icons.mail_outline),
          ],
        ),

        const SizedBox(height: 20),

        Container(
          height: 205,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: const LinearGradient(
              colors: [
                Color(0xFF4C1D95),
                Color(0xFF7C3AED),
                Color(0xFFDB2777),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '🎙️ Meko Voice',
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'صوتك له مكان هنا',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'ادخل غرفة وتعرف على ناس جديدة',
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
              const Spacer(),
              FilledButton(
                onPressed: () {
                  setState(() {
                    index = 1;
                  });
                },
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF6D28D9),
                ),
                child: const Text('اكتشف الآن'),
              ),
            ],
          ),
        ),

        const SizedBox(height: 25),

        Row(
          children: [
            const Text(
              '🔥 الغرف المباشرة',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                setState(() {
                  index = 1;
                });
              },
              child: const Text('عرض الكل'),
            ),
          ],
        ),

        const SizedBox(height: 8),

        ...rooms.map((room) {
          return roomCard(room);
        }),
      ],
    );
  }

  Widget circleButton(IconData icon) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: const Color(0xFF141727),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Icon(icon),
    );
  }

  Widget roomCard(Map<String, dynamic> room) {
    final Color color = room['color'] as Color;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return VoiceRoom(
                room: room,
              );
            },
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFF111423),
          borderRadius: BorderRadius.circular(23),
          border: Border.all(
            color: color.withOpacity(0.25),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(19),
                gradient: LinearGradient(
                  colors: [
                    color,
                    color.withOpacity(0.45),
                  ],
                ),
              ),
              child: Icon(
                room['icon'] as IconData,
                size: 30,
              ),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    room['name'] as String,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    room['info'] as String,
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.people,
                        size: 15,
                        color: Colors.white54,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '${room['people']} موجود',
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Icon(
                        Icons.mic,
                        size: 15,
                        color: Colors.white54,
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        'متحدثون',
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_left,
              color: Colors.white38,
            ),
          ],
        ),
      ),
    );
  }

  Widget discover() {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const Text(
          'اكتشف ✨',
          style: TextStyle(
            fontSize: 29,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'اختار الغرفة المناسبة لك',
          style: TextStyle(
            color: Colors.white54,
          ),
        ),
        const SizedBox(height: 20),

        TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFF141727),
            hintText: 'ابحث عن غرفة...',
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(17),
              borderSide: BorderSide.none,
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
          spacing: 8,
          runSpacing: 8,
          children: [
            category('🎵 موسيقى'),
            category('😂 ترفيه'),
            category('❤️ تعارف'),
            category('🎮 ألعاب'),
            category('⚽ رياضة'),
            category('🌙 سهر'),
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

        ...rooms.map((room) {
          return roomCard(room);
        }),
      ],
    );
  }

  Widget category(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 11,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF141727),
        borderRadius: BorderRadius.circular(17),
      ),
      child: Text(text),
    );
  }

  Widget createRoom() {
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
                Icons.mic,
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
              'ابدأ غرفة خاصة بك واجمع أصحابك',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white54,
              ),
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: FilledButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text(
                          'غرفة جديدة 🎙️',
                        ),
                        content: const Text(
                          'إنشاء الغرف الحقيقي سنفعله مع السيرفر.',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('حسنًا'),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text(
                  'إنشاء غرفة جديدة',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget notifications() {
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
        notification(
          Icons.favorite,
          'أعجب شخص بمنشورك',
          'منذ 5 دقائق',
        ),
        notification(
          Icons.person_add,
          'لديك متابع جديد',
          'منذ 20 دقيقة',
        ),
        notification(
          Icons.mic,
          'بدأت غرفة جديدة',
          'منذ ساعة',
        ),
        notification(
          Icons.card_giftcard,
          'وصلتك هدية 🎁',
          'منذ ساعتين',
        ),
      ],
    );
  }

  Widget notification(
    IconData icon,
    String title,
    String time,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF111423),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFF292044),
            child: Icon(icon),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(title),
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

  Widget profile() {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const SizedBox(height: 20),
        Center(
          child: Container(
            width: 105,
            height: 105,
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
              Icons.person,
              size: 55,
            ),
          ),
        ),
        const SizedBox(height: 15),
        const Center(
          child: Text(
            'مستخدم Meko',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        const SizedBox(height: 5),
        const Center(
          child: Text(
            '@meko_user',
            style: TextStyle(
              color: Colors.white54,
            ),
          ),
        ),
        const SizedBox(height: 25),

        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF111423),
            borderRadius: BorderRadius.circular(22),
          ),
          child: const Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceEvenly,
            children: [
              Stat(
                number: '0',
                title: 'المتابعون',
              ),
              Stat(
                number: '0',
                title: 'المتابَعون',
              ),
              Stat(
                number: '0',
                title: 'الغرف',
              ),
              Stat(
                number: '0',
                title: 'النقاط',
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        profileButton(
          Icons.edit,
          'تعديل الملف الشخصي',
        ),
        profileButton(
          Icons.card_giftcard,
          'الهدايا والجوائز',
        ),
        profileButton(
          Icons.star,
          'المستوى والنقاط',
        ),
        profileButton(
          Icons.settings,
          'الإعدادات',
        ),
      ],
    );
  }

  Widget profileButton(
    IconData icon,
    String text,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        tileColor: const Color(0xFF111423),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        leading: Icon(
          icon,
          color: const Color(0xFFA78BFA),
        ),
        title: Text(text),
        trailing: const Icon(
          Icons.chevron_left,
          color: Colors.white38,
        ),
      ),
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
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        
