import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

class Query17 extends StatefulWidget {
  Query17({Key? key, required this.conn, required this.branch})
      : super(key: key);
  final MySQLConnection conn;
  final String branch;
  Future<List<String>>? tableData;

  @override
  State<Query17> createState() => _Query17State();
}

class _Query17State extends State<Query17> {

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
                    .execute("SELECT s.staff_no, s.full_name AS Staff_Name, COUNT(*) "
                    "AS total_properties FROM staff s "
                    "JOIN property p ON s.staff_no = p.managed_by"
                    " WHERE s.staff_branch = '${widget.branch}' GROUP BY s.staff_no"),
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
                    late List<String> staffNo = [];
                    late  List<String> fullName = [];
                    late  List<String> total = [];

                    ;


                    for (int i = 0; i < snapshot.data!.numOfRows; i++) {
                      staffNo.add(snapshot.data!.rows.elementAt(i).assoc()['staff_no']!);
                      fullName.add(snapshot.data!.rows.elementAt(i).assoc()['Staff_Name']!);
                      total.add(snapshot.data!.rows.elementAt(i).assoc()['total_properties']!);

                    }



                    _data = MyData(staffNo, fullName, total ,snapshot.data!.numOfRows);
                    return PaginatedDataTable(
                      rowsPerPage: 10,
                      columns: [
                        DataColumn(label: Text('Staff No')),
                        DataColumn(label: Text('Full Name')),
                        DataColumn(label: Text('Total')),

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
  MyData(this.staffNo, this.fullName, this.total , this.dataLength);
  List<String> staffNo;
  List<String>? fullName;
  List<String>? total;


  int dataLength;

  @override
  DataRow? getRow(int index) {
    return DataRow(
      cells: [
        DataCell(
          Text(staffNo![index]),
        ),
        DataCell(Text(
            fullName![index]
        ),),
        DataCell(Text(
            total![index]
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
