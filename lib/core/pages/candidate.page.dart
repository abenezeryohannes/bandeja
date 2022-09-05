import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/core/error/failure.dart';
import 'package:app/core/pages/web.view.page.dart';
import 'package:app/core/widgets/loading.bar.dart';
import 'package:app/features/candidate/presentation/bloc/Candidate/candidate.bloc.dart';
import 'package:app/features/candidate/presentation/widgets/candidate.votes.card.dart';
import 'package:social_share/social_share.dart';
import '../../features/authentication/domain/entities/user.dart';
import '../../features/authentication/domain/usecases/get.user.dart';
import '../../features/authentication/presentation/bloc/user/user.bloc.dart';
import '../../features/candidate/domain/entities/candidate.dart';
import '../../features/candidate/presentation/widgets/candidate.avatar.dart';
import '../../features/candidate/presentation/widgets/candidate.cover,carousal.dart';
import '../../features/candidate/presentation/widgets/user.vote.button.dart';
import '../../features/setting/domain/entities/setting.dart';
import '../../features/setting/presentation/bloc/bloc/setting.bloc.dart';
import '../../injection.container.dart';

class CandidatePage extends StatefulWidget {
  const CandidatePage(
      {Key? key,
      required this.candidate,
      required this.avatar_hero_tag,
      required this.cover_hero_tag})
      : super(key: key);
  final Candidate candidate;
  final String avatar_hero_tag;
  final String cover_hero_tag;
  @override
  State<CandidatePage> createState() => _CandidatePageState();
}

class _CandidatePageState extends State<CandidatePage> {
  late Candidate candidate;
  late UserBloc userBlocProvider;
  late CandidateBloc candidateBlocProvider;
  bool loading = false;
  SettingBloc settingBloc = sl<SettingBloc>();
  @override
  void initState() {
    settingBloc.add(LoadSettingEvent());
    userBlocProvider = sl<UserBloc>();
    candidateBlocProvider = sl<CandidateBloc>();
    userBlocProvider.add(LoadUserEvent());
    candidateBlocProvider
        .add(GetCandidateEvent(candidateId: widget.candidate.id));
    candidate = widget.candidate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.down,
      key: const Key('key'),
      onDismissed: (_) => Navigator.of(context).pop(),
      child: Scaffold(
          backgroundColor: Colors.grey.shade100,
          body: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                if (loading) const LoadingBar(),
                Row(
                  children: [
                    const SizedBox(
                      width: 8,
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                      ),
                      color: Colors.black87,
                      iconSize: 36,
                      onPressed: () {
                        if (Navigator.canPop(context)) {
                          Navigator.maybePop(context);
                        }
                      },
                    ),
                    const Expanded(
                        child: Center(
                      child: Text("الدائرة الثالثة",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16)),
                    )),
                    BlocProvider(
                      create: (_) => settingBloc,
                      child: BlocBuilder<SettingBloc, SettingState>(
                        builder: (context, state) {
                          Setting? setting;
                          if (state.runtimeType == SettingStateLoaded) {
                            setting = (state as SettingStateLoaded).setting;
                          }
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  if (setting != null) {
                                    SocialShare.shareOptions((setting
                                            .share_title +
                                        ("${setting.host_url}/candidate?id=${candidate.id}")));
                                  }
                                },
                                child: Image.asset(
                                  "assets/img/share.png",
                                  height: 20,
                                ),
                              ),
                              const Text("انـشـر",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12)),
                            ],
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                  ],
                ),
                _carousal(candidate),
                const SizedBox(height: 10),
                Expanded(child: _body())
              ],
            ),
          )),
    );
  }

  Widget _body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Column(
          children: [
            Text(candidate.name,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.w300)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocProvider(
                  create: (_) => candidateBlocProvider,
                  child: BlocBuilder<CandidateBloc, CandidateState>(
                    builder: (context, state) {
                      return CandidateVotesCard(
                        candidateState: state,
                        candidate: widget.candidate,
                      );
                    },
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            if (widget.candidate.videoLink != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Image.asset('assets/img/video-marketing.png'),
                    iconSize: 100,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WebViewPage(
                                  url: candidate.videoLink ??
                                      "https://www.youtube.com")));
                    },
                  )
                ],
              ),
            Text("كلمة المرشح",
                style: TextStyle(
                  height: 0.1,
                  color: Colors.amber.shade400,
                  fontSize: 17,
                )),
          ],
        ),
        BlocProvider(
          create: (_) => userBlocProvider,
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if ((state.runtimeType == UserStateVoted)) {
                candidateBlocProvider
                    .add(GetCandidateEvent(candidateId: widget.candidate.id));
                userBlocProvider.loadUser(
                    Params(userUid: (state as UserStateVoted).user.id));
              }
              return Column(
                children: [
                  UserVoteButton(
                    candidate: candidate,
                    onSignUp: () {
                      userBlocProvider.add(LoadUserEvent());
                    },
                    userState: state,
                    onVote: () {
                      if (state.runtimeType == UserStateLoaded) {
                        (state as UserStateLoaded).user.votedFor =
                            widget.candidate.id;
                        userBlocProvider.add(SetUserVoteEvent(
                            candidate: widget.candidate, user: state.user));
                        Navigator.of(context, rootNavigator: true)
                            .pop('dialog');
                      }
                    },
                  ),
                  const SizedBox(height: 20)
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  _carousal(Candidate candidate) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: CandidateCoverCarousal(
            showAvatar: false,
            avatarHeroTag: "${Random()}",
            carousalHeroTag: widget.cover_hero_tag,
            showName: false,
            showVotes: false,
            candidate: candidate,
            height: MediaQuery.of(context).size.height * (4 / 12),
            viewFraction: 12 / 12,
            indicatorLocation: "end",
            indicator: (candidate.coverImages.isNotEmpty),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: CandidateAvatar(
            hero: widget.avatar_hero_tag,
            candidate: candidate,
            borderColor: Colors.black,
            radius: 25,
            margins: const EdgeInsets.symmetric(horizontal: 24),
            onClick: () {},
          ),
        )
      ],
    );
  }

  void _openAlertBoxToConfirm(User user, BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(("Are you sure?"),
                style: TextStyle(fontWeight: FontWeight.bold)),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: const [
                // const SizedBox(height: 20),
                Text(
                    "You can only vote for one candidate and This will not be reversable latter."),
              ],
            ),
            actionsOverflowButtonSpacing: 20,
            actions: [
              TextButton(
                  onPressed: () async {
                    user.votedFor = widget.candidate.id;
                    userBlocProvider.add(SetUserVoteEvent(
                        candidate: widget.candidate, user: user));
                    Navigator.of(context, rootNavigator: true).pop('dialog');
                  },
                  child: const Text("Yes, am sure",
                      style: TextStyle(fontWeight: FontWeight.bold))),
            ],
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
          );
        });
  }

  void _openAlertBoxToForbid(Failure failure, BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              ("You already voted!"),
            ),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                Text(failure.message ??
                    "Sorry, something went wrong, try again later."),
              ],
            ),
            actionsOverflowButtonSpacing: 20,
            actions: [
              TextButton(
                  onPressed: () async {
                    Navigator.of(context, rootNavigator: true).pop('dialog');
                  },
                  child: const Text(("ok"))),
            ],
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
          );
        });
  }
}
