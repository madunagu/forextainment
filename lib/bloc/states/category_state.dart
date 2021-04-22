import 'package:equatable/equatable.dart';
import 'package:forextainment/models/Category.dart';
import 'package:meta/meta.dart';

abstract class CategoryState extends Equatable {
  @override
  List<Object> get props => [];
}

class CategoryLoading extends CategoryState {}

class CategorySuccess extends CategoryState {
  final List<Category> categories;

  CategorySuccess({@required this.categories});

  @override
  List<Object> get props => [categories];

  @override
  String toString() => 'CategorySuccess { posts: posts have been gotten }';
}

class CategoryFailure extends CategoryState {
  final String message;

  CategoryFailure({@required this.message});

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'CategoryFailure { posts:$message }';
}
