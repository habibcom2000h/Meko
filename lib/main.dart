import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';

const String agoraAppId = '391d156ea0c446a9adc8efebe89d70b7';
const String agoraTempToken = 'PUT_YOUR_TEMP_TOKEN_HERE';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyAyD2OG9U2ygast19nU97iorST-OIhuvCI',
      appId: '1:901776027185:android:e139298119cf7b42742f10',
      messagingSenderId: '901776027185',
      projectId: 'meko-ccf1c',
      storageBucket: 'meko-ccf1c.firebasestorage.app',
    ),
  );

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
      home: FirebaseAuth.instance.currentUser == null
          ? const LoginPage()
          : const HomePage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool loading = false;

  Future<void> login() async {
    if (emailController.text.trim().isEmpty ||
        passwordController.text.isEmpty) {
      return;
    }

    setState(() => loading = true);

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const HomePage(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? 'حدث خطأ أثناء تسجيل الدخول'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => loading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meko'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'تسجيل الدخول',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 25),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'الإيميل',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'كلمة المرور',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: loading ? null : login,
                child: loading
                    ? const CircularProgressIndicator()
                    : const Text('دخول'),
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const RegisterPage(),
                  ),
                );
              },
              child: const Text('إنشاء حساب جديد'),
            ),
          ],
        ),
      ),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool loading = false;

  Future<void> register() async {
    if (emailController.text.trim().isEmpty ||
        passwordController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('اكتب إيميل وكلمة مرور من 6 أحرف على الأقل'),
        ),
      );
      return;
    }

    setState(() => loading = true);

    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(credential.user!.uid)
            .set({
          'email': emailController.text.trim(),
          'createdAt': FieldValue.serverTimestamp(),
        }).timeout(const Duration(seconds: 5));
      } catch (_) {}

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const HomePage(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? 'فشل إنشاء الحساب'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => loading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إنشاء حساب'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'الإيميل',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'كلمة المرور',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: loading ? null : register,
                child: loading
                    ? const CircularProgressIndicator()
                    : const Text('إنشاء الحساب'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();

    if (!context.mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginPage(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meko'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => logout(context),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('rooms')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'حدث خطأ في تحميل الغرف:\n${snapshot.error}',
                textAlign: TextAlign.center,
              ),
            );
          }

          final rooms = snapshot.data?.docs ?? [];

          if (rooms.isEmpty) {
            return const Center(
              child: Text('لا توجد غرف حاليًا'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: rooms.length,
            itemBuilder: (context, index) {
              final data =
                  rooms[index].data() as Map<String, dynamic>;

              final title =
                  data['title']?.toString() ?? 'غرفة بدون اسم';

              final speakers =
                  data['speakers']?.toString() ?? '0';

              final listeners =
                  data['listeners']?.toString() ?? '0';

              return Card(
                margin: const EdgeInsets.only(bottom: 14),
                child: ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.mic),
                  ),
                  title: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    '$speakers متحدثين • $listeners مستمعين',
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => VoiceRoomPage(
                          roomId: rooms[index].id,
                          roomTitle: title,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class VoiceRoomPage extends StatefulWidget {
  final String roomId;
  final String roomTitle;

  const VoiceRoomPage({
    super.key,
    required this.roomId,
    required this.roomTitle,
  });

  @override
  State<VoiceRoomPage> createState() => _VoiceRoomPageState();
}

class _VoiceRoomPageState extends State<VoiceRoomPage> {
  RtcEngine? engine;

  bool joined = false;
  bool muted = false;
  String status = 'جاري تجهيز الغرفة...';

  @override
  void initState() {
    super.initState();
    initializeAgora();
  }

  Future<void> initializeAgora() async {
    if (agoraAppId == 'PUT_YOUR_AGORA_APP_ID_HERE' ||
        agoraTempToken == 'PUT_YOUR_TEMP_TOKEN_HERE') {
      setState(() {
        status = 'نحتاج App ID و Temporary Token من Agora';
      });
      return;
    }

    try {
      final rtcEngine = createAgoraRtcEngine();

      await rtcEngine.initialize(
        RtcEngineContext(
          appId: agoraAppId,
        ),
      );

      await rtcEngine.enableAudio();

      rtcEngine.registerEventHandler(
        RtcEngineEventHandler(
          onJoinChannelSuccess: (connection, elapsed) {
            if (mounted) {
              setState(() {
                joined = true;
                status = 'تم الدخول إلى الغرفة 🎙️';
              });
            }
          },
          onUserJoined: (connection, remoteUid, elapsed) {
            if (mounted) {
              setState(() {});
            }
          },
          onUserOffline: (connection, remoteUid, reason) {
            if (mounted) {
              setState(() {});
            }
          },
          onError: (err, msg) {
            if (mounted) {
              setState(() {
                status = 'Agora: $err';
              });
            }
          },
        ),
      );

      engine = rtcEngine;

      await rtcEngine.joinChannel(
        token: agoraTempToken,
        channelId: widget.roomId,
        uid: 0,
        options: const ChannelMediaOptions(
          clientRoleType: ClientRoleType.clientRoleBroadcaster,
          channelProfile:
              ChannelProfileType.channelProfileLiveBroadcasting,
        ),
      );
    } catch (e) {
      if (mounted) {
        setState(() {
          status = 'خطأ: $e';
        });
      }
    }
  }

  Future<void> toggleMute() async {
    final rtcEngine = engine;

    if (rtcEngine == null) return;

    muted = !muted;

    await rtcEngine.muteLocalAudioStream(muted);

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> leaveRoom() async {
    try {
      await engine?.leaveChannel();
      await engine?.release();
    } catch (_) {}

    if (!mounted) return;

    Navigator.pop(context);
  }

  @override
  void dispose() {
    engine?.leaveChannel();
    engine?.release();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.roomTitle),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 45,
                child: Icon(
                  Icons.mic,
                  size: 45,
                ),
              ),
              const SizedBox(height: 25),
              Text(
                widget.roomTitle,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                status,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 35),
              if (joined)
                IconButton.filled(
                  onPressed: toggleMute,
                  icon: Icon(
                    muted ? Icons.mic_off : Icons.mic,
                  ),
                  iconSize: 32,
                ),
              const SizedBox(height: 20),
              OutlinedButton(
                onPressed: leaveRoom,
                child: const Text('خروج من الغرفة'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
