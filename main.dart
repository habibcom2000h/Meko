import 'package:flutter/material.dart';

void main() => runApp(const MekoApp());

class MekoApp extends StatelessWidget {
  const MekoApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Meko', debugShowCheckedModeBanner: false,
    theme: ThemeData(useMaterial3: true, scaffoldBackgroundColor: const Color(0xFFF7F5FB), colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6C4AB6))),
    home: const MekoHomePage(),
  );
}

class MekoHomePage extends StatefulWidget { const MekoHomePage({super.key}); @override State<MekoHomePage> createState()=>_MekoHomePageState(); }
class _MekoHomePageState extends State<MekoHomePage> {
  int tab=0;
  final rooms=<Map<String,dynamic>>[
    {'emoji':'🎵','name':'سهرة Meko','desc':'ليلة موسيقية','count':128},
    {'emoji':'🔥','name':'دردشة الأصدقاء','desc':'تعال نحكي','count':86},
    {'emoji':'🎤','name':'غرفة المواهب','desc':'غناء ومواهب','count':64},
    {'emoji':'🌙','name':'سهرانين؟','desc':'دردشة ليلية','count':41},
  ];
  @override Widget build(BuildContext context)=>Scaffold(
    appBar: AppBar(backgroundColor:Colors.transparent,elevation:0,title:const Text('Meko',style:TextStyle(fontWeight:FontWeight.w800,fontSize:25)),actions:[IconButton(onPressed:(){},icon:const Icon(Icons.notifications_none_rounded)),const Padding(padding:EdgeInsets.only(right:14),child:CircleAvatar(radius:18,child:Icon(Icons.person_outline)))],),
    body:IndexedStack(index:tab,children:[_home(),_discover(),_profile()]),
    floatingActionButton:tab==0?FloatingActionButton.extended(backgroundColor:const Color(0xFF6C4AB6),foregroundColor:Colors.white,onPressed:_createRoom,icon:const Icon(Icons.add),label:const Text('إنشاء غرفة')):null,
    bottomNavigationBar:NavigationBar(selectedIndex:tab,onDestinationSelected:(i)=>setState(()=>tab=i),destinations:const [NavigationDestination(icon:Icon(Icons.home_outlined),selectedIcon:Icon(Icons.home),label:'الرئيسية'),NavigationDestination(icon:Icon(Icons.explore_outlined),selectedIcon:Icon(Icons.explore),label:'اكتشف'),NavigationDestination(icon:Icon(Icons.person_outline),selectedIcon:Icon(Icons.person),label:'حسابي')]),
  );
  Widget _home()=>ListView(padding:const EdgeInsets.fromLTRB(16,8,16,110),children:[Container(padding:const EdgeInsets.all(20),decoration:BoxDecoration(gradient:const LinearGradient(colors:[Color(0xFF6C4AB6),Color(0xFF9B6BE0)]),borderRadius:BorderRadius.circular(24)),child:const Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('أهلاً بك في Meko 👋',style:TextStyle(color:Colors.white,fontSize:23,fontWeight:FontWeight.bold)),SizedBox(height:8),Text('تعرّف على أشخاص جدد وادخل غرفتك الصوتية المفضلة.',style:TextStyle(color:Colors.white70,fontSize:15))])),const SizedBox(height:24),const Text('الغرف الصوتية الآن',style:TextStyle(fontSize:20,fontWeight:FontWeight.bold)),const SizedBox(height:12),...rooms.map(_roomCard)]);
  Widget _roomCard(Map<String,dynamic> r)=>Card(margin:const EdgeInsets.only(bottom:12),elevation:0,child:ListTile(contentPadding:const EdgeInsets.symmetric(horizontal:14,vertical:7),leading:CircleAvatar(radius:27,backgroundColor:const Color(0xFFE9DFFF),child:Text(r['emoji'],style:const TextStyle(fontSize:25))),title:Text(r['name'],style:const TextStyle(fontWeight:FontWeight.bold)),subtitle:Text('${r['desc']}  •  ${r['count']} مستمع'),trailing:const Icon(Icons.arrow_forward_ios_rounded,size:17),onTap:()=>_openRoom(r['name']));
  Widget _discover()=>const Center(child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[Icon(Icons.explore,size:70,color:Color(0xFF6C4AB6)),SizedBox(height:12),Text('اكتشف غرفاً وأصدقاء جدد',style:TextStyle(fontSize:20,fontWeight:FontWeight.bold))]));
  Widget _profile()=>Center(child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[const CircleAvatar(radius:42,child:Icon(Icons.person,size:42)),const SizedBox(height:12),const Text('مستخدم Meko',style:TextStyle(fontSize:21,fontWeight:FontWeight.bold)),TextButton.icon(onPressed:(){},icon:const Icon(Icons.edit),label:const Text('تعديل الملف الشخصي'))]));
  void _openRoom(String name)=>Navigator.push(context,MaterialPageRoute(builder:(_)=>VoiceRoomPage(roomName:name)));
  void _createRoom(){final c=TextEditingController();showDialog(context:context,builder:(_)=>AlertDialog(title:const Text('إنشاء غرفة'),content:TextField(controller:c,decoration:const InputDecoration(hintText:'اسم الغرفة',prefixIcon:Icon(Icons.mic))),actions:[TextButton(onPressed:()=>Navigator.pop(context),child:const Text('إلغاء')),FilledButton(onPressed:(){Navigator.pop(context);if(c.text.trim().isNotEmpty)_openRoom(c.text.trim());},child:const Text('إنشاء'))]));}
}

