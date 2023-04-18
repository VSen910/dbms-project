import 'package:dbms_project/mysql/mysqlConnector.dart';
import 'package:dbms_project/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  final conn = await MySQLConnector.getConnection();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(conn: conn),
    ),
  );
}
