import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

class Query25 extends StatefulWidget {
  Query25({Key? key, required this.conn, required this.properties})
      : super(key: key);
  final MySQLConnection conn;

  final String properties;
  Future<List<String>>? tableData;

  @override
  State<Query25> createState() => _Query25State();
}

class _Query25State extends State<Query25> {

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
        title: Text('Number of properties at all branches ' + widget.properties),
        elevation: 0,
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: widget.conn
              .execute(" FROM property GROUP BY property_type;"),
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

              late List<String> property_t = [];
              late List<String> property_total = [];


              for (int i = 0; i < snapshot.data!.numOfRows; i++) {

                property_t.add(snapshot.data!.rows.elementAt(i).assoc()['property_type']!);
                property_total.add(snapshot.data!.rows.elementAt(i).assoc()['total_properties']!);


              }
              _data = MyData(property_t,property_total,snapshot.data!.numOfRows);
              return Container(
                child: PaginatedDataTable(

                  rowsPerPage: 10,
                  columns: [

                    DataColumn(label: Text('Property Type'),),
                    DataColumn(label: Text('Total_properties'),),

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
  MyData(this.property_t,this.total_property,this.dataLength);

  List<String>? property_t;
  List<String>? total_property;
  int dataLength;

  @override
  DataRow? getRow(int index) {
    return DataRow(
      cells: [

        DataCell(
          Text(property_t![index]),
        ),
        DataCell(
          Text(total_property![index]),
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