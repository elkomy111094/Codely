import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_shoper_master/shared/constants/colors.dart';
import 'package:smart_shoper_master/shared/generic_cubit/generic_cubit.dart';
import 'package:smart_shoper_master/view_models/profile_viewModel.dart';

import '../../../shared/Common/gradiant_button.dart';
import '../../../shared/Common/loading_widget.dart';
import '../../../shared/prefs/pref_manager.dart';
import '../../../shared/util/ui.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({Key? key}) : super(key: key);
  static const String routeName = '/change_password_view';

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  ProfileViewModel profileViewModel = ProfileViewModel();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GenericCubit, GenericCubitState>(
      bloc: profileViewModel.profileCubit,
      listener: (context, state) {
        if (state is GenericErrorState) {
          UI.showAlert(
            context,
            message: state.responseError?.message ?? "",
            type: MessageType.error,
          );
        } else if (state is GenericUpdatedState) {
          profileViewModel.getUserData();
        } else if (state is GenericSucessRequestState) {
          PrefManager.setCurrentUser(state.data).then((value) => UI.pop());
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: kLightGreenColor,
            body: Column(
              children: [
                SizedBox(
                  height: 50.h,
                ),
                SizedBox(
                  height: 36.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "تعديل كلمه المرور",
                        style: GoogleFonts.tajawal(
                          fontSize: 23.sp,
                          color: kTextColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 28.h,
                ),
                Expanded(
                  child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(43.r),
                          topRight: Radius.circular(43.r),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 54.h,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "كلمه المرور الحاليه",
                                style: GoogleFonts.tajawal(
                                  fontSize: 14.sp,
                                  color: kTextColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: 11.h,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                width: 380.w,
                                height: 59.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.r),
                                  color: kLightGreyColor,
                                ),
                                child: TextField(
                                  maxLines: 1,
                                  controller: profileViewModel
                                      .currentPasswordController,
                                  style: GoogleFonts.tajawal(
                                    fontSize: 14.sp,
                                    color: kTextColor,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "كلمه المرور الجديده",
                                style: GoogleFonts.tajawal(
                                  fontSize: 14.sp,
                                  color: kTextColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: 11.h,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                width: 380.w,
                                height: 59.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.r),
                                  color: kLightGreyColor,
                                ),
                                child: TextField(
                                  maxLines: 1,
                                  controller:
                                      profileViewModel.newPasswordController,
                                  style: GoogleFonts.tajawal(
                                    fontSize: 14.sp,
                                    color: kTextColor,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "تاكيد كلمه المرور الجديده ",
                                style: GoogleFonts.tajawal(
                                  fontSize: 14.sp,
                                  color: kTextColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: 11.h,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                width: 380.w,
                                height: 59.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.r),
                                  color: kLightGreyColor,
                                ),
                                child: TextField(
                                  maxLines: 1,
                                  controller: profileViewModel
                                      .confirmPasswordController,
                                  style: GoogleFonts.tajawal(
                                    fontSize: 14.sp,
                                    color: kTextColor,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          SizedBox(
                            width: 320.w,
                            child: BlocBuilder<GenericCubit, GenericCubitState>(
                              bloc: profileViewModel.profileCubit,
                              builder: (context, lState) {
                                return state is GenericLoadingState
                                    ? Loading()
                                    : GestureDetector(
                                        onTap: () async {
                                          await profileViewModel
                                              .updatePassword();
                                        },
                                        child: GradiantButton(text: "تأكيد"),
                                      );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 118.h,
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
