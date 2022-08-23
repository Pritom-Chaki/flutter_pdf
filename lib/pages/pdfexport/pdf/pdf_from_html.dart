import 'dart:typed_data';

import 'package:flutter_pdf/models/invoice.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as tw;

import 'package:flutter/services.dart' show rootBundle;

Future<Uint8List> pdfFromHtml(Invoice invoice) async {
  // final Uint8List fontData = File('assets/fonts/open-sans.ttf', ).readAsBytesSync();
  //final ttf = Font.ttf(fontData.buffer.asByteData());
  final font = await rootBundle.load("assets/fonts/Nikosh.ttf");
  final ttf = tw.Font.ttf(font);

  final pdf = tw.Document(
    theme: tw.ThemeData(defaultTextStyle: tw.TextStyle(font: ttf)),
  );
  final imageLogo = tw.MemoryImage(
      (await rootBundle.load('assets/technical_logo.png'))
          .buffer
          .asUint8List());
  pdf.addPage(
    tw.Page(
      build: (context) {
        return tw.Column(
          children: [
            tw.Text('হস্তান্তর দলিল রে জি ধাপ সমূহ',
                style: tw.TextStyle(font: ttf)),
            tw.Row(
              mainAxisAlignment: tw.MainAxisAlignment.spaceBetween,
              children: [
                tw.Column(
                  children: [
                    tw.Text("Attention to: ${invoice.customer}"),
                    tw.Text(invoice.address),
                  ],
                  crossAxisAlignment: tw.CrossAxisAlignment.start,
                ),
                tw.SizedBox(
                  height: 150,
                  width: 150,
                  child: tw.Image(imageLogo),
                )
              ],
            ),
            tw.Container(height: 50),
            tw.Table(
              border: tw.TableBorder.all(color: PdfColors.black),
              children: [
                tw.TableRow(
                  children: [
                    tw.Padding(
                      child: tw.Text(
                        'INVOICE FOR PAYMENT',
                        style: tw.Theme.of(context).header4,
                        textAlign: tw.TextAlign.center,
                      ),
                      padding: const tw.EdgeInsets.all(20),
                    ),
                  ],
                ),
                ...invoice.items.map(
                  (e) => tw.TableRow(
                    children: [
                      tw.Expanded(
                        child: paddedText(e.description),
                        flex: 2,
                      ),
                      tw.Expanded(
                        child: paddedText("\$${e.cost}"),
                        flex: 1,
                      )
                    ],
                  ),
                ),
                tw.TableRow(
                  children: [
                    paddedText('TAX', align: tw.TextAlign.right),
                    paddedText(
                        '\$${(invoice.totalCost() * 0.1).toStringAsFixed(2)}'),
                  ],
                ),
                tw.TableRow(
                  children: [
                    paddedText('TOTAL', align: tw.TextAlign.right),
                    paddedText(
                        '\$${(invoice.totalCost() * 1.1).toStringAsFixed(2)}')
                  ],
                )
              ],
            ),
            tw.Padding(
              child: tw.Text(
                "THANK YOU FOR YOUR CUSTOM!",
                style: tw.Theme.of(context).header2,
              ),
              padding: const tw.EdgeInsets.all(20),
            ),
            tw.Text(
                "Please forward the below slip to your accounts payable department."),
            tw.Divider(
              height: 1,
              borderStyle: tw.BorderStyle.dashed,
            ),
            tw.Container(height: 50),
            tw.Table(
              border: tw.TableBorder.all(color: PdfColors.black),
              children: [
                tw.TableRow(
                  children: [
                    paddedText('Account Number'),
                    paddedText(
                      '1234 1234',
                    )
                  ],
                ),
                tw.TableRow(
                  children: [
                    paddedText(
                      'Account Name',
                    ),
                    paddedText(
                      'ADAM FAMILY TRUST',
                    )
                  ],
                ),
                tw.TableRow(
                  children: [
                    paddedText(
                      'Total Amount to be Paid',
                    ),
                    paddedText(
                        '\$${(invoice.totalCost() * 1.1).toStringAsFixed(2)}')
                  ],
                )
              ],
            ),
            tw.Padding(
              padding: const tw.EdgeInsets.all(30),
              child: tw.Text(
                'Please ensure all cheques are payable to the ADAM FAMILY TRUST.',
                style: tw.Theme.of(context).header3.copyWith(
                      fontStyle: tw.FontStyle.italic,
                    ),
                textAlign: tw.TextAlign.center,
              ),
            )
          ],
        );
      },
    ),
  );

  return pdf.save();
}

tw.Widget paddedText(
  final String text, {
  final tw.TextAlign align = tw.TextAlign.left,
}) =>
    tw.Padding(
      padding: const tw.EdgeInsets.all(10),
      child: tw.Text(
        text,
        textAlign: align,
      ),
    );
