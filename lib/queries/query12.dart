import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

class Query12 extends StatefulWidget {
  Query12({Key? key, required this.conn})
      : super(key: key);
  final MySQLConnection conn;
  Future<List<String>>? tableData;

  @override
  State<Query12> createState() => _Query12State();
}

class _Query12State extends State<Query12> {

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
        title: Text('Total Branches in each city'),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: widget.conn
                .execute("SELECT branch_city, COUNT(*) as total_branches FROM branch GROUP BY branch_city;"),
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
                late List<String> branchCity = [];
                late  List<String> count = [];


                for (int i = 0; i < snapshot.data!.numOfRows; i++) {
                  branchCity.add(snapshot.data!.rows.elementAt(i).assoc()['branch_city']!);
                  count.add(snapshot.data!.rows.elementAt(i).assoc()['total_branches']!);

                }

                _data = MyData(branchCity, count, snapshot.data!.numOfRows);
                return PaginatedDataTable(
                  rowsPerPage: 10,
                  columns: [
                    DataColumn(label: Text('Branch City')),
                    DataColumn(label: Text('Total Branches')),

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
  MyData(this.branchCity, this.count, this.dataLength);
  List<String> branchCity;
  List<String>? count;

  int dataLength;

  @override
  DataRow? getRow(int index) {
    return DataRow(
      cells: [
        DataCell(
          Text(branchCity![index]),
        ),
        DataCell(Text(
            count![index]
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
