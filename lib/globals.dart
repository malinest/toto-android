class Globals {
  static const String API_PROTOCOL = 'http://';
  static const String API_URI = 'to-to.duckdns.org';
  static const String GET_POSTS = '/api/get_posts';
  static const String GET_BOARDS = '/api/get_boards';
  static const String API_IMAGES = '/static/images/';
  static const String API_VIDEOS = '/static/videos/';
  static const String CREATE_POST = '/api/create_post';
  static const String CREATE_COMMENT = '/api/create_comment';
  static const String CREATE_USER = '/api/create_user';
  static const String LOG_IN = '/api/login';
  static bool isLogged = false;
  static String username = '';
  static const List<String> MEDIA_TYPES = [
    '.jpg',
    '.jpeg',
    '.png',
    '.gif',
    '.mp4'
  ];
}