import 'package:cli/cli.dart' as cli;
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<void> main(List<String> arguments) async {
  //kalau hosting itu apiKey ditaro di environment
  const String apiKey='e13f215ccc5a3ab3f9208f9935c94381';
  final response=await http.get(Uri.parse("https://api.themoviedb.org/3/trending/all/day?api_key=$apiKey"));
  print(response.body);

  final json=jsonDecode(response.body);

  final trendingMovies=Trending.fromJson(json);
  print(trendingMovies.results![0].name);

  print(json['results']);
}

class Trending{
  Trending({required this.page, required this.results,required this.total_pages, required this.total_result});
  int? page;
  List<Movies>? results;
  int? total_pages;
  int? total_result;

  factory Trending.fromJson(Map<String,dynamic> json)=>Trending(
      page: json['page'],
      results:List<Movies>.from(json['results'].map((data)=>Movies.fromJson(data))),
      total_pages:json["total_pages"],
      total_result:json["total_result"]

  );
}

class Movies{
  Movies({required this.id, required this.backdrop_path, required this.name, required this.overview});
  int? id;
  String? backdrop_path;
  String? name;
  String? overview;
  factory Movies.fromJson(Map<String,dynamic> json)=>Movies(
    id: json['id'],
    backdrop_path: json['backdrop_path'],
    name:json['name'],
    overview: json['overview'],


  );
}