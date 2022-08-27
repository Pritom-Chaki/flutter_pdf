import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer_null_safe/flutter_full_pdf_viewer.dart';

import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:path_provider/path_provider.dart';

import '../html_widget_pages/constant_data.dart';

class HtmlToPdf extends StatefulWidget {
  const HtmlToPdf({Key? key}) : super(key: key);

  @override
  State<HtmlToPdf> createState() => _HtmlToPdfState();
}

class _HtmlToPdfState extends State<HtmlToPdf> {
  String? generatedPdfFilePath;

  @override
  void initState() {
    super.initState();
    generateExampleDocument();
  }

  Future<void> generateExampleDocument() async {
    const htmlContent = """
    <!DOCTYPE html>
    <html>
      <head>
        <style>
        table, th, td {
          border: 1px solid black;
          border-collapse: collapse;
        }
        th, td, p {
          padding: 5px;
          text-align: left;
        }
        </style>
      </head>
      <body>
        <h2>PDF Generated with flutter_html_to_pdf plugin</h2>
        
        <table style="width:100%">
          <caption>Sample HTML Table</caption>
          <tr>
            <th>Month</th>
            <th>Savings</th>
          </tr>
          <tr>
            <td>January</td>
            <td>100</td>
          </tr>
          <tr>
            <td>February</td>
            <td>50</td>
          </tr>
        </table>
        
        <p>Image loaded from web</p>
        <img src="https://i.imgur.com/wxaJsXF.png" alt="web-img">
      </body>
    </html>
    """;

    Directory appDocDir = await getApplicationDocumentsDirectory();
    const targetPath = './assets/pdf';//appDocDir.path;
    print("targetPath $targetPath");
    const targetFileName = "example_pdf";
    //
    final generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
        ConstantData.htmlContent, targetPath, targetFileName);
    // final generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlFilePath(
    //     'assets/pdf/example_pdf.html', targetPath, targetFileName);
    print("generatedPdfFile $generatedPdfFile");
    generatedPdfFilePath = "./assets/pdf/";//generatedPdfFile.path;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
          child: const Text("Open Generated PDF Preview"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PDFViewerScaffold(
                      appBar:
                          AppBar(title: const Text("Generated PDF Document")),
                      path: "assets/pdf")),
            );
          },
        ),
      ),
    ));
  }
}
