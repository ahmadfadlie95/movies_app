// create a new class
class MovieSearch{
  //create properties
  final String title;
  final String year;
  final String type;
  final String poster;
  final String imdbId;

  //create constructor
MovieSearch({required this.title,required this.year, required this.type, required this.poster, required this.imdbId});

//create json to object transformer

factory MovieSearch.fromJson(Map<String, dynamic> json){
  return MovieSearch(title: json["Title"], year: json["Year"], type: json["Type"], poster: json["Poster"], imdbId: json["imdbID"]);
}
// 5. Array of object to list of object transformer
  static List<MovieSearch> moviesFromJson(dynamic json ){
    var searchResult = json["Search"];
    List<MovieSearch> results = List.empty(growable: true);

    if (searchResult != null){
      searchResult.forEach((v)=>{
        results.add(MovieSearch.fromJson(v))
      });
      return results;
    }
    return results;
  }

}
