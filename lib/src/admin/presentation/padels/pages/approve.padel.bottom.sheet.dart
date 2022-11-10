import 'package:bandeja/src/admin/presentation/padels/controllers/approve.padel.bottom.sheet.controller.dart';
import 'package:bandeja/src/core/domain/padels/entities/padel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApprovePadelBottomSheet extends StatefulWidget {
  const ApprovePadelBottomSheet({super.key, required this.padel});
  final PadelModel padel;
  @override
  State<ApprovePadelBottomSheet> createState() =>
      _ApprovePadelBottomSheetState();
}

class _ApprovePadelBottomSheetState extends State<ApprovePadelBottomSheet> {
  final controller = Get.put(ApprovePadelBottomSheetController());
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
