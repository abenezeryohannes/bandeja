import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/features/authentication/presentation/bloc/user/user.bloc.dart';
import 'package:app/features/candidate/domain/entities/candidate.dart';
import 'package:app/features/candidate/presentation/widgets/candidate.avatar.dart';
import 'package:app/features/candidate/presentation/widgets/user.card.vote.button.dart';
import '../../../../injection.container.dart';
import '../../../authentication/domain/entities/user.dart';

class CandidateCard extends StatefulWidget {
  const CandidateCard(
      {Key? key,
      this.avatarRadius = 30,
      this.cardRadius = 10,
      required this.user,
      required this.candidate,
      required this.onClick})
      : super(key: key);

  final User? user;
  final double avatarRadius;
  final Function onClick;
  final double cardRadius;
  final Candidate candidate;

  @override
  State<CandidateCard> createState() => _CandidateCardState();
}

class _CandidateCardState extends State<CandidateCard> {
  UserBloc userBlocProvider = sl<UserBloc>();

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        elevation: 0.5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.cardRadius)),
        child: InkWell(
          onTap: () {
            widget.onClick();
          },
          child: Center(
            child: Column(children: [
              const SizedBox(
                height: 10,
              ),
              CandidateAvatar(
                hero:
                    "${widget.candidate.name}${widget.candidate.id}avatar-card",
                candidate: widget.candidate,
                borderColor: Colors.transparent,
                radius: 32,
                margins: EdgeInsets.zero,
                onClick: () {
                  widget.onClick();
                },
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 38,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text(widget.candidate.name,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                          fontSize: 11)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: BlocProvider(
                  create: (_) => userBlocProvider,
                  child: BlocBuilder<UserBloc, UserState>(
                    builder: (context, state) {
                      return UserCardVoteButton(
                          candidate: widget.candidate,
                          onSignUp: () {
                            userBlocProvider.add(LoadUserEvent());
                          },
                          userState: state,
                          user: widget.user,
                          onVote: () async {
                            if (state.runtimeType == UserStateLoaded) {
                              (state as UserStateLoaded).user.votedFor =
                                  widget.candidate.id;
                              userBlocProvider.add(SetUserVoteEvent(
                                  candidate: widget.candidate,
                                  user: state.user));
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                            }
                          });
                    },
                  ),
                ),
                // child: BigTextButton(
                //     elevation: 0,
                //     cornerRadius: 5,
                //     // text: "voice ${widget.candidate.votes}",
                //     textWidget: RichText(
                //         text: TextSpan(
                //             text: " ${widget.candidate.votes}",
                //             style: const TextStyle(
                //                 color: Colors.black,
                //                 fontSize: 12,
                //                 fontWeight: FontWeight.w800),
                //             children: const [
                //           TextSpan(
                //             text: "صوت",
                //             style: TextStyle(
                //                 color: Colors.black,
                //                 fontSize: 12,
                //                 fontWeight: FontWeight.w400),
                //           )
                //         ])),
                //     onClick: () {},
                //     padding:
                //         const EdgeInsets.symmetric(horizontal: 5, vertical: 0)),
              ),
            ]),
          ),
        ));
  }
}
