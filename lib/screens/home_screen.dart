// main_screen.dart
import 'package:flutter/material.dart';
import 'package:form_app/widget/custom_drawer.dart';



class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text('Main Screen'),
      ),
    );
  }
}
