import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_app/screens/edit_form.dart';
import 'package:get/get.dart';
import 'package:form_app/screens/add_newdata.dart';
import 'package:form_app/controller/main_controller.dart';

class CompanyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectedItemController>(
      init: SelectedItemController(),
      builder: (controller) {
        if (controller.isLoading.value) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (controller.jsonData.isEmpty || controller.rowData.isEmpty) {
          return const Scaffold(
            body: Center(
              child: Text('Failed to load data.'),
            ),
          );
        }

        List<String> headers = controller.columnHeaders;
        List<Map<String, dynamic>> rowData = controller.rowData;
        List<String> name = controller.name;

        List<List<String>> rows = rowData.map((row) {
          return name.map((header) {
            return row[header]?.toString() ?? '';
          }).toList();
        }).toList();

        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 80),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    elevation: 5,
                    child: Container(
                      height: 350,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Company',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => DynamicForm(),
                                    ));
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 75,
                                    decoration: BoxDecoration(
                                      color: Color(0xff2563eb),
                                      borderRadius: BorderRadius.circular(13),
                                    ),
                                    child: const Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 2),
                                        Text(
                                          'Add',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              children: headers
                                  .map((header) => Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0),
                                  child: Text(
                                    header,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ))
                                  .toList(),
                            ),
                          ),
                          const Divider(thickness: 2),
                          SizedBox(
                            height: 200,
                            child: ListView.separated(
                              itemCount: rows.length,
                              separatorBuilder: (context, index) =>
                              const Divider(),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => EditFormScreen(
                                          formData: rowData[index],
                                          isEditMode: true, // Pass edit mode
                                        ),
                                      ),
                                    );
                                  },
                                  child: Row(
                                    children: rows[index]
                                        .map((cell) => Expanded(
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.all(8.0),
                                        child: Text(
                                          cell,
                                          overflow: TextOverflow
                                              .ellipsis, // Prevent wrapping
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ))
                                        .toList(),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
