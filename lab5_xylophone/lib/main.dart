import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() => runApp(const XylophoneApp());

class XylophoneApp extends StatelessWidget {
  const XylophoneApp({super.key});

  // Hàm phát âm thanh dùng package mới
  void playSound(int soundNumber) {
    final player = AudioPlayer();
    // AssetSource mặc định sẽ trỏ thẳng vào thư mục 'assets/'
    player.play(AssetSource('note$soundNumber.wav')); 
  }

  // Hàm tạo ra 1 phím đàn
  Expanded buildKey({required Color color, required int soundNumber}) {
    return Expanded(
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: color,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero, // Bỏ bo góc để các phím dính chặt vào nhau
          ),
        ),
        onPressed: () {
          playSound(soundNumber);
        },
        child: const SizedBox(), // Phím đàn không cần text bên trong
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, // Kéo giãn phím bấm ra full chiều ngang
            children: [
              buildKey(color: Colors.red, soundNumber: 1),
              buildKey(color: Colors.orange, soundNumber: 2),
              buildKey(color: Colors.yellow, soundNumber: 3),
              buildKey(color: Colors.green, soundNumber: 4),
              buildKey(color: Colors.teal, soundNumber: 5),
              buildKey(color: Colors.blue, soundNumber: 6),
              buildKey(color: Colors.purple, soundNumber: 7),
            ],
          ),
        ),
      ),
    );
  }
}