import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

class Query16 extends StatefulWidget {
  Query16(
      {Key? key,
        required this.conn,
      })
      : super(key: key);
  final MySQLConnection conn;
  Future<List<String>>? tableData;

  @override
  State<Query16> createState() => _Query16State();
}

class _Query16State extends State<Query16> {
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
        title: Text('Glasgow property prices'),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: widget.conn.execute(
                "SELECT Property_no, Property_address, Property_type,"
                    " Property_rent FROM Property "
                    "WHERE Property_address LIKE '%Glasgow%'"
                    " ORDER BY CAST(Property_rent AS SIGNED) ASC"),
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
                late List<String> property_no = [];
                late List<String> property_type = [];
                late List<String> property_address = [];
                late List<String> property_rent = [];



                for (int i = 0; i < snapshot.data!.numOfRows; i++) {
                  property_no.add(
                      snapshot.data!.rows.elementAt(i).assoc()['Property_no']!);
                  property_type.add(snapshot.data!.rows
                      .elementAt(i)
                      .assoc()['Property_type']!);

                  property_address.add(snapshot.data!.rows
                      .elementAt(i)
                      .assoc()['Property_address']!);

                  property_rent.add(snapshot.data!.rows
                      .elementAt(i)
                      .assoc()['Property_rent']!);
                }

                _data = MyData(
                    property_no,
                    property_type,
                    property_address,
                    property_rent,
                    snapshot.data!.numOfRows);
                return PaginatedDataTable(
                  rowsPerPage: 10,
                  columns: [
                    DataColumn(label: Text('Property No')),
                    DataColumn(label: Text('Property Address')),

                    DataColumn(label: Text('Property Type')),
                    DataColumn(label: Text('Property Rent')),

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
  MyData(
      this.property_no,
      this.property_type,

      this.property_address,
      this.property_rent,
      this.dataLength);

  List<String> property_rent;

  List<String> property_no;
  List<String>? property_type;

  List<String> property_address;

  int dataLength;

  @override
  DataRow? getRow(int index) {
    return DataRow(
      cells: [
        DataCell(
          Text(property_no![index]),
        ),
        DataCell(
          Text(property_address![index]),
        ),
        DataCell(
          Text(property_type![index]),
        ),
        DataCell(
          Text(property_rent![index]),
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
