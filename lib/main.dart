import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyAyD2OG9U2ygast19nU97iorST-OIhuvCI',
        appId: '1:901776027185:android:e139298119cf7b42742f10',
        messagingSenderId: '901776027185',
        projectId: 'meko-ccf1c',
        storageBucket: 'meko-ccf1c.firebasestorage.app',
      ),
    );
  } catch (e) {
    runApp(
      FirebaseErrorApp(
        error: e.toString(),
      ),
    );
    return;
  }

  runApp(const MekoApp());
}

class FirebaseErrorApp extends StatelessWidget {
  final String error;

  const FirebaseErrorApp({
    super.key,
    required this.error,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              'تعذر تشغيل Firebase\n\n$error',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
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
      home: const LoginPage(),
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
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      showMessage('اكتب الإيميل وكلمة المرور');
      return;
    }

    setState(() {
      loading = true;
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const HomePage(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      showMessage(
        'Firebase: ${e.code}\n${e.message ?? ''}',
      );
    } catch (e) {
      showMessage('خطأ: $e');
    }

    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  void showMessage(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        duration: const Duration(seconds: 6),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const Icon(
                  Icons.mic,
                  size: 85,
                ),
                const SizedBox(height: 15),
                const Text(
                  'Meko',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'غرف صوتية ودردشة',
                  style: TextStyle(fontSize: 17),
                ),
                const SizedBox(height: 35),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'البريد الإلكتروني',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'كلمة المرور',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: FilledButton(
                    onPressed: loading ? null : login,
                    child: loading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(),
                          )
                        : const Text(
                            'تسجيل الدخول',
                            style: TextStyle(fontSize: 17),
                          ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: OutlinedButton(
                    onPressed: loading
                        ? null
                        : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const RegisterPage(),
                              ),
                            );
                          },
                    child: const Text(
                      'إنشاء حساب جديد',
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool loading = false;

  Future<void> register() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (name.isEmpty || email.isEmpty || password.length < 6) {
      showMessage(
        'اكتب الاسم والإيميل وكلمة مرور من 6 أحرف على الأقل',
      );
      return;
    }

    setState(() {
      loading = true;
    });

    try {
      final result =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = result.user;

      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .set({
          'name': name,
          'email': email,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      if (!mounted) return;

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => const HomePage(),
        ),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      showMessage(
        'Firebase: ${e.code}\n${e.message ?? ''}',
      );
    } on FirebaseException catch (e) {
      showMessage(
        'Firebase: ${e.code}\n${e.message ?? ''}',
      );
    } catch (e) {
      showMessage('خطأ: $e');
    }

    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  void showMessage(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        duration: const Duration(seconds: 6),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إنشاء حساب'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 25),
              const Icon(
                Icons.person_add,
                size: 75,
              ),
              const SizedBox(height: 25),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'الاسم',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'البريد الإلكتروني',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'كلمة المرور',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: FilledButton(
                  onPressed: loading ? null : register,
                  child: loading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(),
                        )
                      : const Text(
                          'إنشاء الحساب',
                          style: TextStyle(fontSize: 17),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const rooms = [
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
  ];

  Future<void> logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      debugPrint('Logout error: $e');
    }

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
        title: const Text(
          'Meko',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => logout(context),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'الغرف الصوتية',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          ...rooms.map(
            (room) => Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: CircleAvatar(
                  radius: 28,
                  child: Icon(
                    room['icon'] as IconData,
                  ),
                ),
                title: Text(
                  room['title'] as String,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    '${room['speakers']} متحدث • '
                    '${room['listeners']} مستمع',
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                ),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'الغرفة الصوتية قيد التطوير 🎙️',
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
