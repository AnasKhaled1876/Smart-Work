import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:localization/localization.dart';
import '../../../injection.dart';
import '../../../main.dart';
import '../../../utils/constants/labels.dart';
import '../../assets/color_manager.dart';

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(width * 10),
              topRight: Radius.circular(width * 10),
            ),
          ),
          padding: EdgeInsets.symmetric(
              horizontal: width * 20, vertical: height * 20),
          child: Row(
            children: [
              SvgPicture.asset(
                "assets/icons/globe.svg",
                colorFilter: const ColorFilter.mode(
                  secondaryColor,
                  BlendMode.srcATop,
                ),
              ),
              SizedBox(
                width: width * 20,
              ),
              Text(
                'Language'.i18n(),
                style: TextStyle(
                  color: secondaryColor,
                  fontSize: textSize * 20,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.41,
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.close,
                  color: secondaryColor,
                ),
              )
            ],
          ),
        ),
        Divider(
          color: secondaryColor.withOpacity(0.5),
          thickness: 1,
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: translationLanguages.length,
          itemBuilder: (context, index) => InkWell(
            onTap: () async {
              // ignore: no_leading_underscores_for_local_identifiers
              Locale _locale;

              _locale = translationLanguages[index] == "English"
                  ? const Locale("en", "US")
                  : const Locale("ar", "SA");

              await locator<FlutterSecureStorage>()
                  .write(key: "language", value: _locale.languageCode);
              await locator<FlutterSecureStorage>()
                  .write(key: "country", value: _locale.countryCode!);

              MyApp.setLocale(context, _locale);
              
              // AppCubit.get(context).setTheme();
              // ignore: use_build_context_synchronously
              Navigator.pushNamedAndRemoveUntil(
                  context, "/splash", ModalRoute.withName("/splash"));
            },
            child: LocaleTile(
              label: translationLanguages[index],
              picked: locale.languageCode == "en"
                  ? translationLanguages[index] == "English"
                      ? true
                      : false
                  : translationLanguages[index] == "العربية"
                      ? true
                      : false,
              subText: index == 0 ? "United States" : "الشرق الأوسط",
              bottomSheet: true,
            ),
          ),
        )
      ],
    );
  }
}

class LocaleTile extends StatelessWidget {
  const LocaleTile({
    super.key,
    required this.label,
    required this.picked,
    required this.subText,
    required this.bottomSheet,
  });
  final String label;
  final String? subText;
  final bool picked;
  final bool bottomSheet;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.transparent,
      ),
      margin: EdgeInsets.all(bottomSheet ? width * 10 : width * 25),
      padding: bottomSheet
          ? EdgeInsets.only(
              top: height * 10,
              bottom: height * 10,
              left: width * 16,
              right: width * 16)
          : EdgeInsets.symmetric(
              horizontal: width * 16,
              vertical: height * 30,
            ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: width * 220,
                child: Text(
                  label,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: textSize * 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.41,
                  ),
                ),
              ),
              SizedBox(
                height: height * 5,
              ),
              subText != null
                  ? Text(
                      subText!,
                      style: TextStyle(
                        color: secondaryColor,
                        fontSize: textSize * 13,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  : const SizedBox()
            ],
          ),
          const Spacer(),
          if (bottomSheet)
            AnimatedCrossFade(
              duration: const Duration(milliseconds: 300),
              firstChild: Icon(
                Icons.radio_button_checked,
                color: primaryColor,
                size: width * 20,
              ),
              secondChild: Icon(
                Icons.radio_button_off,
                color: Colors.grey,
                size: width * 20,
              ),
              crossFadeState:
                  picked ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            ),
          // picked
          //     ? Radio(
          //         value: true,
          //         groupValue: picked,
          //         onChanged: (on) {},
          //         activeColor: primaryColor,
          //       )
          //     : Radio(
          //         value: false,
          //         groupValue: true,
          //         onChanged: (on) {},
          //         activeColor: primaryColor,
          //       ),
          if (!bottomSheet)
            picked
                ? Radio(
                    value: "English",
                    groupValue: picked ? "English" : "Arabic",
                    onChanged: (value) {})
                : const SizedBox()
        ],
      ),
    );
  }
}
