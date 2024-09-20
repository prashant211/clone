import 'package:flutter/material.dart';
import 'package:form_app/controller/form_controller.dart';
import 'package:form_app/controller/main_controller.dart';
import 'package:get/get.dart';
import 'package:form_app/screens/home_screen.dart';
import 'package:form_app/screens/company_screen.dart';
import 'package:form_app/screens/test_screen.dart';

void main() {

  Get.put(SelectedItemController());
  Get.put(DynamicFormController ());


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dynamic Navigation App',
      initialRoute: '/main',
      getPages: [
        GetPage(name: '/main', page: () => MainScreen()),
        GetPage(name: '/test', page: () => TestScreen()),
        GetPage(name: '/company', page: () => CompanyScreen()),
      ],
    );
  }
}


