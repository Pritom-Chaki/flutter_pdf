import 'package:flutter/material.dart';
import 'package:flutter_pdf/pages/invoices.dart';
import 'package:flutter_pdf/pages/pdfexport/pdfpreview.dart';
import 'package:flutter_pdf/pdfx/pdfx.dart';
import 'package:flutter_pdf/s_pdf/s_pdf.dart';

import 'html_pdf_pages/html_to_pdf.dart';
import 'html_widget_pages/html_to_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const GeneratePdfWidget(),
    );
  }
}
