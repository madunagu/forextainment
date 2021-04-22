import 'package:equatable/equatable.dart';
import 'package:forextainment/models/Post.dart';
import 'package:meta/meta.dart';

abstract class PostState extends Equatable {
  @override
  List<Object> get props => [];
}

class PostLoading extends PostState {}

class PostSuccess extends PostState {
  final List<Post> posts;

  PostSuccess({@required this.posts});

  @override
  List<Object> get props => [posts];

  @override
  String toString() => 'PostSuccess { posts: posts have been gotten }';
}

class PostFailure extends PostState {
  final String message;

  PostFailure({@required this.message});

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'ChartFailure { posts:$message }';
}
