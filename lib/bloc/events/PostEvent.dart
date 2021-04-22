import 'package:forextainment/models/Category.dart';
import 'package:forextainment/models/User.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class PostLoaded extends PostEvent {
   final Category category;

  PostLoaded({@required this.category});

  @override
  List<Object> get props => [category];

  @override
  String toString() => 'PostLoaded { posts: posts have been gotten }';

}

