import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/core/pages/candidate.page.dart';
import 'package:app/core/widgets/show.error.dart';
import 'package:app/features/authentication/presentation/bloc/user/user.bloc.dart';
import 'package:app/features/candidate/presentation/bloc/candidates_under_category/candidates.under.category.bloc.dart';
import 'package:app/features/candidate/presentation/widgets/candidate.category.button.dart';
import 'package:app/features/candidate/presentation/widgets/candidate.cover,carousal.dart';
import 'package:shimmer/shimmer.dart';

import '../../features/authentication/domain/entities/user.dart';
import '../../features/candidate/data/models/candidate.model.dart';
import '../../features/candidate/domain/entities/candidate.category.dart';
import '../../features/candidate/domain/entities/candidate.dart';
import '../../features/candidate/presentation/widgets/candidate.card.dart';
import '../../features/candidate/presentation/widgets/shimmers/candidate.card.shimmer.dart';
import '../../features/candidate/presentation/widgets/shimmers/candidate.carousal.shimmer.dart';
import '../../injection.container.dart';
import '../fixtures/fixture.reader.dart';

class CandidateListPage extends StatefulWidget {
  const CandidateListPage({Key? key, required this.category}) : super(key: key);

  final CandidateCategory category;
  @override
  State<CandidateListPage> createState() => _CandidateListPageState();
}

class _CandidateListPageState extends State<CandidateListPage> {
  List<Candidate> candidates = [];

  void load() async {
    Iterable l = json.decode(await fixturesFromAsset("candidates.json"));
    setState(() {
      candidates = List<Candidate>.from(
          l.map((model) => CandidateModel.fromJson(model)));
    });
  }

  final candidatesUnderCategoryBlocProvider = sl<CandidatesUnderCategoryBloc>();
  final userBloc = sl<UserBloc>();
  @override
  void initState() {
    userBloc.add(LoadUserEvent());
    candidatesUnderCategoryBlocProvider
        .add(GetCandidatesUnderCategoryEvent(categoryId: widget.category.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: BlocProvider(
          create: (_) => candidatesUnderCategoryBlocProvider,
          child: BlocBuilder<CandidatesUnderCategoryBloc,
              CandidatesUnderCategoryState>(builder: (context, state) {
            Widget? bodyW;
            Widget carousal = (widget.category.banners
                    .where((element) => element.length > 6)
                    .toList()
                    .isNotEmpty)
                ? _carousal(widget.category.banners)
                : const SizedBox();
            switch (state.runtimeType) {
              case CandidatesUnderCategoryStateEmpty:
                bodyW = const Center();
                break;
              case CandidatesUnderCategoryStateLoading:
                bodyW = Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    enabled: true,
                    child: _candidateGridShimmer());
                break;
              case CandidatesUnderCategoryStateError:
                bodyW = Padding(
                  padding: EdgeInsets.symmetric(horizontal: 42, vertical: 60),
                  child: ShowError(
                    failure:
                        (state as CandidatesUnderCategoryStateError).failure,
                    ErrorShowType: ErrorShowType.Vertical,
                  ),
                );
                break;
              case CandidatesUnderCategoryStateLoaded:
                bodyW = BlocProvider(
                  create: (_) => userBloc,
                  child: BlocBuilder<UserBloc, UserState>(
                    builder: (context, state2) {
                      User? user = (state2.runtimeType == UserStateLoaded)
                          ? (state2 as UserStateLoaded).user
                          : null;
                      return _candidateGrid(
                          (state as CandidatesUnderCategoryStateLoaded)
                              .candidates,
                          user);
                    },
                  ),
                );
                break;
              default:
                bodyW = const Center();
            }
            return NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      title: _appBar(context),
                      pinned: true,
                      backgroundColor: Colors.grey.shade100,
                      floating: true,
                      iconTheme: const IconThemeData(size: 0),
                      leadingWidth: 0,
                      leading: null,
                      expandedHeight:
                          (widget.category.banners.length > 0) ? 290 : 60,
                      forceElevated: innerBoxIsScrolled,
                      flexibleSpace: FlexibleSpaceBar(
                        expandedTitleScale: 3,
                        background: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
                            child: (widget.category.banners.length > 0)
                                ? carousal
                                : SizedBox()),
                      ),
                    ),
                  ];
                },
                body: bodyW);
          }),
        ),
      ),
    );
  }

  Widget _appBar(BuildContext context) {
    return Row(
      children: [
        Center(
          child: IconButton(
            icon: const Icon(
              Icons.keyboard_arrow_down,
            ),
            color: Colors.black87,
            iconSize: 36,
            onPressed: () {
              if (Navigator.canPop(context)) Navigator.maybePop(context);
            },
          ),
        ),
        Expanded(
            child: Center(
          child: Text(widget.category.name,
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: 16)),
        )),
        CandidateCategoryButton(
          category: widget.category,
          onClick: () {},
        )
      ],
    );
  }

  Widget _candidateGrid(List<Candidate> candidates, User? user) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 4 / 6,
                crossAxisCount: 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5),
            shrinkWrap: true,
            itemCount: candidates.length,
            itemBuilder: (BuildContext ctx, index) {
              return CandidateCard(
                candidate: candidates[index],
                onClick: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          opaque: false,
                          pageBuilder: (_, __, ___) => CandidatePage(
                                candidate: candidates[index],
                                cover_hero_tag:
                                    "${candidates[index].name}${candidates[index].id}dont-user",
                                avatar_hero_tag:
                                    "${candidates[index].name}${candidates[index].id}avatar-card",
                              )));
                },
                user: user,
              );
            }),
      ),
    );
  }

  Widget _candidateGridShimmer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 4 / 6,
              crossAxisCount: 3,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5),
          shrinkWrap: true,
          itemCount: 9,
          itemBuilder: (BuildContext ctx, index) {
            return const CandidateCardShimmer();
          }),
    );
  }

  _carousalShimmer() {
    return CandidateCarousalShimmer(
      height: 190,
      showAvatar: false,
      showName: false,
      showVotes: false,
      indicatorLocation: "center",
      indicator: candidates.isNotEmpty,
      viewFraction: 11 / 12,
    );
  }

  _carousal(List<String> banners) {
    Candidate fake = Candidate(
        categoryId: "-1",
        id: '-1',
        image: '-1',
        name: '',
        coverImages: banners.where((element) => element.length > 6).toList());
    return CandidateCoverCarousal(
      candidate: fake,
      height: 190,
      showAvatar: false,
      showName: false,
      showVotes: false,
      indicatorLocation: "center",
      indicator: fake.coverImages.isNotEmpty,
      viewFraction: 11 / 12,
      avatarHeroTag: 'avatar-category-carousal-hero',
      carousalHeroTag: 'candidate-category-carousal-hero',
      // indicatorLocation: "end",
    );
  }

  Widget _numberWidgets(String number, BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        margin: const EdgeInsets.only(right: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.amber.shade400),
        child: Text(
          number,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ),
    );
  }
}
