import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_shoper_master/shared/Common/gradiant_button.dart';
import 'package:smart_shoper_master/shared/constants/colors.dart';
import 'package:smart_shoper_master/shared/extensions/padding_extentions.dart';
import 'package:smart_shoper_master/shared/generic_cubit/generic_cubit.dart';
import 'package:smart_shoper_master/shared/util/app_routes.dart';
import 'package:smart_shoper_master/view_models/login_view_model.dart';
import 'package:smart_shoper_master/view_models/registiration_view_model.dart';

import '../../../shared/Common/loading_widget.dart';
import '../../../shared/prefs/pref_manager.dart';
import '../../../shared/util/ui.dart';

class AuthView extends StatefulWidget {
  const AuthView({Key? key}) : super(key: key);
  static const String routeName = '/auth';

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  bool isSignIn = true;
  LoginViewModel loginViewModel = LoginViewModel();

  RegisterationViewModel registerationViewModel = RegisterationViewModel();

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GenericCubit, GenericCubitState>(
      bloc: loginViewModel.loginCubit,
      listener: (context, state) {
        if (state is GenericErrorState) {
          UI.showAlert(
            context,
            message: state.responseError!.message,
            type: MessageType.error,
          );
        } else if (state is GenericUpdatedState) {
          PrefManager.setCurrentUser(state.data);
          loginViewModel.getUserData();
        } else if (state is GenericSucessRequestState) {
          UI.pushWithRemove(AppRoutes.landingView);
        }
      },
      builder: (context, state) {
        return BlocConsumer<GenericCubit, GenericCubitState>(
          bloc: registerationViewModel.registerationCubit,
          listener: (context, state) {
            if (state is GenericErrorState) {
              UI.showAlert(
                context,
                message: state.responseError?.message ?? "",
                type: MessageType.error,
              );
            } else if (state is GenericSucessRequestState) {
              UI.push(AppRoutes.userInfo, arguments: registerationViewModel);
            }
          },
          builder: (context, state) {
            return Scaffold(
              resizeToAvoidBottomInset: true,
              body: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 485.h,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          gradient: kVerticalGradiant,
                        ),
                      ),
                      Expanded(
                          child: Container(
                        decoration: const BoxDecoration(color: kLightGreyColor),
                      ))
                    ],
                  ),
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        100.ph,
                        SvgPicture.asset(
                          "assets/images/auth_image.svg",
                          height: 187.h,
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          height: isSignIn ? 446.h : 371.h,
                          width: 371.w,
                          padding: EdgeInsets.symmetric(
                              vertical: isSignIn ? 25.h : 44.h,
                              horizontal: 25.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(45.r),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: kLightGreyColor,
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Text(
                                  isSignIn ? "تسجيل دخول" : "انشاء حساب",
                                  style: GoogleFonts.tajawal(
                                    fontSize: 23.sp,
                                    color: kTextColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: 22.h),
                                Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.w),
                                  width: 320.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.r),
                                    color: kLightGreyColor,
                                  ),
                                  child: Row(
                                    children: [
                                      Center(
                                        child: SvgPicture.asset(
                                          "assets/icons/phone_icon.svg",
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Expanded(
                                        child: Form(
                                          key: isSignIn
                                              ? loginViewModel.loginFormKey
                                              : registerationViewModel
                                                  .phoneRegisterationFormKey,
                                          child: TextField(
                                            controller: isSignIn
                                                ? loginViewModel.phoneController
                                                : registerationViewModel
                                                    .phoneController,
                                            maxLines: 1,
                                            style: GoogleFonts.tajawal(
                                              fontSize: 14.sp,
                                              color: kTextColor,
                                              fontWeight: FontWeight.normal,
                                            ),
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "رقم الهاتف",
                                              hintStyle: GoogleFonts.tajawal(
                                                fontSize: 14.sp,
                                                color: kDarkGreyColor,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: isSignIn ? 17.h : 0),
                                if (isSignIn)
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.w),
                                    width: 320.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.r),
                                      color: kLightGreyColor,
                                    ),
                                    child: Row(
                                      children: [
                                        Center(
                                          child: SvgPicture.asset(
                                            "assets/icons/lock_icon.svg",
                                            //height: 11.h,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Expanded(
                                          child: TextField(
                                            controller: loginViewModel
                                                .passwordController,
                                            maxLines: 1,
                                            style: GoogleFonts.tajawal(
                                              fontSize: 14.sp,
                                              color: kTextColor,
                                              fontWeight: FontWeight.normal,
                                            ),
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "كلمه المرور",
                                              hintStyle: GoogleFonts.tajawal(
                                                fontSize: 14.sp,
                                                color: kDarkGreyColor,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                SizedBox(height: isSignIn ? 17.h : 0),
                                if (isSignIn)
                                  InkWell(
                                    onTap: () {
                                      UI.push(AppRoutes.forgetPasswordView);
                                    },
                                    child: Container(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        "نسيت كلمه المرور ؟",
                                        style: GoogleFonts.tajawal(
                                          fontSize: 14.sp,
                                          color: kTextColor,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                SizedBox(
                                  height: isSignIn ? 60.h : 40.h,
                                ),
                                BlocBuilder<GenericCubit, GenericCubitState>(
                                  bloc:
                                      registerationViewModel.registerationCubit,
                                  builder: (context, rState) {
                                    return BlocBuilder<GenericCubit,
                                        GenericCubitState>(
                                      bloc: loginViewModel.loginCubit,
                                      builder: (context, lState) {
                                        return lState is GenericLoadingState ||
                                                rState is GenericLoadingState
                                            ? Loading()
                                            : GestureDetector(
                                                onTap: () async {
                                                  isSignIn
                                                      ? await loginViewModel
                                                          .login()
                                                      : await registerationViewModel
                                                          .checkPhone();
                                                },
                                                child: GradiantButton(
                                                    text: isSignIn
                                                        ? "دخول"
                                                        : "تسجيل"),
                                              );
                                      },
                                    );
                                  },
                                ),
                                SizedBox(
                                  height: isSignIn ? 34.h : 44.h,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isSignIn = !isSignIn;
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        isSignIn
                                            ? "ليس لديك حساب ؟   "
                                            : "لديك حساب بالفعل ؟   ",
                                        style: GoogleFonts.tajawal(
                                          fontSize: 14.sp,
                                          color: kDarkGreyColor,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        isSignIn ? "انشاء حساب" : "تسجيل دخول",
                                        style: GoogleFonts.tajawal(
                                          fontSize: 14.sp,
                                          color: kTextColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                            height: 155.h,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [],
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
