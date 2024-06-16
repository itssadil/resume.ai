import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:resumeai/consts.dart';

class GetPdf extends StatefulWidget {
  GetPdf({Key? key, required this.myPrompt}) : super(key: key);
  final String myPrompt;

  @override
  State<GetPdf> createState() => _GetPdfState();
}

class _GetPdfState extends State<GetPdf> {
  final TextEditingController _userMessage = TextEditingController();

  final model =
      GenerativeModel(model: "gemini-1.5-flash-latest", apiKey: GEMINI_API_KEY);

  // Note: For your API key, please create a file named consts.dart inside the lib folder and add the following line:
  // const String GEMINI_API_KEY = "YOUR_API_KEY";

  String getResponse = "";

  @override
  void initState() {
    sendMessage();
    super.initState();
  }

  sendMessage() async {
    final message = widget.myPrompt;
    // final message = _userMessage.text;
    _userMessage.clear();

    final prompt = message;
    final content = [Content.text(prompt)];
    final response = await model.generateContent(content);

    print(response.text);
    setState(() {
      getResponse = response.text!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(getResponse),
      ),
    );
  }
}
