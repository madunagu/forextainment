import 'dart:async';
import 'dart:developer';

import 'package:forextainment/Exceptions.dart';
import 'package:forextainment/NetworkingClass.dart';
import 'package:forextainment/bloc/events/category_event.dart';
import 'package:forextainment/bloc/events/PostEvent.dart';
import 'package:forextainment/bloc/states/category_state.dart';
import 'package:forextainment/bloc/states/PostState.dart';
import 'package:forextainment/models/Category.dart';
import 'package:forextainment/models/Post.dart';
import 'package:bloc/bloc.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  @override
  PostState get initialState => PostLoading();

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

  String manualStripTag(String unstriped) {
    if (unstriped.length > 7) {
      return unstriped.substring(3).substring(0, unstriped.length - 8);
    }
    return unstriped;
  }

  @override
  Stream<PostState> mapEventToState(
    PostEvent event,
  ) async* {
    if (event is PostLoaded) {
      yield PostLoading();
      try {
        List<dynamic> res =
            await NetworkingClass().get("/posts?_embed=author,wp:term&categories=${event.category.id}&per_page=1");
        List<Post> posts = [];
        for (var i = 0; i < res.length; i++) {
          posts.add(Post(
            image: res[i]['jetpack_featured_media_url'],
            body: manualStripTag(res[i]['content']['rendered']),
            values: "${res[i]['title']['rendered']}".split(','),
            category: getSpecific('category', res[i]),
            status: getSpecific('status', res[i]),
            outlook: manualStripTag(res[i]['excerpt']['rendered']),
            createdAt: DateTime.parse(res[i]['date']),
            updatedAt: DateTime.parse(res[i]['modified']),
          ));
        }

        yield PostSuccess(posts: posts);
      } on ServerErrorException catch (e) {
        log(e.toString());
        await Future.delayed(Duration(seconds: 5));
        yield PostFailure(message: 'Error Occured On Server');
      } on ClientErrorException catch (e) {
        log(e.toString());
        yield PostFailure(message: 'Error Occured While Running Application');
      } on ConnectionException catch (e) {
        log(e.toString());
        yield PostFailure(message: 'Network Error Occured');
      } catch (e) {
        log(e.toString());
        await Future.delayed(Duration(seconds: 5));
        yield PostFailure(message: 'Unknown Error Occured');
      }
    }
  }
}
