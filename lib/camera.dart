import 'package:flutter/material.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  final List<String> hardcodedMedicines = [
    'Calcium Carbonate',
    'Fluconazole',
    'Levofloxacin Hemihydrate',
    'Diphtheria + Pertussis + Tetanus [DPT]'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medicine Detection'),
      ),
      body: ListView.builder(
        itemCount: hardcodedMedicines.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.medical_services),
            title: Text(hardcodedMedicines[index]),
          );
        },
      ),
    );
  }
}
