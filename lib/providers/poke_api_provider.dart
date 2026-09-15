import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PokeApiProvider extends ChangeNotifier {


  final String _baseUrl = 'pokeapi.co';
  final String _apiPath = '/api/v2';

  Future<http.Response> getGenerations() async {
    final url = Uri.https(_baseUrl, '$_apiPath/generation');
    final response = await http.get(url);
    return response;
  }

  Future<http.Response> getGenerationDetail(int id) async {
    final url = Uri.https(_baseUrl, '$_apiPath/generation/$id');
    final response = await http.get(url);
    return response;
  } 
  Future<http.Response> getPokemonDetail(int id) async {
    final url = Uri.https(_baseUrl, '$_apiPath/pokemon/$id');
    final response = await http.get(url).timeout(const Duration(seconds: 20));
    if (response.statusCode != 200) {
      throw Exception('No se pudo cargar el Pokémon (${response.statusCode})');
    }
    return response;
  }
}
