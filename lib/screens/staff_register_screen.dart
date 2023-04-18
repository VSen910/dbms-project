import 'package:dbms_project/components/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mysql_client/mysql_client.dart';

class StaffRegisterScreen extends StatefulWidget {
  const StaffRegisterScreen({Key? key, required this.conn}) : super(key: key);

  final MySQLConnection conn;

  @override
  State<StaffRegisterScreen> createState() => _StaffRegisterScreenState();
}

class _StaffRegisterScreenState extends State<StaffRegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  String? staffNo;
  String? fullName;
  String? sex;
  String? dob;
  String? position;
  String? salary;
  String? branch;
  String? supervisor;
  String? managerStartDate;
  String? managerBonus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register staff'),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomTextFormField(
                      header: 'Staff no.',
                      onSaved: (val) {
                        setState(() {
                          staffNo = val;
                        });
                      },
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Please enter the staff no.';
                        }
                      },
                    ),
                    CustomTextFormField(
                      header: 'Full name',
                      onSaved: (val) {
                        setState(() {
                          fullName = val;
                        });
                      },
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Please enter the name';
                        }
                      },
                    ),
                    CustomTextFormField(
                      header: 'Sex (M/F)',
                      onSaved: (val) {
                        setState(() {
                          sex = val;
                        });
                      },
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Please enter the sex';
                        } else if (val != 'M' || val != 'F') {
                          return 'Please input valid data';
                        }
                      },
                    ),
                    CustomTextFormField(
                      header: 'Date of Birth (YYYY-MM-DD)',
                      onSaved: (val) {
                        setState(() {
                          dob = val;
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
                      header: 'Position',
                      onSaved: (val) {
                        setState(() {
                          position = val;
                        });
                      },
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Please enter the position';
                        }
                      },
                    ),
                    CustomTextFormField(
                      header: 'Salary',
                      onSaved: (val) {
                        setState(() {
                          salary = val;
                        });
                      },
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Please enter the salary';
                        }
                      },
                    ),
                    CustomTextFormField(
                      header: 'Branch',
                      onSaved: (val) {
                        setState(() {
                          branch = val;
                        });
                      },
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Please enter the branch';
                        }
                      },
                    ),
                    CustomTextFormField(
                      header: 'Supervisor (if applicable)',
                      onSaved: (val) {
                        setState(() {
                          supervisor = val;
                        });
                      },
                      validator: (val) {
                        return null;
                      },
                    ),
                    CustomTextFormField(
                      header: 'Manager start date (if applicable)',
                      onSaved: (val) {
                        setState(() {
                          managerStartDate = val;
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
                    CustomTextFormField(
                      header: 'Manager bonus (if applicable)',
                      textInputAction: TextInputAction.done,
                      onSaved: (val) {
                        setState(() {
                          managerBonus = val;
                        });
                      },
                      validator: (val) {
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if(_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        print(fullName);
                      }
                    },
                    child: Text('Submit'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
