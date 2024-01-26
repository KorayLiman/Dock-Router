import 'package:flutter/material.dart';

class SampleTabPage extends StatefulWidget {
  const SampleTabPage({super.key});

  @override
  State<SampleTabPage> createState() => _SampleTabPageState();
}

class _SampleTabPageState extends State<SampleTabPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Tab Page'),
      ),
      body: const Center(
        child: ElevatedButton(
          onPressed: null,
          child: Text('Some button'),
        ),
      ),
    );
  }
}
