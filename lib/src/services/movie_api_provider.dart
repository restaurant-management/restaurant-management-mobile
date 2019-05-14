import 'dart:convert';
import 'dart:async';
import 'package:restaurant_management_mobile/src/models/item_model.dart';
import 'package:http/http.dart' show Client;

class MovieApiProvider{
  Client client = Client();
  final _apiKey = 'eba7734f56ab1683dc4e75b98250763e';

  Future<ItemModel> fetchMoveList() async {
    print('entered');
    final response = await client.get('http://api.themoviedb.org/3/movie/popular?api_key=$_apiKey');
    print(response.body.toString());
    if(response.statusCode == 200) {
      return ItemModel.fromJson(json.decode(response.body));
    } else throw Exception('Failed to load post.');
  }
}