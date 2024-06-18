import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_shoper_master/shared/constants/colors.dart';
import 'package:smart_shoper_master/shared/generic_cubit/generic_cubit.dart';
import 'package:smart_shoper_master/view_models/profile_viewModel.dart';

import '../../../shared/Common/gradiant_button.dart';
import '../../../shared/Common/loading_widget.dart';
import '../../../shared/util/ui.dart';

class ChangeNameView extends StatefulWidget {
  ChangeNameView({Key? key}) : super(key: key);
  static const String routeName = '/change_name_view';

  @override
  State<ChangeNameView> createState() => _ChangeNameViewState();
}

class _ChangeNameViewState extends State<ChangeNameView> {
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
        } else if (state is GenericSucessRequestState) {
          UI.pop();
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
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
                        "تعديل الاسم الشخصي",
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
                      child: Form(
                        key: profileViewModel.nameFormKey,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 50.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.all(20.h),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "الاسم الاول",
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
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.w),
                                            height: 59.h,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30.r),
                                              color: kLightGreyColor,
                                            ),
                                            child: TextField(
                                              maxLines: 1,
                                              controller: profileViewModel
                                                  .firstNameController,
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
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.all(20.h),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "الاسم الأخير",
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
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.w),
                                            height: 59.h,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30.r),
                                              color: kLightGreyColor,
                                            ),
                                            child: TextField(
                                              controller: profileViewModel
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
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 50.h,
                              ),
                              SizedBox(
                                width: 320.w,
                                child: BlocBuilder<GenericCubit,
                                    GenericCubitState>(
                                  bloc: profileViewModel.profileCubit,
                                  builder: (context, lState) {
                                    return state is GenericLoadingState
                                        ? Loading()
                                        : GestureDetector(
                                            onTap: () async {
                                              await profileViewModel
                                                  .updateName();
                                            },
                                            child:
                                                GradiantButton(text: "تسجيل"),
                                          );
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 118.h,
                              ),
                            ],
                          ),
                        ),
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
