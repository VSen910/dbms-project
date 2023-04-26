import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

class Query9 extends StatefulWidget {
  Query9({Key? key, required this.conn, this.fullName, this.propertyNo})
      : super(key: key);
  final MySQLConnection conn;
  final String? fullName;
  final String? propertyNo;

  Future<List<String>>? tableData;

  @override
  State<Query9> createState() => _Query9State();
}

class _Query9State extends State<Query9> {

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
              .execute("select * from lease where lease.client_no="
              "(select client_no from client where full_name = '${widget.fullName}')  "
              "and lease.property_no = '${widget.propertyNo}'"),
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
              late List<String> srNo = [];
              late List<String> propertyNo=[];
              late List<String> clientNo=[];
              late List<String> rentStart=[];
              late List<String> rentFinish=[];
              late List<String> duration=[];
              late List<String> monthlyRent=[];
              late List<String> deposit=[];
              late List<String> paymentMethod=[];

              for (int i = 0; i < snapshot.data!.numOfRows; i++) {

                  srNo.add(snapshot.data!.rows.elementAt(i).assoc()['sr_no']!);
                  propertyNo.add(snapshot.data!.rows.elementAt(i).assoc()['property_no']!);
                  clientNo.add(snapshot.data!.rows.elementAt(i).assoc()['client_no']!);
                  rentStart.add(snapshot.data!.rows.elementAt(i).assoc()['rent_start']!);
                  rentFinish.add(snapshot.data!.rows.elementAt(i).assoc()['rent_finish']!);
                  duration.add(snapshot.data!.rows.elementAt(i).assoc()['duration']!);
                  monthlyRent.add(snapshot.data!.rows.elementAt(i).assoc()['monthly_rent']!);
                  deposit.add(snapshot.data!.rows.elementAt(i).assoc()['deposit_paid']!);
                  paymentMethod.add(snapshot.data!.rows.elementAt(i).assoc()['payment_method']!);


              }
              _data = MyData(srNo, propertyNo,clientNo, rentStart,rentFinish,duration,
                    monthlyRent, deposit, paymentMethod,snapshot.data!.numOfRows);
              return Container(
                child: PaginatedDataTable(

                  rowsPerPage: 10,
                  columns: [
                    DataColumn(label: Text('Sr No.'),),
                    DataColumn(label: Text('Property No.'),),
                    DataColumn(label: Text('Client No.'),),
                    DataColumn(label: Text(' Rent Start.'),),
                    DataColumn(label: Text('Rent Finish'),),
                    DataColumn(label: Text('duration.'),),
                    DataColumn(label: Text('Monthly Rent'),),
                    DataColumn(label: Text('Deposit Paid'),),
                    DataColumn(label: Text('Payment Method'),),

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
  MyData(this.srNo, this.propertyNo,this.clientNo, this.rentStart
      ,this.rentFinish, this.duration, this.monthlyRent, this.deposit,this.payment,
      this.dataLength);
  List<String>? srNo;
  List<String>? propertyNo;
  List<String>? rentStart;
  List<String>? rentFinish;
  List<String>? duration;
  List<String>? monthlyRent;
  List<String>? deposit;
  List<String>? payment;
  List<String>? clientNo;


  int dataLength;


  @override
  DataRow? getRow(int index) {
    return DataRow(
      cells: [
        DataCell(
          Text(srNo![index]),
        ),
        DataCell(
          Text(propertyNo![index]),
        ),
        DataCell(
          Text(clientNo![index]),
        ),

        DataCell(
          Text(rentStart![index]),
        ),
        DataCell(
          Text(rentFinish![index]),
        ),
        DataCell(
          Text(duration![index]),
        ),
        DataCell(
          Text(monthlyRent![index]),
        ),
        DataCell(
          Text(deposit![index]),
        ),
        DataCell(
          Text(payment![index]),
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
