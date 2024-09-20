import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../model/formmodel/form_fieldmodel.dart';
import '../service/api_service.dart';

class DynamicFormController extends GetxController {
  var formSchema = Rxn<FormSchema>();
  var formData = <String, dynamic>{}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchFormSchema();
  }

  void fetchFormSchema() async {
    final apiService = ApiService();
    formSchema.value = await apiService.fetchFormSchema();
  }

  void updateFormData(String fieldName, dynamic value) {
    formData[fieldName] = value;
    update();
    print("Updated formData: $formData"); // Log the updated form data
  }

  Future<void> submitForm() async {
    final requestBody = {
      "dbName": "customize-5",
      "collectionName": "company_details",
      "query": {}, // Adjust as necessary
      "projection": {},
      "limit": 5,
      "skip": 0,
      "data": formData, // Include the form data
    };

    // Log the request body before sending
    print('Request Body: ${jsonEncode(requestBody)}');

    // Headers for the request
    final headers = {
      'Content-Type': 'application/json',
      'x-api-key': 'PLLW0s5A6Rk1aZeAmWr1',
    };

    try {
      final response = await http.post(
        Uri.parse('https://crmapi.conscor.com/api/general/v1/mfind'),
        headers: headers,
        body: jsonEncode(requestBody),
      );

      // Log the response status and body
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        print('Form data submitted successfully');
      } else {
        print('Failed to submit form data: ${response.body}');
      }
    } catch (error) {
      print('Error submitting form data: $error');
    }
  }
}
