import 'package:flutter/material.dart';

void main() => runApp(const AIBossMessenger());

class AIBossMessenger extends StatelessWidget {
  const AIBossMessenger({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AI Boss Messenger',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0B141A),
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF121D24), elevation: 1),
        colorScheme: const ColorScheme.dark(primary: Color(0xFF00A884)),
      ),
      home: const LoginScreen(), // Sabse pehle Login khulega
    );
  }
}

// --- 1. OTP LOGIN SCREEN ---
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Enter your phone number", style: TextStyle(fontSize: 20, color: Color(0xFF00A884), fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text("AI Boss Messenger will send an SMS to verify.", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 30),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                prefixText: "+91 ",
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF00A884))),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00A884), minimumSize: const Size(double.infinity, 45)),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const OTPScreen())),
              child: const Text("NEXT", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

// --- 2. 4-DIGIT OTP VERIFICATION ---
class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Verifying number", style: TextStyle(fontSize: 16))),
      body: Column(
        children: [
          const SizedBox(height: 30),
          const Text("Enter 4-digit code below"),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(4, (index) => Container(
              width: 45,
              margin: const EdgeInsets.all(8),
              child: const TextField(textAlign: TextAlign.center, keyboardType: TextInputType.number, decoration: InputDecoration(hintText: "-")),
            )),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SecurityLockScreen())),
              child: const Text("VERIFY"),
            ),
          )
        ],
      ),
    );
  }
}

// --- 3. SECURITY (PATTERN & FINGERPRINT) ---
class SecurityLockScreen extends StatelessWidget {
  const SecurityLockScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.fingerprint, size: 90, color: Color(0xFF00A884)),
            const SizedBox(height: 20),
            const Text("Fingerprint or Pattern Lock", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 40),
            // Pattern Grid
            SizedBox(
              width: 200,
              child: GridView.count(
                shrinkWrap: true, crossAxisCount: 3,
                children: List.generate(9, (index) => const Icon(Icons.circle, size: 12, color: Colors.white24)),
              ),
            ),
            const SizedBox(height: 30),
            TextButton(
              onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const WhatsAppHome())),
              child: const Text("USE PATTERN TO UNLOCK", style: TextStyle(color: Color(0xFF00A884))),
            )
          ],
        ),
      ),
    );
  }
}

// --- 4. MAIN WHATSAPP INTERFACE (Same to Same) ---
class WhatsAppHome extends StatelessWidget {
  const WhatsAppHome({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("AI Boss Messenger"),
          actions: [
            const Icon(Icons.camera_alt_outlined),
            const SizedBox(width: 15),
            const Icon(Icons.search),
            PopupMenuButton(itemBuilder: (context) => [
              const PopupMenuItem(child: Text("New group")),
              const PopupMenuItem(child: Text("Settings")),
              const PopupMenuItem(child: Text("Profile & Bio")),
            ]),
          ],
          bottom: const TabBar(
            isScrollable: true,
            indicatorColor: Color(0xFF00A884),
            tabs: [
              Tab(icon: Icon(Icons.groups)),
              Tab(text: "CHATS"),
              Tab(text: "STATUS"),
              Tab(text: "CALLS"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const Center(child: Text("Communities")),
            const ChatList(), // Yahan Maya Assistant hai
            const Center(child: Text("Status - Add Bio here")),
            const Center(child: Text("Call Logs")),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFF00A884),
          onPressed: () {},
          child: const Icon(Icons.message, color: Colors.white),
        ),
      ),
    );
  }
}

// --- 5. CHAT LIST & REAL-TIME UI ---
class ChatList extends StatelessWidget {
  const ChatList({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: const CircleAvatar(backgroundColor: Colors.teal, child: Icon(Icons.bolt, color: Colors.white)),
          title: const Text("Maya AI Assistant", style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: const Text("Boss, PNR check karun ya Hotel book?"),
          trailing: const Text("12:00 PM"),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatDetailScreen(name: "Maya AI"))),
        ),
      ],
    );
  }
}

class ChatDetailScreen extends StatelessWidget {
  final String name;
  const ChatDetailScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        actions: const [Icon(Icons.video_call), SizedBox(width: 15), Icon(Icons.call), Icon(Icons.more_vert)],
      ),
      body: Column(
        children: [
          const Expanded(child: Center(child: Text("Start Chatting..."))),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(color: const Color(0xFF1F2C34), borderRadius: BorderRadius.circular(25)),
                    child: const TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.emoji_emotions_outlined, color: Colors.grey),
                        suffixIcon: Icon(Icons.attach_file, color: Colors.grey),
                        hintText: "Message",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                const CircleAvatar(backgroundColor: Color(0xFF00A884), child: Icon(Icons.mic, color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
