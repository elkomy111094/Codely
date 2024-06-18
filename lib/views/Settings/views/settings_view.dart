import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_shoper_master/shared/Common/loading_widget.dart';
import 'package:smart_shoper_master/shared/constants/colors.dart';
import 'package:smart_shoper_master/shared/generic_cubit/generic_cubit.dart';
import 'package:smart_shoper_master/shared/util/app_routes.dart';
import 'package:smart_shoper_master/shared/util/ui.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../shared/Common/notification_widget.dart';
import '../../../shared/Common/profile_widget.dart';
import '../../../shared/Common/title_widget.dart';
import '../../../view_models/settings_view_model.dart';
import '../components/grid_view_widget.dart';

class SettingsView extends StatelessWidget {
  SettingsView({Key? key}) : super(key: key);
  SettingsViewModel settingsViewModel = SettingsViewModel();

  void makePhoneCall(String phoneNumber) async {
    final Uri url = Uri(scheme: "tel", path: phoneNumber);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GenericCubit, GenericCubitState>(
      bloc: settingsViewModel.settingsCubit,
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: kLightGreenColor,
          body: Column(
            children: [
              SizedBox(
                height: 50.h,
              ),
              SizedBox(
                height: 36.h,
                width: 367.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ProfileWidget(),
                    Text(
                      "الاعدادات",
                      style: GoogleFonts.tajawal(
                        fontSize: 23.sp,
                        color: kTextColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    NotificationWidget(),
                  ],
                ),
              ),
              SizedBox(
                height: 28.h,
              ),
              Expanded(
                child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 28.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(43.r),
                        topRight: Radius.circular(43.r),
                      ),
                    ),
                    child: settingsViewModel.settingsData == null
                        ? Center(
                            child: Loading(),
                          )
                        : SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 56.h,
                                ),
                                StaggeredGrid.count(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 26.h,
                                  crossAxisSpacing: 14.w,
                                  children: [
                                    // GridViewWidget(
                                    //   name: "صندوق الهدايا",
                                    //   svg: "assets/icons/gift_box.svg",
                                    //   type: 1,
                                    // ),
                                    // GridViewWidget(
                                    //   name: "الاشتراكات",
                                    //   svg: "assets/icons/subscriptions.svg",
                                    //   type: 1,
                                    // ),
                                    /*InkWell(
                                      onTap: () {
                                        settingsViewModel.settingsData!.pages
                                            .forEach((page) {
                                          if (page.title ==
                                              "كيفية عمل التطبيق") {
                                            UI.push(AppRoutes.settingsPageView,
                                                arguments: page);
                                          }
                                        });
                                      },
                                      child: GridViewWidget(
                                        name: "كيفيه عمل التطبيق",
                                        svg: "assets/icons/how_it_works.svg",
                                        type: 1,
                                      ),
                                    ),*/
                                    InkWell(
                                      onTap: () {
                                        settingsViewModel.settingsData!.pages
                                            .forEach((page) {
                                          if (page.title == "الشروط والأحكام") {
                                            UI.push(AppRoutes.settingsPageView,
                                                arguments: page);
                                          }
                                        });
                                      },
                                      child: GridViewWidget(
                                        name: "الشروط والاحكام",
                                        svg:
                                            "assets/icons/terms_and_conditions.svg",
                                        type: 1,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        settingsViewModel.settingsData!.pages
                                            .forEach((page) {
                                          if (page.title == "سياسة الخصوصيه") {
                                            UI.push(AppRoutes.settingsPageView,
                                                arguments: page);
                                          }
                                        });
                                      },
                                      child: GridViewWidget(
                                        name: "سياسه الخصوصيه",
                                        svg:
                                            "assets/icons/privacy_policies.svg",
                                        type: 1,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        settingsViewModel.settingsData!.pages
                                            .forEach((page) {
                                          if (page.title == "الأسئله الشائعه") {
                                            UI.push(AppRoutes.settingsPageView,
                                                arguments: page);
                                          }
                                        });
                                      },
                                      child: GridViewWidget(
                                        name: "الأسئله الشائعه",
                                        svg: "assets/icons/faq.svg",
                                        type: 1,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        settingsViewModel.settingsData!.pages
                                            .forEach((page) {
                                          if (page.title == "من نحن") {
                                            UI.push(AppRoutes.settingsPageView,
                                                arguments: page);
                                          }
                                        });
                                      },
                                      child: GridViewWidget(
                                        name: "من نحن",
                                        svg: "assets/icons/about_app.svg",
                                        type: 1,
                                      ),
                                    ),
                                    /*      GridViewWidget(
                                      name: "اللغه",
                                      svg: "assets/icons/language.svg",
                                      type: 1,
                                    ),*/
                                    InkWell(
                                      onTap: () async {
                                        makePhoneCall(settingsViewModel
                                            .settingsData!.info.phone);
                                      },
                                      child: GridViewWidget(
                                        name: "اتصل بنا",
                                        svg: "assets/icons/contactus.svg",
                                        type: 1,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 40.h,
                                ),
                                const TitleWidget(
                                    title: "تواصل معنا عبر", noMargin: false),
                                SizedBox(
                                  height: 20.h,
                                ),
                                StaggeredGrid.count(
                                  crossAxisCount: 4,
                                  mainAxisSpacing: 26.h,
                                  crossAxisSpacing: 8.w,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        _launchURL(settingsViewModel
                                            .settingsData!.social.facebook);
                                      },
                                      child: GridViewWidget(
                                        name: "فيس بوك",
                                        svg: "assets/icons/facebook.svg",
                                        type: 2,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        _launchURL(settingsViewModel
                                            .settingsData!.social.twitter);
                                      },
                                      child: GridViewWidget(
                                        name: "تويتر",
                                        svg: "assets/icons/twitter.svg",
                                        type: 2,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        _launchURL(settingsViewModel
                                            .settingsData!.social.instagram);
                                      },
                                      child: GridViewWidget(
                                        name: "انستجرام",
                                        svg: "assets/icons/instagram.svg",
                                        type: 2,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        _launchURL(
                                            'https://wa.me/+966${settingsViewModel.settingsData!.info.whatsApp}');
                                      },
                                      child: GridViewWidget(
                                        name: "الواتساب",
                                        svg: "assets/icons/whatsapp.svg",
                                        type: 2,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 40.h,
                                ),
                              ],
                            ),
                          )),
              ),
            ],
          ),
        );
      },
    );
  }
}
