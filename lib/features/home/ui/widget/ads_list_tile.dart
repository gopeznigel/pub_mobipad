import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:flutter_native_admob/native_admob_options.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdsListTile extends StatelessWidget {
  final bool show;
  final String adUnitId;
  final NativeAdmobController nativeAdController;

  AdsListTile({
    Key key,
    @required this.show,
    @required this.adUnitId,
    @required this.nativeAdController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final padding = show ? 10.h : 0.0;
    final containerHeight = show ? 265.h : 0.0;

    final ads = NativeAdmob(
      adUnitID: adUnitId,
      controller: nativeAdController,
      type: NativeAdmobType.banner,
      loading: Container(),
      numberAds: 5,
      options: NativeAdmobOptions(
          advertiserTextStyle: NativeTextStyle(color: Color(0xAA448aff)),
          headlineTextStyle: NativeTextStyle(color: Colors.blueAccent),
          showMediaContent: false),
    );

    final adsCard = Container(
      decoration: show
          ? BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 0.5,
                  offset: Offset(1, 1),
                  spreadRadius: 0.5,
                ),
              ],
            )
          : BoxDecoration(),
      height: containerHeight,
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: ads,
      ),
    );

    return Padding(
      padding: EdgeInsets.all(padding),
      child: adsCard,
    );
  }
}
