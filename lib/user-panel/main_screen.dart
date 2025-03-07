import 'package:flutter/material.dart';
import 'package:youcollection/utils/app-constant.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text(
          AppConstant.appMainName,
          style: TextStyle(fontFamily: 'font', color: AppConstant.appTextColor),
        ),
        centerTitle: true,
      ),
    );
  }
}
