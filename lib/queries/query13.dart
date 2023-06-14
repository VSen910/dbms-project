import 'package:dbms_project/components/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

class Query13 extends StatefulWidget {
  Query13({Key? key, required this.conn})
      : super(key: key);
  final MySQLConnection conn;

  @override
  State<Query13> createState() => _Query13State();
}

class _Query13State extends State<Query13> {

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
        title: Text('Total salary'),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(

          child: Column(
            children: [


              FutureBuilder(
                future: widget.conn
                    .execute("   SELECT COUNT(*) as total_staff, SUM(salary)  as total_salary FROM staff;"),
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
                    late  List<String> totalSalary = [];



                    for (int i = 0; i < snapshot.data!.numOfRows; i++) {
                      totalStaff.add(snapshot.data!.rows.elementAt(i).assoc()['total_staff']!);
                      totalSalary.add(snapshot.data!.rows.elementAt(i).assoc()['total_salary']!);

                    }



                    _data = MyData(totalStaff, totalSalary, snapshot.data!.numOfRows);
                    return PaginatedDataTable(
                      rowsPerPage: 10,
                      columns: [
                        DataColumn(label: Text('Total Staff')),
                        DataColumn(label: Text('Total Salary')),

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
  MyData(this.totalStaff, this.salary, this.dataLength);
  List<String> totalStaff;
  List<String>? salary;
  int dataLength;

  @override
  DataRow? getRow(int index) {
    return DataRow(
      cells: [
        DataCell(
          Text(totalStaff![index]),
        ),
        DataCell(Text(
            salary![index]
        ),
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
