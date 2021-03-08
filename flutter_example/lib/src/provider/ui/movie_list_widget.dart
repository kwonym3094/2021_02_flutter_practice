import 'package:flutter/material.dart';
import 'package:flutter_example/src/provider/model/movie.dart';
import 'package:flutter_example/src/provider/provider/movie_provider.dart';
import 'package:provider/provider.dart';

class MovieListWidget extends StatelessWidget {
  MovieProvider _movieProvider;

  Widget _makeViewOne(Movie movie){
      return Row(children: [
        ClipRRect(borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
          child: Image.network(movie.postUrl)),
        Expanded(child: 
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(movie.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Expanded(child: 
              Text(
                movie.overview,
                overflow: TextOverflow.ellipsis,
                maxLines: 8, 
                style: TextStyle(fontSize: 13,))),
            ],
          ),
        ))
      ],);
  }

  Widget _makeListView(List<Movie> movies) {
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(
                  color: Colors.grey.withOpacity((0.3)),
                  spreadRadius: 3, 
                  blurRadius: 3, 
                  offset: Offset(0,0))],
              ),
              child: _makeViewOne(movies[index]),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
        itemCount: movies.length);
  }

  @override
  Widget build(BuildContext context) {
    _movieProvider = Provider.of<MovieProvider>(context, listen: false);
    _movieProvider.loadMovies();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Movie Provider",
        ),
      ),
      body: Consumer<MovieProvider>(
        builder: (context, provider, child) {
          if (provider.movies != null && provider.movies.length > 0) {
            return _makeListView(provider.movies);
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
