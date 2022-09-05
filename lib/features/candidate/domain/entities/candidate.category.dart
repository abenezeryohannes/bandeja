import 'package:equatable/equatable.dart';

class CandidateCategory extends Equatable {
  late String id;

  late String number;
  late String name;

  List<String> banners = [];

  CandidateCategory(
      {required this.name,
      required this.number,
      required this.id,
      this.banners = const []});

  @override
  List<Object?> get props => [id, name, banners, number];
}
