import 'package:equatable/equatable.dart';

class User extends Equatable {
  late String id;
  String? uid;
  late String identifier;
  String? votedFor;
  late String createdAt;

  User(
      {required this.id,
      this.uid,
      required this.identifier,
      this.votedFor,
      required this.createdAt});

  @override
  List<Object?> get props => [id, uid, identifier, votedFor, createdAt];
}
