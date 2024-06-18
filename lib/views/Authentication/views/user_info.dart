import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_shoper_master/shared/constants/colors.dart';
import 'package:smart_shoper_master/shared/extensions/padding_extentions.dart';
import 'package:smart_shoper_master/shared/generic_cubit/generic_cubit.dart';
import 'package:smart_shoper_master/shared/util/app_routes.dart';
import 'package:smart_shoper_master/view_models/registiration_view_model.dart';

import '../../../shared/Common/gradiant_button.dart';
import '../../../shared/Common/loading_widget.dart';
import '../../../shared/prefs/pref_manager.dart';
import '../../../shared/util/ui.dart';

class UserInfo extends StatelessWidget {
  UserInfo({Key? key, required this.registerationViewModel}) : super(key: key);
  RegisterationViewModel registerationViewModel;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GenericCubit, GenericCubitState>(
      bloc: registerationViewModel.registerationCubit,
      listener: (context, state) {
        if (state is GenericErrorState) {
          UI.showAlert(
            context,
            message: state.responseError?.message ?? "",
            type: MessageType.error,
          );
        } else if (state is GenericUpdatedState) {
          PrefManager.setCurrentUser(state.data);
        } else if (state is GenericSucessRequestState) {
          UI.pushWithRemove(AppRoutes.landingView);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              Container(
                height: 526.h,
                decoration: const BoxDecoration(
                  gradient: kVerticalGradiant,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 166.h,
                  ),
                  SizedBox(
                    height: 115.h,
                    child: Center(
                        child: DefaultTextStyle(
                      style: GoogleFonts.allan(
                        fontSize: 50,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          WavyAnimatedText("CODELY"),
                        ],
                        isRepeatingAnimation: false,
                        onTap: () {
                          print("Tap Event");
                        },
                      ),
                    )),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                          vertical: 30.h, horizontal: 50.w),
                      margin: EdgeInsets.only(top: 70.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(45.r),
                              topRight: Radius.circular(45.r)),
                          color: Colors.white),
                      child: Form(
                          child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                              "من فضلك قم باستكمال بياناتك",
                              style: GoogleFonts.tajawal(
                                fontSize: 23.sp,
                                color: kTextColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: 46.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Form(
                                  key: registerationViewModel
                                      .completeRegisterationFormKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "الاسم الاول",
                                        style: GoogleFonts.tajawal(
                                          fontSize: 14.sp,
                                          color: kDarkGreyColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 11.h,
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.w),
                                        width: 150.w,
                                        height: 59.h,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30.r),
                                          color: kLightGreyColor,
                                        ),
                                        child: TextField(
                                          controller: registerationViewModel
                                              .firstNameController,
                                          maxLines: 1,
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
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "الاسم الاخير",
                                      style: GoogleFonts.tajawal(
                                        fontSize: 14.sp,
                                        color: kDarkGreyColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 11.h,
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.w),
                                      width: 150.w,
                                      height: 59.h,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(30.r),
                                        color: kLightGreyColor,
                                      ),
                                      child: TextField(
                                        controller: registerationViewModel
                                            .lastNameController,
                                        maxLines: 1,
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
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "البريد الالكتروني",
                                  style: GoogleFonts.tajawal(
                                    fontSize: 14.sp,
                                    color: kDarkGreyColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: 11.h,
                                ),
                                Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.w),
                                  width: 320.w,
                                  height: 59.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.r),
                                    color: kLightGreyColor,
                                  ),
                                  child: TextField(
                                    controller:
                                        registerationViewModel.emailController,
                                    maxLines: 1,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "كلمه المرور",
                                  style: GoogleFonts.tajawal(
                                    fontSize: 14.sp,
                                    color: kDarkGreyColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: 11.h,
                                ),
                                Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.w),
                                  width: 320.w,
                                  height: 59.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.r),
                                    color: kLightGreyColor,
                                  ),
                                  child: TextField(
                                    controller: registerationViewModel
                                        .passwordController,
                                    maxLines: 1,
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
                            50.ph,
                            BlocBuilder<GenericCubit, GenericCubitState>(
                              bloc: registerationViewModel.registerationCubit,
                              builder: (context, lState) {
                                return state is GenericLoadingState
                                    ? Loading()
                                    : GestureDetector(
                                        onTap: () async {
                                          await registerationViewModel
                                              .completeRegisteration();
                                        },
                                        child: GradiantButton(text: "تسجيل"),
                                      );
                              },
                            ),
                          ],
                        ),
                      )),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
