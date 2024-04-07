import 'package:flutter/material.dart';
import 'package:gap/camera.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generic Alternative Provider'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => CameraPage(),
                  ));
            },
            child: const Text('Open Camera')),
      ),
    );
  }
}
