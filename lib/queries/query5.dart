import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

class Query5 extends StatefulWidget {
  Query5(
      {Key? key,
      required this.conn,
      })
      : super(key: key);
  final MySQLConnection conn;
  Future<List<String>>? tableData;

  @override
  State<Query5> createState() => _Query5State();
}

class _Query5State extends State<Query5> {
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
        title: Text('Glasglow property prices'),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: widget.conn.execute(
                "select property_no, property_type, property_address from property where property_city = 'Glasglow' and registered_at = 'B003'"),
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


                for (int i = 0; i < snapshot.data!.numOfRows; i++) {
                  property_no.add(
                      snapshot.data!.rows.elementAt(i).assoc()['property_no']!);
                  property_type.add(snapshot.data!.rows
                      .elementAt(i)
                      .assoc()['property_type']!);

                  property_address.add(snapshot.data!.rows
                      .elementAt(i)
                      .assoc()['property_address']!);
                }

                _data = MyData(
                    property_no,
                    property_type,
                    property_address,
                    snapshot.data!.numOfRows);
                return PaginatedDataTable(
                  rowsPerPage: 10,
                  columns: [
                    DataColumn(label: Text('Property No')),
                    DataColumn(label: Text('Property Type')),
                    DataColumn(label: Text('Property Rooms')),
                    DataColumn(label: Text('Property Rent')),
                    DataColumn(label: Text('Property Address')),
                    DataColumn(label: Text('Property Owner')),
                    DataColumn(label: Text('Registered At')),
                    DataColumn(label: Text('Property City')),
                    DataColumn(label: Text('Managed By')),
                    DataColumn(label: Text('Staff Name')),
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
      this.dataLength);
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
          Text(property_type![index]),
        ),

        DataCell(
          Text(property_address![index]),
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
