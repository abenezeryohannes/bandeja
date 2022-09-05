import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/features/setting/presentation/widgets/add.filter.button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../features/setting/domain/entities/setting.dart';
import '../../features/setting/presentation/bloc/bloc/setting.bloc.dart';
import '../../injection.container.dart';
import '../widgets/loading.bar.dart';

class AddFilterPage extends StatefulWidget {
  const AddFilterPage({Key? key}) : super(key: key);

  @override
  State<AddFilterPage> createState() => _AddFilterPageState();
}

class _AddFilterPageState extends State<AddFilterPage> {
  final PageController controller = PageController();
  bool loading = false;
  SettingBloc settingBlockProvider = sl<SettingBloc>();
  @override
  void initState() {
    settingBlockProvider.add(LoadSettingEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            children: [
              if (loading) const LoadingBar(),
              Center(
                child: SizedBox(
                  height: 30,
                  child: Icon(
                    Icons.maximize,
                    size: 50,
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    "assets/img/ngicon.png",
                    width: 120,
                    height: 120,
                  )
                ],
              ),
              const SizedBox(height: 20),
              const Text("لإضافة مرشح",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 34)),
              const SizedBox(height: 10),
              Text("في تطبيق صوّت",
                  style: TextStyle(
                      color: Colors.amber.shade500,
                      fontWeight: FontWeight.w400,
                      fontSize: 16)),
            ],
          ),
          BlocProvider(
            create: (_) => settingBlockProvider,
            child: BlocBuilder<SettingBloc, SettingState>(
              builder: (context, state) {
                return Column(
                  children: [
                    const SizedBox(height: 60),
                    AddFilterButton(
                      onClick: () =>
                          {openwhatsapp((state as SettingStateLoaded).setting)},
                      onRetry: () =>
                          {settingBlockProvider.add(GetSettingEvent())},
                      state: state,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      )),
    );
  }

  openwhatsapp(Setting setting) async {
    var whatsapp = setting.whatsApp;
    var whatsappURl_android = "whatsapp://send?phone=$whatsapp";
    var whatappURL_ios = "https://wa.me/$whatsapp";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunch(whatappURL_ios)) {
        await launch(whatappURL_ios, forceSafariVC: false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                new Text("Please, install whatsApp first, and try again.")));
      }
    } else {
      // android , web
      if (await canLaunch(whatsappURl_android)) {
        await launch(whatsappURl_android);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                new Text("Please, install whatsApp first, and try again.")));
      }
    }
  }
}
