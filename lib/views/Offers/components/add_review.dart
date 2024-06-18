import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_shoper_master/shared/constants/colors.dart';
import 'package:smart_shoper_master/shared/generic_cubit/generic_cubit.dart';

import '../../../shared/Common/gradiant_button.dart';
import '../../../shared/Common/loading_widget.dart';
import '../../../shared/util/ui.dart';
import '../../../view_models/rates_view_model.dart';

class AddReviewWidget extends StatelessWidget {
  AddReviewWidget({
    Key? key,
    required this.ratesViewModel,
    required this.storeId,
  }) : super(key: key);
  final RatesViewModel ratesViewModel;
  int storeId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GenericCubit, GenericCubitState>(
      bloc: ratesViewModel.ratesCubit,
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Form(
          key: ratesViewModel.ratesFormKey,
          child: Column(
            children: [
              Container(
                height: 65.h,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                width: 388.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.r),
                  color: kLightGreyColor,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: ratesViewModel.messageController,
                        maxLines: 1,
                        style: GoogleFonts.tajawal(
                          fontSize: 18.sp,
                          color: kTextColor,
                          fontWeight: FontWeight.normal,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "اضافه تقييم ….",
                          hintStyle: GoogleFonts.tajawal(
                            fontSize: 18.sp,
                            color: kDarkGreyColor,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    Center(
                      child: SvgPicture.asset(
                        "assets/icons/add_review.svg",
                      ),
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                height: 100.h,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RatingBar.builder(
                      initialRating: 3,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        ratesViewModel.changeRateVal(rating);
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
                child: BlocBuilder<GenericCubit, GenericCubitState>(
                  bloc: ratesViewModel.ratesCubit,
                  builder: (context, rState) {
                    return BlocBuilder<GenericCubit, GenericCubitState>(
                      bloc: ratesViewModel.ratesCubit,
                      builder: (context, lState) {
                        return lState is GenericLoadingState ||
                                rState is GenericLoadingState
                            ? Loading()
                            : GestureDetector(
                                onTap: () async {
                                  if (ratesViewModel
                                      .messageController.text.isEmpty) {
                                    UI.showAlert(
                                      context,
                                      message: "من فضلك أدخل رسالة التقييم",
                                      type: MessageType.error,
                                    );
                                  } else {
                                    await ratesViewModel
                                        .rateStore(storeId)
                                        .then((value) {
                                      UI.pop();
                                      ratesViewModel
                                          .getStoreRates(storeId)
                                          .then((value) {
                                        if (value != null)
                                          ratesViewModel
                                              .checkIfUserRateBefore();
                                      });
                                    });
                                  }
                                },
                                child: GradiantButton(text: "قيم الأن"),
                              );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
