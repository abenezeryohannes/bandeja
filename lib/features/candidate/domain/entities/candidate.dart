import 'package:equatable/equatable.dart';

class Candidate extends Equatable {
  late String id;
  late String name;
  late String categoryId;
  late String image;
  late int votes;
  late bool verified = false;
  late bool featured;
  String? videoLink;
  List<String> coverImages = [];

  Candidate(
      {required this.name,
      required this.image,
      required this.categoryId,
      this.featured = false,
      required this.id,
      this.votes = 0,
      this.verified = false,
      this.videoLink,
      this.coverImages = const []});

  @override
  List<Object?> get props => [name, image, verified, coverImages];
}
