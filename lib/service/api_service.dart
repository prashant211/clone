import 'dart:convert';
import 'package:form_app/model/formmodel/form_fieldmodel.dart';
import 'package:http/http.dart' as http;


class ApiService {
  final String apiUrl = 'https://crmapi.conscor.com/api/general/v1/mfind';

  Future<FormSchema> fetchFormSchema() async {
    final response = await http.post(
      Uri.parse(apiUrl),
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
      final jsonResponse = jsonDecode(response.body);
      final formSchemaJson = jsonResponse['data'].firstWhere((item) => item['code'] == 'COMPANY_SCHEMA_001');
      return FormSchema.fromJson(formSchemaJson);
    } else {
      throw Exception('Failed to load form schema');
    }
  }
}
