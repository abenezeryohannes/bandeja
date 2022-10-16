import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/domain/padels/entities/padel.group.dart';
import '../../../../core/dto/wrapper.dto.dart';
import '../../../../core/presentation/widgets/show.error.dart';
import '../../../domain/core/entities/address.dart';
import '../../../presentation/search/search.result.page.dart';
import '../../../presentation/search/widget/looking.for.search.card.dart';
import '../../../presentation/search/widget/when.search.card.dart';
import '../../../presentation/search/widget/where.search.card.dart';
import '../controllers/search.controller.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final c = Get.put(SearchController());
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
            Theme.of(context).scaffoldBackgroundColor,
            Colors.white.withOpacity(0.2)
          ])),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: _appBar(),
          body: Column(
            children: [
              SizedBox(
                height: Get.height * 9 / 12,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Obx(() => c.padelGroups.value.when(emptyState: () {
                            return const SizedBox();
                          }, loadingState: (_) {
                            return LookingForSearchCard(
                              activate: () {},
                              active: false,
                              onChange: (_) {},
                              items: const [
                                null,
                                null,
                                null,
                                null,
                                null,
                                null,
                                null
                              ],
                              value: c.padelPicked.value,
                            );
                          }, loadedState: (padelGroups) {
                            return LookingForSearchCard(
                              activate: () {
                                setState(() {
                                  c.activeFilter.value =
                                      ActiveSearchFilter.groupType;
                                });
                              },
                              active: c.activeFilter.value ==
                                  ActiveSearchFilter.groupType,
                              onChange: (PadelGroupModel padel) {
                                c.padelPicked.value = padel;
                                setState(() {
                                  c.activeFilter.value =
                                      ActiveSearchFilter.address;
                                });
                              },
                              items: padelGroups,
                              value: c.padelPicked.value,
                            );
                          }, errorState: (error) {
                            return Expanded(child: ShowError(failure: error));
                          })),
                      Obx(() => c.addresses.value.when(emptyState: () {
                            return const SizedBox();
                          }, loadingState: (_) {
                            return WhereSearchCard(
                              activate: () {},
                              active: false,
                              onChange: (_) {},
                              items: const [null, null, null, null, null],
                              value: null,
                            );
                          }, loadedState: (padelGroups) {
                            return WhereSearchCard(
                              activate: () {
                                setState(() {
                                  c.activeFilter.value =
                                      ActiveSearchFilter.address;
                                });
                              },
                              active: c.activeFilter.value ==
                                  ActiveSearchFilter.address,
                              onChange: (addressModelitem) {
                                c.addressPicked.value = addressModelitem;
                                setState(() {
                                  c.activeFilter.value =
                                      ActiveSearchFilter.time;
                                });
                              },
                              items: padelGroups,
                              value: c.addressPicked.value,
                            );
                          }, errorState: (error) {
                            return Expanded(child: ShowError(failure: error));
                          })),
                      WhenSearchCard(
                        activate: () {
                          setState(() {
                            c.activeFilter.value = ActiveSearchFilter.time;
                          });
                        },
                        active: c.activeFilter.value == ActiveSearchFilter.time,
                        onChange: (date) {
                          setState(() {
                            c.datePicked.value = date;
                          });
                        },
                        value: c.datePicked.value,
                        startDate:
                            DateTime.now().subtract(const Duration(hours: 12)),
                        endDate: DateTime.now().add(const Duration(days: 365)),
                      ),
                    ],
                  ),
                ),
              ),
              _next(context)
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        "Booking",
        style: Theme.of(context).textTheme.titleMedium,
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      leadingWidth: 56,
      elevation: 0,
      leading: Container(
          margin: const EdgeInsets.only(top: 14, bottom: 14, left: 25),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(width: 1, color: Colors.grey.shade600)),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.close,
              size: 24,
              color: Colors.black,
            ),
          )),
    );
  }

  Widget _next(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.4)),
      alignment: Alignment.center,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {
                  setState(() {
                    c.activeFilter.value = ActiveSearchFilter.groupType;
                    c.datePicked.value = DateTime.now();
                    if (c.padelGroups.value.runtimeType ==
                        LoadedState<List<PadelGroupModel>>(value: [])
                            .runtimeType) {
                      c.padelPicked.value =
                          (c.padelGroups.value as LoadedState).value[0];
                    }
                    if (c.addresses.value.runtimeType ==
                        LoadedState<List<AddressModel>>(value: [])
                            .runtimeType) {
                      c.padelPicked.value =
                          (c.padelGroups.value as LoadedState).value[0];
                    }
                  });
                },
                child: Text("Clear All",
                    style: Theme.of(context).textTheme.bodyText1)),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10)),
                onPressed: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      opaque: false, // set to false
                      pageBuilder: (_, __, ___) => SearchResultPage(
                          addressModel: c.addressPicked.value,
                          padelGroupModel: c.padelPicked.value,
                          date: c.datePicked.value),
                    ),
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text("Search", style: TextStyle(color: Colors.white)),
                    Icon(Icons.keyboard_arrow_right),
                  ],
                ))
          ]),
    );
  }
}
