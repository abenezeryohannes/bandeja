import 'package:bandeja/src/core/domain/notifications/entities/notification.dart';
import 'package:bandeja/src/core/domain/notifications/repositories/i.notification.repository.dart';
import 'package:bandeja/src/core/presentation/widgets/custom.shimmer.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../../../main/injection/injector.dart';

class NotificationCard extends StatefulWidget {
  const NotificationCard({Key? key, this.notification}) : super(key: key);
  final NotificationModel? notification;
  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  @override
  void initState() {
    if (widget.notification != null) {
      getIt<INotificationRepository>()
          .makeNotificationSeen(notificationId: widget.notification!.id);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
          color: isNotSeen()
              ? Theme.of(context).colorScheme.secondary.withOpacity(0.1)
              : Colors.grey.shade100,
          border: Border.all(
              width: 1,
              color: isNotSeen()
                  ? Theme.of(context).colorScheme.secondary
                  : Colors.grey.shade200),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomShimmer(
            show: widget.notification == null,
            child: Text(
              widget.notification == null
                  ? ".              ."
                  : widget.notification!.title,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: isNotSeen()
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).colorScheme.onBackground,
                  backgroundColor: widget.notification == null
                      ? Colors.grey.shade300
                      : null),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          CustomShimmer(
            show: widget.notification == null,
            child: Text(
                widget.notification == null
                    ? ".                                                        ."
                    : widget.notification!.desc,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    backgroundColor: widget.notification == null
                        ? Colors.grey.shade300
                        : null)),
          ),
          const SizedBox(
            height: 10,
          ),
          CustomShimmer(
            show: widget.notification == null,
            child: Text(
                timeago.format(widget.notification == null
                    ? DateTime.now()
                    : widget.notification!.createdAt ?? DateTime.now()),
                style: Theme.of(context).textTheme.caption!.copyWith(
                    backgroundColor: widget.notification == null
                        ? Colors.grey.shade300
                        : null)),
          ),
        ],
      ),
    );
  }

  bool isNotSeen() {
    return (widget.notification == null ? false : !widget.notification!.seen);
  }
}
