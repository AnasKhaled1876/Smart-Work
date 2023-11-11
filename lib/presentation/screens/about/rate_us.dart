import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:localization/localization.dart';
import 'package:smart_work/cubits/cubit/app_cubit.dart';
import '../../../config/themes/main_theme.dart';
import '../../../utils/constants/labels.dart';
import '../../assets/color_manager.dart';

class RateUsScreen extends StatefulWidget {
  const RateUsScreen({super.key});
  static const routeName = '/rate_us';

  @override
  State<RateUsScreen> createState() => _RateUsScreenState();
}

class _RateUsScreenState extends State<RateUsScreen> {
  TextEditingController feedbackController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        // AppCubit cubit = AppCubit.get(context);
        return Form(
          key: _formKey,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 32,
                    vertical: width * 47,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Rate Us'.i18n(),
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: textSize * 20,
                                fontFamily: 'SFPro',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              padding: EdgeInsets.all(width * 10),
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(width * 4),
                                ),
                                shadows: const [
                                  BoxShadow(
                                    color: Color(0x26000000),
                                    blurRadius: 20,
                                    offset: Offset(0, 0),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              child: Icon(
                                Icons.close,
                                color: primaryColor,
                                size: width * 24,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: height * 70,
                      ),
                      Text(
                        'Rate The Application'.i18n(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: textSize * 24,
                          fontFamily: 'SF Pro Display',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: height * 6,
                      ),
                      Text(
                        'From 0 To 5'.i18n(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: textSize * 15,
                          fontFamily: 'SFPro',
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      SizedBox(
                        height: height * 70,
                      ),
                      Container(
                        height: height * 290,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFFEBEBEB),
                            width: width * 1.2,
                          ),
                          borderRadius: BorderRadius.circular(width * 8),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 16,
                        ),
                        child: TextField(
                          onTapOutside: (event) =>
                              FocusScope.of(context).unfocus(),
                          controller: feedbackController,
                          keyboardType: TextInputType.multiline,
                          maxLines: 7,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(200),
                          ],
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Your Feedback'.i18n(),
                            alignLabelWithHint: true,
                            labelStyle: TextStyle(
                              color: const Color(0xFFAEACB9),
                              fontSize: textSize * 14,
                              fontFamily: 'SFPro',
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 70,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 26,
                          vertical: height * 16,
                        ),
                        child: ElevatedButton(
                          style: mainButtonTheme.style,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {}
                          },
                          child: AnimatedSize(
                            duration: const Duration(milliseconds: 400),
                            child: state is RegisterUserLoadingState
                                ? const CircularProgressIndicator()
                                : Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Send'.i18n(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: textSize * 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const Spacer(),
                                      Transform.flip(
                                        flipX: locale.languageCode == 'ar',
                                        child: SvgPicture.asset(
                                          "assets/icons/arrow_right.svg",
                                          width: width * 24,
                                          height: height * 24,
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
