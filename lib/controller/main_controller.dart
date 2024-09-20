import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SelectedItemController extends GetxController {
  var jsonData = {}.obs;
  var rowData = <Map<String, dynamic>>[].obs;
  var isLoading = true.obs;
  var hasError = false.obs;
  var selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllData(); // Fetch data when the controller is initialized
  }

  // Fetch all data (Schema + Row Data)
  void fetchAllData() async {
    isLoading.value = true;
    hasError.value = false;

    await fetchSchema(); // First fetch schema

    if (!hasError.value) {
      await fetchRowData(); // Then fetch the row data
    }

    isLoading.value = false;
  }

  // Fetch Schema
  Future<void> fetchSchema() async {
    try {
      final response = await http.post(
        Uri.parse('https://crmapi.conscor.com/api/general/v1/mfind'),
        headers: {
          'content-type': 'application/json',
          'x-api-key': 'PLLW0s5A6Rk1aZeAmWr1',
        },
        body: jsonEncode({
          'dbName': 'customize-5',
          'collectionName': 'schema',
          'query': {},
          'projection': {},
          'limit': 5,
          'skip': 0,
        }),
      );

      if (response.statusCode == 200) {
        jsonData.value = json.decode(response.body);
        update(); // Notify UI
      } else {
        hasError.value = true;
        print('Failed to load schema data');
      }
    } catch (e) {
      hasError.value = true;
      print('Error fetching schema data: $e');
    }
  }

  // Fetch Row Data (Company Details)
  Future<void> fetchRowData() async {
    try {
      final response = await http.post(
        Uri.parse('https://crmapi.conscor.com/api/general/v1/mfind'),
        headers: {
          'content-type': 'application/json',
          'x-api-key': 'PLLW0s5A6Rk1aZeAmWr1',
        },
        body: jsonEncode({
          'dbName': 'customize-5',
          'collectionName': 'company_details',
          'query': {},
          'projection': {},
          'limit': 5,
          'skip': 0,
        }),
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        var fetchedData = List<Map<String, dynamic>>.from(data['data'] ?? []);

        var fieldNames = name; // Get the field names (not labels)

        if (fetchedData.isNotEmpty) {
          rowData.value = fetchedData.map<Map<String, dynamic>>((item) {
            var sectionData = Map<String, dynamic>.from(item['sectionData']['Agent Details'] ?? {});

            return Map<String, dynamic>.fromEntries(
              fieldNames.map((fieldName) {
                return MapEntry(fieldName, sectionData[fieldName] ?? '');
              }),
            );
          }).toList();

          update(); // Notify UI about data update
        }
      } else {
        hasError.value = true;
        print('Failed to load row data');
      }
    } catch (e) {
      hasError.value = true;
      print('Error fetching row data: $e');
    }
  }

  // Retry fetching data
  void retry() {
    fetchAllData(); // Retry the entire fetch process
  }

  // Column Headers
  List<String> get columnHeaders {
    var companySchema = jsonData['data']?.firstWhere(
          (config) => config['code'] == 'COMPANY_SCHEMA_001',
      orElse: () => null,
    )?['form']?.first['section']?['fields'] ?? [];

    return List<String>.from(companySchema.map((field) {
      return field['label'] ?? 'No Label';
    }));
  }

  // Field Names
  List<String> get name {
    var companySchema = jsonData['data']?.firstWhere(
          (config) => config['code'] == 'COMPANY_SCHEMA_001',
      orElse: () => null,
    )?['form']?.first['section']?['fields'] ?? [];

    return List<String>.from(companySchema.map((field) {
      return field['name'] ?? 'No Name';
    }));
  }

  // Select an item for edit
  void selectItem(int index) {
    selectedIndex.value = index;
  }

  // Update the company details in the backend
  Future<void> updateCompany(Map<String, dynamic> updatedData) async {
    try {
      final response = await http.post(
        Uri.parse('https://crmapi.conscor.com/api/general/v1/mupdate'),
        headers: {
          'content-type': 'application/json',
          'x-api-key': 'PLLW0s5A6Rk1aZeAmWr1',
        },
        body: jsonEncode({
          'dbName': 'customize-5',
          'collectionName': 'company_details',
          'query': {
            '_id': rowData[selectedIndex.value]['_id'], // Assuming each item has an _id
          },
          'update': {
            '\$set': {
              'sectionData.Agent Details': updatedData, // Update the Agent Details section
            },
          },
        }),
      );

      if (response.statusCode == 200) {
        print('Company details updated successfully');
        fetchRowData(); // Refresh the row data after the update
      } else {
        print('Failed to update company details');
      }
    } catch (e) {
      print('Error updating company details: $e');
    }
  }

  // Force a UI refresh when navigating back
  void refreshData() {
    fetchRowData();
  }
}
