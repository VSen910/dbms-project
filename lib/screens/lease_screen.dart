import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:mysql_client/exception.dart';
import 'package:mysql_client/mysql_client.dart';

import '../components/custom_textformfield.dart';
class LeaseScreen extends StatefulWidget {
  LeaseScreen({Key? key, required this.conn}) : super(key: key);
  List<String> list = ['Cash', 'Cheque','Bank Transfer'];
  final MySQLConnection conn;

  @override
  State<LeaseScreen> createState() => _LeaseScreenState();
}

class _LeaseScreenState extends State<LeaseScreen> {
  final _formKey = GlobalKey<FormState>();

  String? propertyNo;
  String? clientNo;
  String? rentStart;
  String? rentEnd;
  String? finishDate;
  String? duration;
  String? monthlyRent;
  String? depositPaid;
  String? paymentMethod;
  String? dropdownValue;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dropdownValue = widget.list.first;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DreamHome'),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      header: 'Property Number',
                      onSaved: (val) {
                        setState(
                              () {
                            propertyNo = val;
                          },
                        );
                      },
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Please fill the property Number';
                        }
                      },
                    ),
                    CustomTextFormField(
                      header: 'Client Number',
                      onSaved: (val) {
                        setState(
                              () {
                            clientNo = val;
                          },
                        );
                      },
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Please enter client number';
                        }
                      },
                    ),
                    CustomTextFormField(
                      header: 'Rent start (YYYY-MM-DD)',
                      onSaved: (val) {
                        setState(() {
                          rentStart = val;
                        });
                      },
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Please enter the DOB';
                        }
                        DateTime? date;
                        final format = DateFormat('yyyy-MM-dd');
                        try {
                          date = format.parseStrict(val);
                        } catch (e) {
                          date = null;
                        }
                        if (date == null) {
                          return 'Please enter the valid format';
                        }
                      },
                    ),

                    CustomTextFormField(
                      header: 'Rent end (YYYY-MM-DD)',
                      onSaved: (val) {
                        setState(() {
                          rentEnd = val;
                        });
                      },
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Please enter the DOB';
                        }
                        DateTime? date;
                        final format = DateFormat('yyyy-MM-dd');
                        try {
                          date = format.parseStrict(val);
                        } catch (e) {
                          date = null;
                        }
                        if (date == null) {
                          return 'Please enter the valid format';
                        }
                      },
                    ),
                    CustomTextFormField(
                      header: 'Duration',
                      onSaved: (val) {
                        setState(
                              () {
                            duration = val;
                          },
                        );
                      },
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Please enter the duration of lease';
                        }
                      },
                    ),
                    CustomTextFormField(
                      header: 'Monthly Rent',
                      onSaved: (val) {
                        setState(
                              () {
                            monthlyRent = val;
                          },
                        );
                      },
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Please enter required montly rent';
                        }
                      },
                    ),
                    CustomTextFormField(
                      header: 'Deposit Paid',
                      onSaved: (val) {
                        setState(
                              () {
                            depositPaid = val;
                          },
                        );
                      },
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Please deposit amount';
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Payment Method:'),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: DropdownButton(
                            value: dropdownValue,
                            items: widget.list.map(
                                  (e) {
                                return DropdownMenuItem<String>(
                                  child: Text(e.toString()),
                                  value: e.toString(),
                                );
                              },
                            ).toList(),
                            onChanged: (String? value) {
                              setState(
                                    () {
                                  dropdownValue = value;
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async{
                            if(_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              try {
                                await widget.conn.execute(
                                    "Insert into lease (property_no, client_no, rent_start, rent_finish, duration, monthly_rent, deposit_paid, payment_method)"
                                        "values('$propertyNo','$clientNo','$rentStart','$rentEnd', '$duration', '$monthlyRent', '$depositPaid','$dropdownValue')");
                              }
                              on MySQLServerException catch (e) {
                                Fluttertoast.showToast(msg: 'Error');
                              }
                            }
                          },
                          child: Text('Submit'),
                        ),
                      ),
                    ),
                  ],

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
