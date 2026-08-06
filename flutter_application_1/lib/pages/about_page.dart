import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About ICT Cafe"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "lib/assets/logo.jpg",
                width: 150,
                height: 150,
              ),
              const SizedBox(height: 20),
              const Text(
                "ICT Cafe",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                "Kasetsart University\nKamphaeng Saen Campus",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text("เปิดทุกวัน 08.00 - 20.00 น."),
              const SizedBox(height: 10),
              const Text("โทร : 081-234-5678"),
              const SizedBox(height: 10),
              const Text("Facebook : ICT Cafe"),
            ],
          ),
        ),
      ),
    );
  }
}
