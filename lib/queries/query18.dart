import 'package:dbms_project/components/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

class Query18 extends StatefulWidget {
  Query18({Key? key, required this.conn, required this.branch,  required this.fullName})
      : super(key: key);
  final String? fullName;
  final MySQLConnection conn;
  final String branch;
  Future<List<String>>? tableData;

  @override
  State<Query18> createState() => _Query18State();
}

class _Query18State extends State<Query18> {

  late DataTableSource _data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  String? fullName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Staff List at branch ' + widget.branch),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(

          child: Column(
            children: [


              FutureBuilder(
                future: widget.conn
                    .execute("SELECT full_name FROM staff WHERE supervisor_name = '${widget.fullName}'"),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else {
                    late  List<String> fullName = [];



                    for (int i = 0; i < snapshot.data!.numOfRows; i++) {
                      fullName.add(snapshot.data!.rows.elementAt(i).assoc()['full_name']!);


                    }



                    _data = MyData(fullName,snapshot.data!.numOfRows);
                    return PaginatedDataTable(
                      rowsPerPage: 10,
                      columns: [
                        DataColumn(label: Text('Full Name')),

                      ],
                      source: _data,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyData extends DataTableSource {
  MyData(this.fullName,this.dataLength);
  List<String>? fullName;

  int dataLength;

  @override
  DataRow? getRow(int index) {
    return DataRow(
      cells: [

        DataCell(Text(
            fullName![index]
        ),),
        ],
    );
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => dataLength;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}
