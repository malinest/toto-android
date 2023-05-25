class Globals {
  // Variables for the REST API call
  static const String API_PROTOCOL = 'http://';
  static const String API_URI = 'to-to.duckdns.org';
  static const String API_IMAGES = '/static/images/';
  static const String API_VIDEOS = '/static/videos/';
  static const String GET_POSTS = '/api/get_posts';
  static const String GET_BOARDS = '/api/get_boards';
  static const String CREATE_POST = '/api/create_post';
  static const String CREATE_COMMENT = '/api/create_comment';
  static const String CREATE_USER = '/api/create_user';
  static const String LOG_IN = '/api/login';

  // Variables stored in the device
  static bool isLogged = false;
  static String username = '';

  // List of media types that the web app admits.
  static const List<String> MEDIA_TYPES = ['jpg', 'jpeg', 'png', 'gif', 'mp4'];

  // Paths of the local assets
  static String logoSvgPath = 'assets/logo.svg';
  static String loadingGifPath = 'assets/loading.gif';

  //Miscellaneous
  static String videoPlayerPlaceHolder =
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4';
  static int postContentMaxLines = 4;
  static int passwordMinLenght = 8;
  static int postFormContentMaxLength = 2400;
}
