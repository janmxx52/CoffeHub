import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseTestPage extends StatefulWidget {
  const FirebaseTestPage({super.key});

  @override
  State<FirebaseTestPage> createState() => _FirebaseTestPageState();
}

class _FirebaseTestPageState extends State<FirebaseTestPage> {
  String result = "Đang kiểm tra...";

  @override
  void initState() {
    super.initState();
    testFirebase();
  }

  Future<void> testFirebase() async {
    String text = "";

    try {
      // ===========================
      // 1. Firebase Initialize
      // ===========================
      Firebase.app();
      text += "✅ Firebase Initialize: Thành công\n\n";

      // ===========================
      // 2. Firebase Auth
      // ===========================
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        text += "✅ Firebase Auth: Hoạt động (Chưa đăng nhập)\n\n";
      } else {
        text += "✅ Firebase Auth: ${user.email}\n\n";
      }

      // ===========================
      // 3. Firestore
      // ===========================
      final snapshot =
      await FirebaseFirestore.instance.collection("users").limit(1).get();

      text +=
      "✅ Firestore kết nối thành công\n";
      text += "Số document đọc được: ${snapshot.docs.length}\n";
    } catch (e) {
      text += "\n❌ Có lỗi xảy ra:\n";
      text += e.toString();
    }

    setState(() {
      result = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebase Test"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SelectableText(
          result,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}