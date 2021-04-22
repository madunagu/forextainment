import 'package:forextainment/models/User.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class CategoryLoaded extends CategoryEvent {}

