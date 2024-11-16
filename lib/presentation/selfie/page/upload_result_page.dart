import 'package:flutter/material.dart';

class UploadResultPage extends StatefulWidget {
  const UploadResultPage({super.key});

  @override
  State<UploadResultPage> createState() => _UploadResultPageState();
}

class _UploadResultPageState extends State<UploadResultPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text('Upload Result Page'),
        ),
      ),
    );
  }
}
