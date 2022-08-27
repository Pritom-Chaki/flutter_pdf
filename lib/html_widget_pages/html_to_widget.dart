import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_pdf/html_widget_pages/constant_data.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:typed_data';

class HtmlToWidget extends StatefulWidget {
  const HtmlToWidget({Key? key}) : super(key: key);

  @override
  State<HtmlToWidget> createState() => _HtmlToWidgetState();
}

class _HtmlToWidgetState extends State<HtmlToWidget> {
  ScreenshotController screenshotController = ScreenshotController();
  @override
  void initState() {
    super.initState();
  }

  final htmlContent = """
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
          <caption>Sample HTML Table দলিল প্রস্তুত পোর্টালে আপনাকে স্বাগতম</caption>
          <caption>হস্তান্তর দলিল রেজিস্ট্রেশনের ধাপ সমূহ</caption>
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Widget from HTML',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Widget from HTML'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Column(
            children: [
              Screenshot(
                controller: screenshotController,
                child: Center(
                  child: HtmlWidget(ConstantData.htmlContent),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              ElevatedButton(
                child: const Text(
                  'Capture Above Widget',
                ),
                onPressed: () {
                  screenshotController
                      .capture(delay: const Duration(milliseconds: 10))
                      .then((capturedImage) async {
                    showCapturedWidget(context, capturedImage!);
                  }).catchError((onError) {
                    print(onError);
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> showCapturedWidget(
      BuildContext context, Uint8List capturedImage) {
    return showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text("Captured widget screenshot"),
        ),
        body: Center(
            child: capturedImage != null
                ? Image.memory(capturedImage)
                : Container()),
      ),
    );
  }
}
