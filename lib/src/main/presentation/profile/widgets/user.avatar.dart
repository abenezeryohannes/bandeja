import 'package:bandeja/src/core/dto/wrapper.dto.dart';
import 'package:bandeja/src/core/network/api.dart';
import 'package:flutter/material.dart';

import '../../../../core/domain/authentication/entities/user.dart';
import '../../../../core/presentation/widgets/custom.shimmer.dart';
import '../../../../core/presentation/widgets/image.form.dart';

class UserAvatar extends StatefulWidget {
  const UserAvatar(
      {Key? key,
      required this.userDto,
      required this.size,
      required this.onUpload,
      required this.isLoading,
      required this.localImage})
      : super(key: key);
  final WrapperDto userDto;
  final double size;
  final String? localImage;
  final Function(String) onUpload;
  final Function(bool) isLoading;
  @override
  State<UserAvatar> createState() => _UserAvatarState();
}

class _UserAvatarState extends State<UserAvatar> {
  @override
  Widget build(BuildContext context) {
    return widget.userDto.when(
        emptyState: () => const SizedBox(),
        loadingState: (_) => CustomShimmer(
              show: true,
              child: Container(
                height: widget.size,
                width: widget.size,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300, shape: BoxShape.circle),
              ),
            ),
        loadedState: (value) => ImageForm(
              width: widget.size,
              height: widget.size,
              radius: 100,
              imageLink: (value as UserModel).avatar == null
                  ? null
                  : Api.getMedia(value.avatar!),
              localImage: widget.localImage,
              placeholder: Image.asset(
                "assets/icons/user_account.png",
                height: widget.size,
              ),
              onUpload: (x) => widget.onUpload(x),
              isLoading: (loading) => widget.isLoading(loading),
            ),
        errorState: (failure) => SizedBox(
              height: widget.size,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/icons/error.png',
                    width: widget.size / 2,
                    height: widget.size / 2,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Flexible(
                      child: Text(
                    failure.message ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(color: Colors.red),
                  ))
                ],
              ),
            ));
  }
}
