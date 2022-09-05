import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:app/core/network/network.info.dart';
import 'package:app/core/pages/add.filter.page.dart';
import 'package:app/core/pages/candidates.list.page.dart';
import 'package:app/core/pages/web.view.page.dart';
import 'package:app/core/widgets/show.error.dart';
import 'package:app/features/authentication/presentation/bloc/user/user.bloc.dart';
import 'package:app/features/candidate/presentation/bloc/candidate_categories/candidate.categories.bloc.dart';
import 'package:app/features/candidate/presentation/bloc/featured_candidates/featured.candidates.bloc.dart';
import 'package:app/features/candidate/presentation/widgets/candidate.category.button.dart';
import 'package:app/features/setting/presentation/bloc/bloc/setting.bloc.dart';
import 'package:app/features/setting/presentation/widgets/home.link.button.dart';
import 'package:shimmer/shimmer.dart';

import '../../features/candidate/domain/entities/candidate.dart';
import '../../features/candidate/presentation/bloc/top_voted_candidates/top.voted.candidates.bloc.dart';
import '../../features/candidate/presentation/widgets/candidate.avatar.list.horizontal.dart';
import '../../features/candidate/presentation/widgets/candidate.carousal.dart';
import '../../features/candidate/presentation/widgets/shimmers/candidate.carousal.shimmer.dart';
import '../../features/candidate/presentation/widgets/shimmers/candidate.category.button.shimmer.dart';
import '../../injection.container.dart';
import '../error/failure.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Candidate> candidates = [];
  List<int> numbers = [1, 2, 3, 4, 5];
  final featuredBlocProvider = sl<FeaturedCandidatesBloc>();
  final candidateCategoriesBlocProvider = sl<CandidateCategoriesBloc>();
  final SettingBloc settingBlockProvider = sl<SettingBloc>();
  final topVotedCandidatesBlocProvider = sl<TopVotedCandidatesBloc>();

  late UserBloc userBloc;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    if (userBloc.state.runtimeType == UserStateLoaded) {
      userBloc
          .add(GetUserEvent(uid: (userBloc.state as UserStateLoaded).user.id));
    }
    featuredBlocProvider.add(RefreshFeaturedCandidatesEvent());
    candidateCategoriesBlocProvider.add(RefreshCandidateCategoriesEvent());
    settingBlockProvider.add(RefreshSettingEvent());
    topVotedCandidatesBlocProvider.add(RefreshTopVoteCandidateEvent());

    await Future.delayed(const Duration(milliseconds: 1000));
    bool connected = await sl<NetworkInfo>().isConnected;
    if (connected) {
      setState(() {
        _refreshController.refreshCompleted();
      });
    } else {
      setState(() {
        _refreshController.refreshFailed();
      });
    }
  }

  @override
  void initState() {
    userBloc = sl<UserBloc>();
    userBloc.add(LoadUserEvent());
    topVotedCandidatesBlocProvider.add(LoadTopVoteCandidateEvent());
    settingBlockProvider.add(LoadSettingEvent());
    featuredBlocProvider.add(LoadFeaturedCandidatesEvent());
    candidateCategoriesBlocProvider.add(LoadCandidateCategoriesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SmartRefresher(
          enablePullDown: true,
          enablePullUp: false,
          header: const WaterDropHeader(),
          controller: _refreshController,
          onRefresh: _onRefresh,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: Image.asset(
                            "assets/img/add.png",
                            height: 24,
                          ),
                          color: Colors.grey.shade700,
                          iconSize: 24,
                          onPressed: () {
                            showCupertinoModalBottomSheet(
                                closeProgressThreshold: 90,
                                expand: false,
                                backgroundColor: Colors.black,
                                elevation: 10,
                                context: context,
                                builder: (context) => SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        6 /
                                        12,
                                    child: AddFilterPage()));
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            const SizedBox(height: 16),
                            const Text(
                              "أُمّة 2022",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Image.asset(
                              "assets/img/app_logo_transparent.png",
                              height: 40,
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            const Text(
                              "شارك.. وقول رايك",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFFFD337)),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  BlocProvider(
                    create: (_) => settingBlockProvider,
                    child: BlocBuilder<SettingBloc, SettingState>(
                      builder: (context, state) {
                        return HomeLinkButton(
                          onClick: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WebViewPage(
                                        url: (state as SettingStateLoaded)
                                            .setting
                                            .home_button_link)))
                          },
                          onRetry: () =>
                              {settingBlockProvider.add(GetSettingEvent())},
                          state: state,
                        );
                      },
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BlocProvider(
                        create: (_) => topVotedCandidatesBlocProvider,
                        child: BlocBuilder<TopVotedCandidatesBloc,
                            TopVotedCandidateState>(
                          builder: (context, state) {
                            return CandidateAvatarListHorizontal(state: state);
                          },
                        ),
                      ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                    ],
                  ),
                  // const SizedBox(height: 20),
                ],
              ),
              _showFeaturedCandidates(context),
              Container(
                // color: Colors.grey.shade200,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: _showCandidatesCategory(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _showFeaturedCandidates(BuildContext context) {
    return BlocProvider(
        create: (_) => featuredBlocProvider,
        child: BlocBuilder<FeaturedCandidatesBloc, FeaturedCandidatesState>(
          builder: (context, state) {
            double height = MediaQuery.of(context).size.height * (5 / 12) + 50;
            switch (state.runtimeType) {
              case FeaturedCandidatesStateEmpty:
                return SizedBox(height: height);
              case FeaturedCandidatesStateLoading:
                return CandidateCarousalShimmer(
                  height: MediaQuery.of(context).size.height * (5 / 12) + 50,
                );
              case FeaturedCandidatesStateError:
                // return SizedBox();
                return SizedBox(
                  height: 400,
                  child: ShowError(
                      failure: (state as FeaturedCandidatesStateError).failure,
                      ErrorShowType: ErrorShowType.Vertical),
                );
              case FeaturedCandidatesStateLoaded:
                return CandidateCarousal(
                  candidates:
                      (state as FeaturedCandidatesStateLoaded).candidates,
                  height: MediaQuery.of(context).size.height * (5 / 12) + 50,
                );
              default:
                return SizedBox(height: height);
            }
          },
        ));
  }

  Widget _showCandidatesCategory(BuildContext context) {
    return BlocProvider(
        create: (_) => candidateCategoriesBlocProvider,
        child: BlocBuilder<CandidateCategoriesBloc, CandidateCategoriesState>(
          builder: (context, state) {
            // double height = MediaQuery.of(context).size.height * (5 / 12) + 50;
            switch (state.runtimeType) {
              case CandidateCategoriesStateEmpty:
                return const SizedBox(height: 20);
              case CandidateCategoriesStateLoading:
                return Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    enabled: true,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: const [
                          Flexible(
                              fit: FlexFit.loose,
                              child: CandidateCategoryButtonShimmer()),
                          Flexible(
                              fit: FlexFit.loose,
                              child: CandidateCategoryButtonShimmer()),
                          Flexible(
                              fit: FlexFit.loose,
                              child: CandidateCategoryButtonShimmer()),
                          Flexible(
                              fit: FlexFit.loose,
                              child: CandidateCategoryButtonShimmer()),
                          Flexible(
                              fit: FlexFit.loose,
                              child: CandidateCategoryButtonShimmer()),
                        ]));
              case CandidateCategoriesStateError:
                if ((state as CandidateCategoriesStateError)
                        .failure
                        .runtimeType !=
                    NoDataFailure) {
                  return const Center(
                      //   child: ShowError(
                      // ErrorShowType: ErrorShowType.Horizontal,
                      // failure: (state).failure,
                      // )
                      );
                } else {
                  return const SizedBox();
                }
              case CandidateCategoriesStateLoaded:
                return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: (state as CandidateCategoriesStateLoaded)
                        .candidateCategories
                        .map((e) => Flexible(
                            fit: FlexFit.loose,
                            child: CandidateCategoryButton(
                                onClick: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CandidateListPage(
                                                category: e,
                                              )));
                                },
                                category: e)))
                        .toList());
              default:
                return const SizedBox(height: 20);
            }
          },
        ));
  }
}
