import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

class RentedScreen extends StatefulWidget {
  RentedScreen({Key? key, required this.conn, required this.branch})
      : super(key: key);
  final MySQLConnection conn;
  final String branch;
  Future<List<String>>? tableData;

  @override
  State<RentedScreen> createState() => _RentedScreenState();
}

class _RentedScreenState extends State<RentedScreen> {

  late DataTableSource _data;
  //
  // Future<List<List<String>>> _getTableInfo() async{
  //  final results = await widget.conn.execute("select * from branch where branch_no = '$branch'");
  //  List<List<String>> data = [];
  //  for (var row in results) {
  //    data.add(row);
  //  }
  //
  //  return data;
  //
  // }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Staff List at branch ' + widget.branch),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: widget.conn
                .execute("select * from property where registered_at = '${widget.branch}' "
                "and property_no  IN (select property_no from lease)"),
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
                late  List<String> property_type = [];
                late List<String> property_rooms = [];
                late List<String> property_rent = [];
                late List<String> property_address = [];
                late List<String> property_owner = [];
                late List<String> registered_at = [];
                late List<String> property_city = [];
                late List<String> managed_by = [];
                late List<String> staff_name = [];


                for (int i = 0; i < snapshot.data!.numOfRows; i++) {
                  property_no.add(snapshot.data!.rows.elementAt(i).assoc()['property_no']!);
                  property_type.add(snapshot.data!.rows.elementAt(i).assoc()['property_type']!);
                  property_rooms.add(snapshot.data!.rows.elementAt(i).assoc()['property_rooms']!);
                  property_rent.add(snapshot.data!.rows.elementAt(i).assoc()['property_rent']!);
                  property_address.add(snapshot.data!.rows.elementAt(i).assoc()['property_address']!);
                  property_owner.add(snapshot.data!.rows.elementAt(i).assoc()['property_owner']!);
                  registered_at.add(snapshot.data!.rows.elementAt(i).assoc()['registered_at']!);
                  property_city.add(snapshot.data!.rows.elementAt(i).assoc()['property_city']!);
                  managed_by.add(snapshot.data!.rows.elementAt(i).assoc()['managed_by']!);
                  staff_name.add(snapshot.data!.rows.elementAt(i).assoc()['staff_name']!);


                }



                _data = MyData(property_no, property_type, property_rooms, property_rent, property_address,
                    property_owner, registered_at,managed_by,property_city, staff_name ,snapshot.data!.numOfRows);
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
  MyData(this.property_no, this.property_type, this.property_rooms,
      this.property_rent, this.property_address, this.property_owner,this.registered_at,
      this.managed_by, this.city, this.staff, this.dataLength);
  List<String> property_no;
  List<String>? property_type;
  List<String> property_rooms ;
  List<String> property_rent ;
  List<String> property_address ;
  List<String> property_owner;
  List<String> registered_at ;
  List<String> managed_by ;
  List<String> city ;
  List<String> staff;
  int dataLength;

  @override
  DataRow? getRow(int index) {
    return DataRow(
      cells: [
        DataCell(
          Text(property_no![index]),
        ),
        DataCell(Text(
            property_type![index]
        ),),
        DataCell(Text(
            property_rooms![index]
        ),),
        DataCell(Text(
            property_rent![index]
        ),),
        DataCell(Text(
            property_address![index]
        ),),
        DataCell(Text(
            property_owner![index]
        ),),
        DataCell(Text(
            registered_at![index]
        ),),
        DataCell(Text(
            managed_by![index]
        ),),
        DataCell(Text(
            city![index]
        ),),
        DataCell(Text(
            staff![index]
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
