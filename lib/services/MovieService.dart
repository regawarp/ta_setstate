import 'package:ta_setstate/models/Movie.dart';
import 'package:ta_setstate/repositories/Repository.dart';

class MovieService {
  Repository _repository;

  MovieService() {
    _repository = Repository();
  }

  saveMovie(Movie movie) async {
    return await _repository.insertData('movies', movie.toMap());
  }

  readMovies(int limit) async {
    List<Movie> _movieList = List<Movie>();
    var movies = await _repository.getMovies('movies',limit);
    movies.forEach((movie) {
      var movieObj = Movie(movie['id'], movie['title'], movie['synopsis'],
          movie['image'], movie['genre']);
      _movieList.add(movieObj);
    });
    return _movieList;
  }
}
