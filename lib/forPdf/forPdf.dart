import 'package:flutter/material.dart';
import 'package:resumeai/forPdf/genaratePdf.dart';

class ForPdf extends StatefulWidget {
  const ForPdf({Key? key}) : super(key: key);

  @override
  State<ForPdf> createState() => _ForPdfState();
}

class _ForPdfState extends State<ForPdf> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () async {
                final pdfFile = await PdfApi.generatePdf();

                PdfApi.openFile(pdfFile);
              },
              child: const Text("Create PDF"),
            ),
          ],
        ),
      ),
    );
  }
}
