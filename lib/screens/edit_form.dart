import 'package:flutter/material.dart';
import 'package:form_app/controller/main_controller.dart';
import 'package:get/get.dart';


class EditFormScreen extends StatelessWidget {
  final Map<String, dynamic> formData;
  final bool isEditMode;

  // TextEditingControllers for managing the input fields
  final TextEditingController nameController;
  final TextEditingController agentRateController;
  final TextEditingController cityController;

  EditFormScreen({required this.formData, this.isEditMode = false})
      : nameController = TextEditingController(text: formData['name'] ?? ''),
        agentRateController = TextEditingController(text: formData['agentrate']?.toString() ?? ''),
        cityController = TextEditingController(text: formData['city'] ?? '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditMode ? 'Edit Company' : 'Add Company'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextFormField(
              controller: agentRateController,
              decoration: InputDecoration(labelText: 'Agent Rate (%)'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: cityController,
              decoration: InputDecoration(labelText: 'City'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Collect the updated data from the controllers
                Map<String, dynamic> updatedData = {
                  'name': nameController.text,
                  'agentrate': agentRateController.text,
                  'city': cityController.text,
                };

                // API call to update the data
                Get.find<SelectedItemController>().updateCompany(updatedData);
                Navigator.of(context).pop(); // Return to previous screen
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
