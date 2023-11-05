import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badge;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_work/cubits/cubit/app_cubit.dart';
import 'package:smart_work/presentation/assets/color_manager.dart';
import 'package:smart_work/utils/constants/images.dart';
import '../../../utils/constants/labels.dart';

class PickTaskCategorySheet extends StatefulWidget {
  const PickTaskCategorySheet({
    super.key,
  });

  @override
  State<PickTaskCategorySheet> createState() => _PickTaskCategorySheetState();
}

class _PickTaskCategorySheetState extends State<PickTaskCategorySheet> {
  TextEditingController titleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return badge.Badge(
          badgeContent: InkWell(
            onTap: () => Navigator.pop(context, false),
            child: Icon(
              Icons.close,
              color: Colors.white,
              size: width * 20,
            ),
          ),
          position:
              badge.BadgePosition.topEnd(top: height * -14, end: width * 16),
          badgeStyle: badge.BadgeStyle(
            elevation: 0,
            padding: EdgeInsets.all(width * 4),
            borderSide: BorderSide(
              color: Colors.white,
              width: width * 3,
            ),
            shape: badge.BadgeShape.circle,
            badgeColor: primaryColor,
            borderRadius: BorderRadius.circular(width * 10),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(width * 16),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: width * 32,
              vertical: height * 40,
            ),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: Text(
                        'Choose The Category',
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: textSize * 16,
                          fontFamily: 'SFPro Display',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 40,
                    ),
                    SizedBox(
                      height: height * 350,
                      width: MediaQuery.sizeOf(context).width,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: categoriesIcons.length,
                        itemBuilder: (BuildContext context, int index) =>
                            CategoryTile(index: index),
                      ),
                    ),
                    SizedBox(
                      height: height * 32,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(width * 10),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: width * 32,
                                vertical: height * 16,
                              ),
                            ),
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text(
                              "Done",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: textSize * 16,
                                fontFamily: 'SFPro',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class CategoryTile extends StatelessWidget {
  const CategoryTile({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Container(
          margin: EdgeInsets.only(bottom: height * 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                categoriesIcons[index],
                height: width * 18,
                width: width * 18,
              ),
              SizedBox(
                width: width * 16,
              ),
              Text(
                categoriesLabels[index],
                style: TextStyle(
                  color: primaryColor,
                  fontSize: textSize * 17,
                  fontFamily: 'SFPro',
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Checkbox(
                shape: const CircleBorder(),
                activeColor: primaryColor,
                value: cubit.selectedTaskCategory == index,
                onChanged: (check) {
                  cubit.pickTaskCategory(index);
                },
              )
            ],
          ),
        );
      },
    );
  }
}
