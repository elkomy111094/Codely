import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/Common/loading_widget.dart';
import '../../../shared/generic_cubit/generic_cubit.dart';
import '../../../shared/widgets/no_data_widget.dart';
import '../../../shared/widgets/simple_Header.dart';
import '../../../view_models/notification_view_model.dart';
import '../widgets/notification_item.dart';

class NotificationScreen extends StatefulWidget {
  final NotificationViewModel notificationViewModel;
  NotificationScreen({required this.notificationViewModel});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    widget.notificationViewModel.getAllNotification();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GenericCubit, GenericCubitState>(
      bloc: widget.notificationViewModel.notificationCubit,
      listener: (context, state) {},
      builder: (context, state) {
        return SafeArea(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              backgroundColor: Colors.white,
              body: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 100.h),
                      child: SizedBox(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          //TODO:Paginator
                          child: widget.notificationViewModel
                                      .notificationsList ==
                                  null
                              ? Loading()
                              : widget.notificationViewModel.notificationsList!
                                      .isEmpty
                                  ? Center(
                                      child: NoDataWidget(
                                          title: "قائمه إشعاراتك فارغه"))
                                  : ListView.separated(
                                      itemBuilder: (context, index) {
                                        return NotificationItem(
                                            notificationModel: widget
                                                .notificationViewModel
                                                .notificationsList![index],
                                            notificationViewModel:
                                                widget.notificationViewModel,
                                            index: index);
                                      },
                                      separatorBuilder: (context, index) {
                                        return SizedBox(
                                          height: 20.h,
                                        );
                                      },
                                      itemCount: widget.notificationViewModel
                                          .notificationsList!.length),
                        ),
                      ),
                    ),
                    SimpleHeader(
                      headerTitle: "الإشعارات",
                    ),
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
