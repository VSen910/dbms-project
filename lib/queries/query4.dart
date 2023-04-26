import 'package:dbms_project/components/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

class Query4 extends StatefulWidget {
  Query4({Key? key, required this.conn, required this.branch})
      : super(key: key);
  final MySQLConnection conn;
  final String branch;
  Future<List<String>>? tableData;

  @override
  State<Query4> createState() => _Query4State();
}

class _Query4State extends State<Query4> {

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
                    .execute("select client.full_name as \"Client Name\", client.registered_by as \"Registered By\" from client where registered_at = '${widget.branch}'"),
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
                    late List<String> staffName = [];
                    late  List<String> fullName = [];

                    for (int i = 0; i < snapshot.data!.numOfRows; i++) {
                      staffName.add(snapshot.data!.rows.elementAt(i)
                          .assoc()['Client Name']!);
                      fullName.add(snapshot.data!.rows.elementAt(i)
                          .assoc()['Registered By']!);
                    }

                    _data = MyData(fullName,staffName,snapshot.data!.numOfRows);
                    return PaginatedDataTable(
                      rowsPerPage: 10,
                      columns: [
                        DataColumn(label: Text('Client Name')),
                        DataColumn(label: Text('Registered By')),

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
  MyData(this.staffName, this.fullName, this.dataLength);
  List<String> staffName;
  List<String>? fullName;
  int dataLength;
  @override
  DataRow? getRow(int index) {
    return DataRow(
      cells: [
        DataCell(
          Text(staffName![index]),
        ),
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
