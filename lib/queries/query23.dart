import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

class Query23 extends StatefulWidget {
  Query23({Key? key, required this.conn, required this.total_property})
      : super(key: key);
  final MySQLConnection conn;

  final String total_property;
  Future<List<String>>? tableData;

  @override
  State<Query23> createState() => _Query23State();
}

class _Query23State extends State<Query23> {

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
        title: Text('Total number of properties' + widget.total_property),
        elevation: 0,
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: widget.conn
              .execute(" SELECT s.staff_no, s.full_name AS Staff_Name, COUNT(*) AS total_properties FROM staff s JOIN property p ON s.staff_no = p.managed_by WHERE p.managed_by ='${widget.total_property}'GROUP BY s.staff_no ;"),
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
              late List<String> staff_number = [];
              late List<String> staff_name = [];

              for (int i = 0; i < snapshot.data!.numOfRows; i++) {
                staff_number.add(snapshot.data!.rows.elementAt(i).assoc()['staff_no']!);
                staff_name.add(snapshot.data!.rows.elementAt(i).assoc()['Staff_Name']!);
                //staff_name.add(snapshot.data!.rows.elementAt(i).assoc()['Staff_Name']!);


              }
              _data = MyData(staff_number,staff_name,snapshot.data!.numOfRows);
              return Container(
                child: PaginatedDataTable(

                  rowsPerPage: 10,
                  columns: [
                    DataColumn(label: Text('Staff Number'),),
                    DataColumn(label: Text('Staff Name'),),
                    DataColumn(label: Text('Total Properties')),
                    

                  ],
                  source: _data,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class MyData extends DataTableSource {
  MyData(this.Staff_name, this.staff_number, this.dataLength);
  List<String>? Staff_name;
  List<String>? staff_number;
  int dataLength;

  @override
  DataRow? getRow(int index) {
    return DataRow(
      cells: [
        DataCell(
          Text(Staff_name![index]),
        ),
        DataCell(
          Text(staff_number![index]),
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
