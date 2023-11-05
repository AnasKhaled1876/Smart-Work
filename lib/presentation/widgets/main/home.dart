import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_work/cubits/cubit/app_cubit.dart';
import 'package:smart_work/presentation/assets/color_manager.dart';
import 'package:smart_work/presentation/widgets/task/task_details.dart';
import 'package:smart_work/presentation/widgets/task/task_tile.dart';
import 'package:smart_work/presentation/widgets/home/main_banner.dart';
import 'package:smart_work/utils/constants/labels.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Column(
          children: [
            const MainBanner(),
            SizedBox(height: height * 24),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    'Today’s Tasks',
                    style: TextStyle(
                      color: const Color(0xFF242041),
                      fontSize: textSize * 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  'see all',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: const Color(0xFFC1B2FF),
                    fontSize: textSize * 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * 14,
            ),
            cubit.userProfile!.tasks != null &&
                    cubit.userProfile!.tasks!.isNotEmpty
                ? ListView.builder(
                    itemCount: cubit.userProfile?.tasks?.length ?? 0,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        cubit.selectedTask = cubit.userProfile!.tasks![index];
                        Navigator.pushNamed(
                          context,
                          TaskDetailsScreen.routeName,
                        );
                      },
                      child: TaskTile(
                        task: cubit.userProfile!.tasks![index],
                      ),
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: height * 50),
                      SvgPicture.asset(
                        "assets/icons/app/check-r.svg",
                        colorFilter: ColorFilter.mode(
                          primaryColor.withOpacity(0.6),
                          BlendMode.srcIn,
                        ),
                        width: width * 70,
                        height: height * 70,
                      ),
                      SizedBox(height: height * 20),
                      Text(
                        "You have no tasks for today",
                        style: TextStyle(
                          color: primaryColor.withOpacity(0.6),
                          fontSize: textSize * 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  )
          ],
        );
      },
    );
  }
}
