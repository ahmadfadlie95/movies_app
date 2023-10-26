import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movies_app/models/movie_search.dart';
import 'package:http/http.dart'as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _movies = [
    // {
    //   "Title": "Harry Potter and the Deathly Hallows: Part 2",
    //   "Year": "2011",
    //   "imdbID": "tt1201607",
    //   "Type": "movie",
    //   "Poster":
    //       "https://m.media-amazon.com/images/M/MV5BMGVmMWNiMDktYjQ0Mi00MWIxLTk0N2UtN2ZlYTdkN2IzNDNlXkEyXkFqcGdeQXVyODE5NzE3OTE@._V1_SX300.jpg"
    // },
    // {
    //   "Title": "Harry Potter and the Sorcerer's Stone",
    //   "Year": "2001",
    //   "imdbID": "tt0241527",
    //   "Type": "movie",
    //   "Poster":
    //       "https://m.media-amazon.com/images/M/MV5BNmQ0ODBhMjUtNDRhOC00MGQzLTk5MTAtZDliODg5NmU5MjZhXkEyXkFqcGdeQXVyNDUyOTg3Njg@._V1_SX300.jpg"
    // },
    // {
    //   "Title": "Harry Potter and the Chamber of Secrets",
    //   "Year": "2002",
    //   "imdbID": "tt0295297",
    //   "Type": "movie",
    //   "Poster":
    //       "https://m.media-amazon.com/images/M/MV5BMjE0YjUzNDUtMjc5OS00MTU3LTgxMmUtODhkOThkMzdjNWI4XkEyXkFqcGdeQXVyMTA3MzQ4MTc0._V1_SX300.jpg"
    // },
    // {
    //   "Title": "Harry Potter and the Prisoner of Azkaban",
    //   "Year": "2004",
    //   "imdbID": "tt0304141",
    //   "Type": "movie",
    //   "Poster":
    //       "https://m.media-amazon.com/images/M/MV5BMTY4NTIwODg0N15BMl5BanBnXkFtZTcwOTc0MjEzMw@@._V1_SX300.jpg"
    // }
  ];
  var searchMovie = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movie App"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(child: TextField(controller: searchMovie, decoration: InputDecoration(hintText: "Enter movie title"),), flex: 2,),
              Expanded(child: ElevatedButton(onPressed: (){
                fetchMovies().then((value) => {
                  setState((){
                    _movies = value;
                  })
                });
              }, child: Text("Search")), flex: 1,)
            ],
          ),
          Expanded(
            flex: 1,
            child: ListView.builder(
                itemCount: _movies.length,
                itemBuilder: (context,index){
                  return Card(
                    child: ListTile(
                      leading: Image.network(_movies[index].poster),
                      title: Text(_movies[index].title),
                      subtitle: Text(_movies[index].year),
                      trailing: Icon(Icons.chevron_right),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
  //Future bermaksud asynchorize function perlu panggil menggunakan async & await, atau then
  //<>bermaksud jenis data yang dipulangkan, jika saya berkerja dengan {} jenis data adalah Class Name
  //jika saya berkerja dengan [], jenis data adalah List<Class Name>
  Future<List<MovieSearch>> fetchMovies() async {
    final response = await http
        .get(Uri.parse('https://www.omdbapi.com/?s='+ searchMovie.text +'&apikey=87d10179'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      //jika saya berkerja dengan {} panggil method ke 4 di dalam Class
      //jika saya berkerja dengan [] panggil method ke 5 di dalam Class
      return MovieSearch.moviesFromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
