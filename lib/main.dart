import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/app.dart';
import 'core/services/services_locator.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  // init services locator
  await ServicesLocator().init();

  // Set the design size to 375 x 812
  await ScreenUtil.ensureScreenSize();

  runApp(const SalesCrmApp());
}




