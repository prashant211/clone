// custom_drawer.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:form_app/controller/main_controller.dart';
import 'package:form_app/screens/company_screen.dart';
import 'package:form_app/screens/test_screen.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SelectedItemController controller = Get.find();

    return Drawer(
      child: Container(
        color: const Color(0xFF1F2937), // Drawer background color
        child: Column(
          children: [
            const SizedBox(height: 50), // Space above the first element
            Container(
              padding: const EdgeInsets.all(16), // Padding around content
              child: const Row(
                children: [
                  CircleAvatar(
                    radius: 35, // CircleAvatar with radius 35
                    backgroundImage: AssetImage('assets/logo.png'),
                  ),
                  SizedBox(width: 25),
                  Text(
                    'Custom - 5 ', // Static text next to the CircleAvatar
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20), // Space between header and list items
            Obx(() {
              return Column(
                children: [
                  // In the CustomDrawer
                  _buildListTile(
                    context,
                    index: 1,
                    icon: Icons.warning,
                    title: 'Test',
                    routeName: '/test', // Use the correct route name
                    selectedIndex: controller.selectedIndex.value,
                  ),

                  _buildListTile(
                    context,
                    index: 2,
                    icon: Icons.person,
                    title: 'Company',
                    routeName: '/company', // Use the correct route name
                    selectedIndex: controller.selectedIndex.value,
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(
    BuildContext context, {
    required int index,
    required IconData icon,
    required String title,
    required String routeName,
    required int selectedIndex,
  }) {
    final bool isSelected = selectedIndex == index;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color:
              isSelected ? Colors.white.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: Icon(icon, color: isSelected ? Colors.blue : Colors.white),
          title: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.blue : Colors.white,
              fontSize: 20,
            ),
          ),
          onTap: () {
            // Update selected item state
            Get.find<SelectedItemController>().selectItem(index);

            // Close the drawer and navigate to the selected screen
            Navigator.pop(context);
            Get.toNamed(routeName); // Use Get.toNamed for named routes
          },
        ),
      ),
    );
  }
}
