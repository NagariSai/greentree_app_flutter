import 'package:fit_beat/app/common_widgets/custom_app_bar.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CommunityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Community Guidelines",
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: CustomText(
          overflow: null,
          text:
              "In publishing and grap hic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available. It is also used to temporarily replace text in a process called greeking, which allows designers to consider the form of a webpage or publication, without the meaning of the text influencing the design. Lorem ipsum is typically a corrupted version of ‘De finibus bonorum et malorum’, a 1st century BC text by the Roman statesman and philosopher Cicero, with words altered, added, and removed to make it nonsensical and improper Latin.",
          size: 14,
          color: FF6D7274,
        ),
      ),
    );
  }
}
