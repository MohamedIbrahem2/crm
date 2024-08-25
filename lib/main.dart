import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/app.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  // Set the design size to 375 x 812
  await ScreenUtil.ensureScreenSize();

  runApp(const SalesCrmApp());
}




