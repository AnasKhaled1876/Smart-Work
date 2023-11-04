import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_work/config/main_theme.dart';
import 'package:smart_work/presentation/assets/color_manager.dart';
import '../../cubits/cubit/app_cubit.dart';
import '../../domain/models/user_profile.dart';
import '../../utils/constants/labels.dart';
import 'home.dart';

class AddInfoScreen extends StatefulWidget {
  const AddInfoScreen({super.key});
  static const routeName = '/add_info';

  @override
  State<AddInfoScreen> createState() => _AddInfoScreenState();
}

class _AddInfoScreenState extends State<AddInfoScreen> {
  bool value = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool obscureText = true;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is RegisterUserSuccessState) {
          Navigator.popAndPushNamed(context, HomeScreen.routeName);
        }
        if (state is RegisterUserErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        }
      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
              child: Stack(
            children: [
              Positioned(
                left: width * -99,
                top: height * -92,
                child: Container(
                  width: width * 273,
                  height: height * 277,
                  decoration: const ShapeDecoration(
                    color: Color(0xFFF7F5FF),
                    shape: OvalBorder(),
                  ),
                ),
              ),
              Positioned(
                left: width * 73,
                top: height * -199,
                child: Container(
                  width: width * 325,
                  height: height * 330,
                  decoration: const ShapeDecoration(
                    color: Color(0x49C1B2FF),
                    shape: OvalBorder(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: width * 40,
                  right: width * 40,
                  top: height * 20,
                ),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          'Set Your Personal \nInformation',
                          style: TextStyle(
                            color: const Color(0xFF242041),
                            fontSize: textSize * 32,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: height * 107,
                        ),
                        TextFormField(
                          onTapOutside: (event) {
                            FocusScope.of(context).unfocus();
                          },
                          validator: (value) {
                            if (value!.isEmpty ||
                                value.contains(RegExp(r'[0-9]'))) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          controller: nameController,
                          decoration: InputDecoration(
                            hintText: 'Write Your Name',
                            hintStyle: TextStyle(
                              color: const Color(0xFFAEACB9),
                              fontSize: textSize * 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 24,
                        ),
                        TextFormField(
                          onTapOutside: (event) {
                            FocusScope.of(context).unfocus();
                          },
                          validator: (value) {
                            if (value!.isEmpty ||
                                !value.contains('@') ||
                                !value.contains('.')) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          controller: emailController,
                          decoration: InputDecoration(
                            hintText: 'Write Your Email',
                            hintStyle: TextStyle(
                              color: const Color(0xFFAEACB9),
                              fontSize: textSize * 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 24,
                        ),
                        TextFormField(
                          onTapOutside: (event) {
                            FocusScope.of(context).unfocus();
                          },
                          validator: (value) {
                            if (value!.isEmpty || value.length < 6) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          obscureText: obscureText,
                          controller: passwordController,
                          decoration: InputDecoration(
                            suffix: TextButton(
                              onPressed: () {
                                setState(() {
                                  obscureText = !obscureText;
                                });
                              },
                              child: Text(
                                'Show',
                                style: TextStyle(
                                  decoration: obscureText
                                      ? null
                                      : TextDecoration.lineThrough,
                                  color: primaryColor,
                                  fontSize: textSize * 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            hintText: 'Invent a Password',
                            hintStyle: TextStyle(
                              color: const Color(0xFFAEACB9),
                              fontSize: textSize * 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 70,
                        ),
                        CheckboxListTile(
                          activeColor: primaryColor,
                          controlAffinity: ListTileControlAffinity.trailing,
                          checkboxShape: const CircleBorder(),
                          title: Text(
                            'Male',
                            style: TextStyle(
                              color: const Color(0xFF242041),
                              fontSize: textSize * 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          value: value,
                          onChanged: (check) {
                            setState(() {
                              value = check!;
                            });
                          },
                        ),
                        CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.trailing,
                          checkboxShape: const CircleBorder(),
                          title: Text(
                            'Female',
                            style: TextStyle(
                              color: const Color(0xFF242041),
                              fontSize: textSize * 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          activeColor: primaryColor,
                          value: !value,
                          onChanged: (check) {
                            setState(() {
                              value = !check!;
                            });
                          },
                        ),
                        SizedBox(
                          height: height * 70,
                        ),
                        ElevatedButton(
                          style: mainButtonTheme.style,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              cubit.registerUser(
                                  user: UserProfile(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                age: 22,
                                gender: "Male",
                              ));
                            }
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
                                        'Get Started',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: textSize * 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const Spacer(),
                                      SvgPicture.asset(
                                        "assets/icons/arrow_right.svg",
                                        width: width * 24,
                                        height: height * 24,
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                        SizedBox(
                          height: height * 24,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
        );
      },
    );
  }
}
