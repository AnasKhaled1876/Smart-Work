import 'package:flutter/widgets.dart';

double height = 0;

double width = 0;

double textSize = 0;

const List<String> appLabels = [
  "Home",
  "Calendar",
  "Notes",
  "Tasks",
];

const List<String> categoriesLabels = [
  "Personal",
  "Life",
  "Education",
  "Work",
  "Sports",
  "Cooking",
];

const List<String> aboutLabels = [
  "Notifications",
  "Settings",
  "Rate Us",
  "Help",
];

const List<String> bottomBarLabels = [
  "Home",
  "Calendar",
  "Notes",
  "Tasks",
];

Map<int, String> titleMap = {
  1: "Calendar",
  3: "Notes",
  4: "Tasks",
};

List<String> settingsTitles = [
  "Personal Settings",
  "Notifications",
  "Language",
];

class WelcomeRow extends StatelessWidget {
  const WelcomeRow({
    super.key,
    required this.name,
  });
  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome',
          textAlign: TextAlign.start,
          style: TextStyle(
            color: const Color(0xFFCCCCCC),
            fontSize: textSize * 10,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: height * 2),
        Text(
          'Mr. $name',
          textAlign: TextAlign.start,
          style: TextStyle(
            color: const Color(0xFF242041),
            fontSize: textSize * 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
