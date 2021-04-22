import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:forextainment/Exceptions.dart';
import 'package:forextainment/NetworkingClass.dart';
import 'package:forextainment/bloc/events/category_event.dart';
import 'package:forextainment/bloc/states/category_state.dart';
import 'package:forextainment/models/Category.dart';
import 'package:bloc/bloc.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  @override
  CategoryState get initialState => CategoryLoading();
  String getSpecific(String type, res) {
    if (type == 'status') {
      try {
        return res['_embedded']['wp:term'][1][0]['name'];
      } catch (e) {
        return 'unknown';
      }
    } else {
      try {
        return res['_embedded']['wp:term'][0][0]['name'];
      } catch (e) {
        return 'unknown';
      }
    }
  }

  @override
  Stream<CategoryState> mapEventToState(
    CategoryEvent event,
  ) async* {
    if (event is CategoryLoaded) {
      yield CategoryLoading();
      try {
        List<dynamic> res = await NetworkingClass().get('/categories');
        List<Category> categories = [];
        for (var i = 0; i < res.length; i++) {
          categories.add(Category(
            id: res[i]['id'],
            name: res[i]['name'],
            count: res[i]['count'],
            link: res[i]['_links']['wp:post_type'][0]['href'],
          ));
        }
        yield CategorySuccess(categories: categories);
      } on ServerErrorException catch (e) {
        log(e.toString());

        await Future.delayed(Duration(seconds: 2));
        yield CategoryFailure(message: 'Error Occured On Server');
      } on ClientErrorException catch (e) {
        log(e.toString());

        await Future.delayed(Duration(seconds: 2));
        yield CategoryFailure(message: 'Error Occured While Running Application');
      } on ConnectionException catch (e) {
        log(e.toString());
        yield CategoryFailure(message: 'Network Error Occured');
      } on SocketException catch (e) {
        await Future.delayed(Duration(seconds: 2));
        log(e.toString());
        yield CategoryFailure(message: 'Network Error Occured');
      } catch (e) {
        log(e.toString());
        await Future.delayed(Duration(seconds: 2));
        yield CategoryFailure(message: 'Unknown Error Occured');
      }
    }
  }
}
