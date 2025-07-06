import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_cv/utils.dart';

class Person extends StatefulWidget {
  const Person({super.key});

  @override
  _Person createState() => _Person();
}

class _Person extends State<Person> {
  final client = HttpClient();

  @override
  void initState() {
    super.initState();
    _getDataFromSheets();
  }

  Future<DataTable> _getDataFromSheets() async {

    Map dataDict = await getSheetsData(action: "read");
    print("Got data: ${dataDict}");
    List columns = dataDict["columns"];
    List data = dataDict["data"];

    List<DataRow> tableRows = [];
    List<DataColumn> tableHeads = List<DataColumn>.generate(
        columns.length, (index) => DataColumn(label: Text(columns[index])));

    for (int i = 0; i < data.length; i++) {
      DataRow row = DataRow(
        cells: List<DataCell>.generate(
            columns.length, (index) => DataCell(Text("${data[i][index]}"))),
      );

      tableRows.add(row);
    }
    DataTable dataset = DataTable(
      columns: tableHeads,
      rows: tableRows,
      columnSpacing: 20.0,
      dataRowMinHeight: 10.0,
      dataRowMaxHeight: 25.0,
      dividerThickness: 2.0,
    );

    return dataset;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getDataFromSheets(),
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Employees Info"),
            ),
            body: Column(
              children: <Widget>[
                Expanded(
                    flex: 8,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(bottom: 20.0, top: 10.0),
                        scrollDirection: Axis.vertical,
                        child: snapshot.data,
                      ),
                    ))
              ],
            ),
          );
        });
  }
}