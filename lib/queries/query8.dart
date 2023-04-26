import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

class Query8 extends StatefulWidget {
  Query8({Key? key, required this.conn})
      : super(key: key);
  final MySQLConnection conn;

  Future<List<String>>? tableData;

  @override
  State<Query8> createState() => _Query8State();
}

class _Query8State extends State<Query8> {

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
        title: Text('Client Info'),
        elevation: 0,
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: widget.conn
              .execute("select client.full_name as \"Full Name\", client.tel_no as \"Telephone Number\" from client, viewing_report where "
              "client.client_no = viewing_report.client_no and comments=null"),
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
              late List<String> fullName = [];
              late List<String> telephone=[];

              for (int i = 0; i < snapshot.data!.numOfRows; i++) {
                fullName.add(snapshot.data!.rows.elementAt(i).assoc()['Full Name']!);
                telephone.add(snapshot.data!.rows.elementAt(i).assoc()['Telephone Number']!);



              }
              _data = MyData(fullName, telephone,snapshot.data!.numOfRows);
              return Container(
                child: PaginatedDataTable(

                  rowsPerPage: 10,
                  columns: [
                    DataColumn(label: Text('Full Name'),),
                    DataColumn(label: Text('Telephone No.'),),


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
  MyData(this.fullName, this.telephone, this.dataLength);
  List<String>? fullName;
  List<String>? telephone;

  int dataLength;


  @override
  DataRow? getRow(int index) {
    return DataRow(
      cells: [
        DataCell(
          Text(fullName![index]),
        ),
        DataCell(
          Text(telephone![index]),
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
