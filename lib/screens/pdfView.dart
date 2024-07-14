import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:provider/provider.dart';
import 'package:resumeai/consts.dart';
import 'package:resumeai/providers/addProjectProvider.dart';
import 'package:resumeai/widgets/pdfView/pdfBody.dart';
import 'package:resumeai/widgets/pdfView/pdfLoading.dart';

class PdfView extends StatefulWidget {
  const PdfView({
    Key? key,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    required this.skills,
    required this.myPrompt,
    required this.language,
  }) : super(key: key);
  final String name;
  final String phone;
  final String email;
  final String address;
  final String skills;
  final String language;
  final String myPrompt;

  @override
  State<PdfView> createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> {
  final model =
      GenerativeModel(model: "gemini-1.5-flash-latest", apiKey: GEMINI_API_KEY);

  // Note: For your API key, please create a file named consts.dart inside the lib folder and add the following line:
  // const String GEMINI_API_KEY = "YOUR_API_KEY";

  String getResponse = "";
  String getSubtitle = "";
  String getSkills = "";
  List<String> generatedList = [];

  @override
  void initState() {
    sendMessage();
    super.initState();
  }

  sendMessage() async {
    // For Description Prompt
    final description =
        "please make a description for me, here is my details: '${widget.myPrompt}'  Please note:[1. do not suggest me anything (like; title, subtitle etc), just write description in a paragraph. 2. Aim for  description between 50-70 words or 5-7 Bullet Points. 3. no need to use my name 4. no need to bold, italic, underline etc.]";

    // For  Subtitle Prompt(e.g. Flutter Developer)
    final subtitle =
        "'${widget.myPrompt}' According to those qualification, please write a title which is suitable for me. note: [1. don't suggest me, just provide one title. 2. title should be no more then 3 words.]";

    // For Skills Prompt
    final mySkills =
        "${widget.skills} please Brief my skills up to 5 words. note:[1. separate all skills with double new line. 2. write title, then write a colon followed by a brief description of the skills. 3.  don't suggest me anything else 4.  don't write any other words. 5. do not suggest me anything (like; title, subtitle etc)]";

    // Get Project List
    final projectProvider =
        Provider.of<AddProjectProvider>(context, listen: false);

    //Generate Description

    final prompt = description;
    final content = [Content.text(prompt)];
    final response = await model.generateContent(content);

    //Generate Subtitle (e.g. Flutter Developer)

    final subPrompt = subtitle;
    final subContent = [Content.text(subPrompt)];
    final subResponse = await model.generateContent(subContent);

    //Generate Skills

    final skillPrompt = mySkills;
    final skillContent = [Content.text(skillPrompt)];
    final skillResponse = await model.generateContent(skillContent);

    // Generate Project
    for (int i = 0; i < projectProvider.projectTitleController.length; i++) {
      // For Project Description Prompt

      final projectPrompt =
          "please generate a short description for my project, project info: name: ${projectProvider.projectTitleController[i].text}, basic info: ${projectProvider.descriptionController[i].text}  Please note:[1. do not suggest me anything (like; title, subtitle etc), just write description in a paragraph. 2. Aim for  description between 25-45 words or 3-4 Bullet Points. 3. no need to bold, italic, underline etc.]";
      final projectContent = [Content.text(projectPrompt)];
      final projectResponse = await model.generateContent(projectContent);
      generatedList.add("${projectResponse.text}");
    }

    setState(() {
      getResponse = response.text!;
      getSubtitle = subResponse.text!;
      getSkills = skillResponse.text!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextButton.icon(
          onPressed: () {},
          label: const Text("Download"),
          icon: const Icon(Icons.download),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (kIsWeb) {
              return AspectRatio(
                aspectRatio: 3 / 3,
                child: getResponse != "" && getSubtitle != ""
                    ? pdfBody(
                        name: widget.name,
                        subtitle: getSubtitle,
                        email: widget.email,
                        phone: widget.phone,
                        address: widget.address,
                        skill: getSkills,
                        languages: widget.language,
                        desc: getResponse,
                        generatedList: generatedList,
                      )
                    : pdfLoading(),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(10),
              child: pdfBody(
                name: widget.name,
                subtitle: getSubtitle,
                email: widget.email,
                phone: widget.phone,
                address: widget.address,
                skill: getSkills,
                languages: widget.language,
                desc: getResponse,
                generatedList: generatedList,
              ),
            );
          },
        ),
      ),
    );
  }
}
