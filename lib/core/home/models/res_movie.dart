class Movie {
  bool adult;
  String backdropPath;
  List<int> genreIds;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  String releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  Movie({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    var movieData = json['results'][0];

    return Movie(
      adult: movieData['adult'],
      backdropPath: movieData['backdrop_path'],
      genreIds: List<int>.from(movieData['genre_ids']),
      id: movieData['id'],
      originalLanguage: movieData['original_language'],
      originalTitle: movieData['original_title'],
      overview: movieData['overview'],
      popularity: movieData['popularity'],
      posterPath: movieData['poster_path'],
      releaseDate: movieData['release_date'],
      title: movieData['title'],
      video: movieData['video'],
      voteAverage: movieData['vote_average'],
      voteCount: movieData['vote_count'],
    );
  }
}
