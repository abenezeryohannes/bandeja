import 'package:equatable/equatable.dart';

class Setting extends Equatable {
  late String id;
  late String home_button_link;
  late String whatsApp;
  late String privacy_url;
  late String share_title;
  late String host_url;

  Setting(
      {required this.id,
      required this.host_url,
      required this.privacy_url,
      required this.share_title,
      required this.home_button_link,
      required this.whatsApp});

  @override
  List<Object?> get props => [id, home_button_link, share_title, whatsApp];
}
