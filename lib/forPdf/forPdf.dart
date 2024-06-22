import 'package:flutter/material.dart';

import 'genaratePdf.dart';

class ForPdf extends StatelessWidget {
  const ForPdf({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final pdfFile = await PdfApi.generatePdf();

            PdfApi.openFile(pdfFile);
          },
          child: const Text("Create PDF"),
        ),
      ),
    );
  }
}
