import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

class Query15 extends StatefulWidget {
  Query15({Key? key, required this.conn})
      : super(key: key);
  final MySQLConnection conn;
  Future<List<String>>? tableData;

  @override
  State<Query15> createState() => _Query15State();
}

class _Query15State extends State<Query15> {

  late DataTableSource _data;
  //

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Managers'),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: widget.conn
                .execute("SELECT branch_address, full_name as manager_name, branch_no FROM "
                "staff INNER JOIN branch ON staff.staff_branch = branch.branch_no "
                "WHERE position like '%Manager%' ORDER BY branch_address"),
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
                late List<String> branchAddress = [];
                late  List<String> managerName = [];
                late List<String> branch_no = [];

                for (int i = 0; i < snapshot.data!.numOfRows; i++) {
                  branchAddress.add(snapshot.data!.rows.elementAt(i).assoc()['branch_address']!);
                  managerName.add(snapshot.data!.rows.elementAt(i).assoc()['manager_name']!);
                  branch_no.add(snapshot.data!.rows.elementAt(i).assoc()['branch_no']!);


                }

                _data = MyData(branchAddress, managerName, branch_no, snapshot.data!.numOfRows);
                return PaginatedDataTable(
                  rowsPerPage: 10,
                  columns: [
                    DataColumn(label: Text('Branch Address')),
                    DataColumn(label: Text('Manager Name')),
                    DataColumn(label: Text('Branch No')),

                  ],
                  source: _data,
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class MyData extends DataTableSource {
  MyData(this.branchAddress, this.managerName, this.branchNo,  this.dataLength);
  List<String> branchAddress;
  List<String>? managerName;
  List<String>? branchNo;

  int dataLength;

  @override
  DataRow? getRow(int index) {
    return DataRow(
      cells: [
        DataCell(
          Text(branchAddress![index]),
        ),
        DataCell(Text(
            managerName![index]
        ),),
        DataCell(Text(
            branchNo![index]
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
