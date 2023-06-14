import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mysql_client/mysql_client.dart';

import '../components/custom_textformfield.dart';

class ViewReportForm extends StatefulWidget {
  const ViewReportForm({Key? key, required this.conn}) : super(key: key);
  final MySQLConnection conn;
  @override
  State<ViewReportForm> createState() => _ViewReportFormState();
}

class _ViewReportFormState extends State<ViewReportForm> {
  final _formKey = GlobalKey<FormState>();

  String? clientNo;
  String? fullName;
  String? reportDate;
  String? comments;
  String? propertyNo;
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
                          return 'Please enter the client No';
                        }
                      },
                    ),
                    CustomTextFormField(
                      header: 'Full Name',
                      onSaved: (val) {
                        setState(
                          () {
                            fullName = val;
                          },
                        );
                      },
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Please enter full name.';
                        }
                      },
                    ),
                    CustomTextFormField(
                      header: 'Comments',
                      onSaved: (val) {
                        setState(
                          () {
                            if(val.isEmpty){
                              comments=null;
                            }
                            else {
                              comments = val;
                            }
                          },
                        );
                      },
                      validator: (val) {
                        if (val.isEmpty) {
                          return null;
                        }
                      },
                    ),
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
                          return 'Please enter the telephone number';
                        }
                      },
                    ),
                    CustomTextFormField(
                      header: 'Report Date(YYYY-MM-DD)',
                      onSaved: (val) {
                        setState(() {


                            reportDate = val;

                        });
                      },
                      validator: (val) {
                        if(val.isEmpty) {
                          return null;
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
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              if(reportDate==null) {
                                widget.conn.execute(
                                    "Insert into viewing_report values('$clientNo','$fullName','$reportDate', '$comments', '$propertyNo')");
                              }
                              else{
                                widget.conn.execute("Insert into viewing_report values('$clientNo','$fullName','$reportDate', '$comments', '$propertyNo')");

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
