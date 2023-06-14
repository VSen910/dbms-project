import 'package:dbms_project/components/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

class Query14 extends StatefulWidget {
  Query14({Key? key, required this.conn}) : super(key: key);
  final MySQLConnection conn;

  @override
  State<Query14> createState() => _Query14State();
}

class _Query14State extends State<Query14> {
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
        title: Text('Glasgow Staff Info'),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                future: widget.conn.execute(
                    "SELECT position, COUNT(*) as total_staff FROM staff INNER JOIN branch ON "
                    "staff.staff_branch = branch.branch_no WHERE branch.branch_city = 'Glasgow' GROUP BY position"),
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
                    late List<String> totalStaff = [];
                    late List<String> position = [];

                    for (int i = 0; i < snapshot.data!.numOfRows; i++) {
                      totalStaff.add(snapshot.data!.rows
                          .elementAt(i)
                          .assoc()['total_staff']!);
                      position.add(snapshot.data!.rows
                          .elementAt(i)
                          .assoc()['position']!);
                    }

                    _data =
                        MyData(totalStaff, position, snapshot.data!.numOfRows);
                    return PaginatedDataTable(
                      rowsPerPage: 10,
                      columns: [
                        DataColumn(label: Text('Position')),
                        DataColumn(label: Text('Total staff')),
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
  MyData(this.totalStaff, this.position, this.dataLength);
  List<String> totalStaff;
  List<String>? position;
  int dataLength;

  @override
  DataRow? getRow(int index) {
    return DataRow(
      cells: [
        DataCell(
          Text(position![index]),
        ),
        DataCell(
          Text(totalStaff![index]),
        ),
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
