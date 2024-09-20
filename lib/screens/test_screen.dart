// test_screen.dart
import 'package:flutter/material.dart';
import 'package:form_app/widget/custom_drawer.dart';

class TestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text('Test Screen'),
      ),
      body: const Center(
        child: Text('Test Content Here'),
      ),
    );
  }
}
