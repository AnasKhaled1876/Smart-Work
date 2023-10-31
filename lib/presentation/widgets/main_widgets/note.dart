import 'package:smart_work/cubits/cubit/app_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_work/presentation/widgets/note/note_tile.dart';
import '../../../utils/constants/labels.dart';
import '../../assets/color_manager.dart';
import 'package:flutter/material.dart';
import '../note/tab_bar.dart';

class NoteWidget extends StatefulWidget {
  const NoteWidget({super.key});

  @override
  State<NoteWidget> createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget>
    with SingleTickerProviderStateMixin {
  int index = 0;
  @override
  void initState() {
    super.initState();
    AppCubit.get(context).tabController = TabController(length: 3, vsync: this);
    AppCubit.get(context).tabController!.addListener(() {
      setState(() {
        index = AppCubit.get(context).tabController!.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Column(
          children: [
            NoteTabBar(tabController: cubit.tabController!, index: index),
            SizedBox(
              height: height * 16,
            ),
            TextField(
              decoration: InputDecoration(
                fillColor: tertiaryColor,
                filled: true,
                contentPadding: EdgeInsets.symmetric(
                    horizontal: width * 10, vertical: height * 14),
                hintText: 'Search',
                hintStyle: TextStyle(
                  color: primaryColor,
                  fontSize: textSize * 14,
                  fontFamily: 'SF Pro',
                  fontWeight: FontWeight.w600,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  size: width * 24,
                  color: primaryColor,
                ),
              ),
            ),
            SizedBox(
              height: height * 16,
            ),
            SizedBox(
              height: height * 450,
              child: TabBarView(
                controller: cubit.tabController,
                children: [
                  ListView.builder(
                    itemCount: cubit.userProfile?.notes?.length ?? 0,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => NoteTile(
                      note: cubit.userProfile!.notes![index],
                    ),
                  ),
                  ListView.builder(
                    itemCount: cubit.userProfile?.notes?.length ?? 0,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => NoteTile(
                      note: cubit.userProfile!.notes![index],
                    ),
                  ),
                  ListView.builder(
                    itemCount: cubit.userProfile?.notes?.length ?? 0,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => NoteTile(
                      note: cubit.userProfile!.notes![index],
                    ),
                  )
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