class VoiceRoomPage extends StatefulWidget { final String roomName; const VoiceRoomPage({super.key,required this.roomName}); @override State<VoiceRoomPage> createState()=>_VoiceRoomPageState(); }
class _VoiceRoomPageState extends State<VoiceRoomPage>{ bool muted=false; final users=['Habib','Meko Star','Lina','Ali','Sara','Omar']; @override Widget build(BuildContext context)=>Scaffold(backgroundColor:const Color(0xFF17121F),appBar:AppBar(backgroundColor:Colors.transparent,foregroundColor:Colors.white,title:Text(widget.roomName),actions:[IconButton(onPressed:(){},icon:const Icon(Icons.share_outlined))]),body:Column(children:[const SizedBox(height:12),const Icon(Icons.graphic_eq,color:Color(0xFFB990FF),size:55),const SizedBox(height:8),const Text('غرفة صوتية',style:TextStyle(color:Colors.white70)),const SizedBox(height:24),Expanded(child:GridView.builder(padding:const EdgeInsets.all(20),itemCount:users.length,gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:3,mainAxisSpacing:24,crossAxisSpacing:12,childAspectRatio:.85),itemBuilder:(_,i)=>Column(children:[CircleAvatar(radius:34,backgroundColor:i==0?const Color(0xFF9B6BE0):const Color(0xFF30263D),child:Text(users[i][0],style:const TextStyle(color:Colors.white,fontSize:25,fontWeight:FontWeight.bold))),const SizedBox(height:7),Text(users[i],overflow:TextOverflow.ellipsis,style:const TextStyle(color:Colors.white))]))),SafeArea(child:Padding(padding:const EdgeInsets.fromLTRB(20,8,20,16),child:Row(mainAxisAlignment:MainAxisAlignment.spaceEvenly,children:[_btn(muted?Icons.mic_off:Icons.mic,muted?'إلغاء الكتم':'كتم',()=>setState(()=>muted=!muted)),_btn(Icons.card_giftcard,'هدية',(){}),_btn(Icons.exit_to_app,'خروج',()=>Navigator.pop(context))])))]));
Widget _btn(IconData icon,String label,VoidCallback f)=>Column(children:[CircleAvatar(radius:28,backgroundColor:const Color(0xFF30263D),child:IconButton(onPressed:f,icon:Icon(icon,color:Colors.white))),const SizedBox(height:5),Text(label,style:const TextStyle(color:Colors.white70))]);}
