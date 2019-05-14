import 'dart:async';
import 'package:restaurant_management_mobile/src/models/item_model.dart';
import 'package:restaurant_management_mobile/src/services/movie_api_provider.dart';

class Repository {
  final moviesApiProvider = MovieApiProvider();

  Future<ItemModel> fetchAllMovies(){
    return moviesApiProvider.fetchMoveList();
  }
}
