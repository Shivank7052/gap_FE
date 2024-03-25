import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gap/model/medicine.dart';

class ResultScreen extends StatelessWidget {
  final String text;

  const ResultScreen({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final parsedText = jsonDecode(text) as List<dynamic>;
    final medicines =
        parsedText.map((item) => Medicine.fromJson(item)).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
      ),
      body: ListView.builder(
          itemCount: parsedText.length,
          itemBuilder: (context, index) {
            final medicine = medicines[index];

            return Card(
              child: Column(
                children: [
                  Text('Drug Name: ${medicine.drugName}'),
                  Row(
                    children: [
                      const Text('Alternative brands: '),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: (medicine.alternativeBrands)!
                            .map((brand) => Text(brand))
                            .toList(),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Company: '),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: (medicine.company)!
                            .map((brand) => Text(brand))
                            .toList(),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }
}
