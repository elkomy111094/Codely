import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../models/notification_model.dart';
import '../../../shared/constants/colors.dart';
import '../../../shared/constants/styles.dart';
import '../../../shared/util/ui.dart';
import '../../../view_models/notification_view_model.dart';

class NotificationItem extends StatefulWidget {
  NotificationModel notificationModel;
  NotificationViewModel notificationViewModel;
  int index;

  NotificationItem(
      {required this.notificationModel,
      required this.notificationViewModel,
      required this.index});

  @override
  State<NotificationItem> createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    print("x");
    return Dismissible(
      key: Key(widget.notificationModel.id.toString()),
      background: Container(
        color: Colors.red,
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.delete, color: Colors.white),
              SizedBox(
                width: 8.0,
              ),
              Text('حذف الإشعار',
                  style: AppStyles.kTextStyle12.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
      /*secondaryBackground: Container(
        color: Colors.green,
        child: const Padding(
          padding: EdgeInsets.all(15),
          child: Row(
            children: [
              Icon(Icons.favorite,
                  color:
                  Colors.white),
              SizedBox(
                width: 8.0,
              ),
              Text(
                  'تمت قرأتها',
                  style: TextStyle(
                      color: Colors
                          .white)),
            ],
          ),
        ),
      ),*/
      confirmDismiss: (direction) {
        UI.showPopup("  هل تود حذف هذا الإشعار من القائمه ؟  ",
            type: DialogType.question, btnOkText: "نعم", callBack: () async {
          widget.notificationViewModel.deleteNoteFromMyList(widget.index);
          UI.pop();
          await widget.notificationViewModel
              .deleteNote(widget.notificationModel.id);
        });
        return Future(() => false);
      },
      onDismissed: (direction) async {
        if (direction.index == 3) {
          setState(() {});
          switch (direction) {
            case DismissDirection.startToEnd:
              setState(() {});
              break;
            case DismissDirection.endToStart:
              break;
            default:
              throw ("Unsupported swipe direction ${direction.toString()} on NowPlayingBar!");
          }
        }
      },
      child: Card(
        color: kLightGreenColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.h),
        ),
        elevation: 0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 60.w,
                height: 80.h,
                decoration: BoxDecoration(
                  color: kLightGreyColor,
                  borderRadius: BorderRadius.circular(10.h),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10.h),
                  child: Center(
                    child: SvgPicture.asset(
                      "assets/icons/notification.svg",
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 5.w,
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 250.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Text(widget.notificationModel.title,
                              style: GoogleFonts.tajawal(
                                fontSize: 16.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      width: 100.w,
                      child: Divider(
                        height: 10.h,
                        thickness: 1,
                        color: Colors.grey,
                      )),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 250.w,
                        child: Text(widget.notificationModel.message,
                            /*overflow: TextOverflow.ellipsis,*/
                            style: GoogleFonts.tajawal(
                              fontSize: 14.sp,
                              color: Colors.grey,
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
