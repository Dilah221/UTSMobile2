import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flexible TextField Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FlexibleTextField(),
    );
  }
}

class FlexibleTextField extends StatefulWidget {
  @override
  _FlexibleTextFieldState createState() => _FlexibleTextFieldState();
}

class _FlexibleTextFieldState extends State<FlexibleTextField> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flexible TextField'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Masukkan teks:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity, // Membuat TextField mengisi lebar layar
              child: TextField(
                controller: _controller,
                maxLines: null, // Membiarkan TextField tumbuh sesuai panjang teks
                minLines: 1, // Baris minimal
                decoration: InputDecoration(
                  labelText: 'Tulis sesuatu...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
