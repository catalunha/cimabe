import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class UserProfilePrintPage extends StatelessWidget {
  // final _userProfileSearchController = Get.find<UserProfileSearchController>();

  const UserProfilePrintPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Preview'),
      ),
      body: PdfPreview(
        pdfFileName: 'Usuarios',
        build: (format) => makePdf(format, 'Relatorios'),
      ),
    );
  }

  Future<Uint8List> makePdf(PdfPageFormat format, String title) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text("Hello World"),
          ); // Center
        },
      ),
    ); // Page
    return await pdf.save();
  }
}
