import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../model/formmodel/form_fieldmodel.dart';
import 'package:form_app/controller/form_controller.dart';

class DynamicForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DynamicFormController>(
      init: DynamicFormController(),
      builder: (controller) {
        if (controller.formSchema.value == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final form = controller.formSchema.value!.form;
        if (form.isEmpty) return const SizedBox.shrink();

        final section = form.first.section;
        final fields = section.fields;

        return Scaffold(
          body: Column(
            children: [
              const SizedBox(height: 90),
              Material(
                elevation: 4.0,
                borderRadius: BorderRadius.circular(16.0),
                child: Container(
                  height: 400,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 18.0),
                        child: Text(
                          'Company Details',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Material(
                        elevation: 4.0,
                        borderRadius: BorderRadius.circular(16.0),
                        child: Container(
                          height: 350,
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                section.name,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(height: 5),
                              Expanded(
                                child: GridView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: section.noOfClmn,
                                    crossAxisSpacing: 16.0,
                                    childAspectRatio: 2,
                                  ),
                                  itemCount: fields.length,
                                  itemBuilder: (context, index) {
                                    final field = fields[index];
                                    return _buildField(field, controller);
                                  },
                                ),
                              ),
                              // Save button
                              Align(
                                alignment: Alignment.bottomRight,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                    controller.submitForm();
                                  },
                                  child: Container(
                                    height: 45,
                                    decoration: BoxDecoration(
                                        color: const Color(0xff2563eb),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.save,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            'Save and Continue',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Build form fields
  Widget _buildField(Field field, DynamicFormController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(field.label, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 4),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: _buildInputField(field, controller),
          ),
        ],
      ),
    );
  }


  Widget _buildInputField(Field field, DynamicFormController controller) {
    switch (field.type) {
      case 'text':
        return TextField(
          onChanged: (value) {
            controller.updateFormData(field.name, value);
          },
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(8),
          ),
        );
      case 'number':
        return _buildNumberField(field, controller);
      case 'dropdown':
        return _buildDropdownField(field, controller);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildNumberField(Field field, DynamicFormController controller) {
    return TextField(
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      onChanged: (value) {
        controller.updateFormData(field.name, value);
      },
      decoration: const InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.all(8),
      ),
    );
  }

  Widget _buildDropdownField(Field field, DynamicFormController controller) {
    List<String> options = ["Option 1", "Option 2", "Option 3"];
    return DropdownButtonFormField<String>(
      value: null,
      items: options.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (newValue) {
        controller.updateFormData(field.name, newValue);
      },
      decoration: const InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.all(8),
      ),
    );
  }
}
