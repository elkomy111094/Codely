import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_shoper_master/shared/util/app_routes.dart';
import 'package:smart_shoper_master/shared/util/ui.dart';
import 'package:smart_shoper_master/view_models/notification_view_model.dart';

import 'package:smart_shoper_master/shared/constants/colors.dart';

class NotificationWidget extends StatefulWidget {
  const NotificationWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  bool isActive = false;
  NotificationViewModel notificationViewModel = NotificationViewModel();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        UI.push(AppRoutes.notificationView, arguments: notificationViewModel);
      },
      child: Container(
        height: 36.h,
        width: 36.w,
        decoration: isActive
            ? const BoxDecoration(
                shape: BoxShape.circle,
                gradient: kVerticalGradiant,
              )
            : BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: kBlueColor,
                ),
              ),
        child: Center(
          child: isActive
              ? SvgPicture.asset(
                  "assets/icons/bell_icon.svg",
                  height: 21.h,
                  color: Colors.white,
                )
              : SvgPicture.asset(
                  "assets/icons/bell_icon.svg",
                  height: 21.h,
                ),
        ),
      ),
    );
  }
}
