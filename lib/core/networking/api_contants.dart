class ApiConstants {
  static const String apiBaseUrl =
      "http://194.233.71.42/~bdhpointdev/english/V1.0/";
  static String imageUrl = 'http://194.233.71.42/~bdhpointdev/english/';
  static const String login = "auth/login";
  static const String adminNotifications = "admin/notifications?page=1&read=1";
  static const String adminViewPrizes = "admin/viewPrizes?page=1";
  static const String collectPrize =
      "admin/students/{student_id}/collectedPrize/{prize_item_id}";
  static const String getAdminData = "admin/admins";
  static const String deleteAdmin = "admin/admins/{delete_admin_id}";
  static const String createAdmin = "admin/admins";
  static const String getTasks = "admin/todoNotifications?";
  static const String collectTasks =
      "admin/todoNotifications/{task_id}/makeDone";
  static const String getGrades = "admin/grades";
  static const String createGrades = "admin/grades";
  static const String editGrades = "admin/grades/{edit_grade_id}";
  static const String deleteGrades = "admin/grades/{delete_grade_id}";
  static const String createStudent = "admin/students";
  static const String createSection = "admin/sections";

  static List<String> wisdoms = [
    'Learning is a journey, not a destination. Embrace the process and be patient with yourself along the way.',
    'Patience is the key to unlocking the treasures of knowledge. Trust in your self become more and more better.',
    'The thing you avoid doing is the thing you don\'t want to do',
    'Get your feet tired, if they get tired you move forward',
    'Whoever asks for honey is not afraid of bee stings',
    'Always strive to understand and learn with an awake mind, not a sleepy one',
    'Like a seed planted in fertile soil, knowledge takes time to grow. Cultivate patience as you nurture your mind.',
    'The journey of a thousand miles begins with a single step. Embrace each step with patience and dedication to learning.',
    'As the stars illuminate the night sky one by one, knowledge reveals itself through patient exploration.',
  ];
}

class ApiErrors {
  static const String badRequestError = "badRequestError";
  static const String noContent = "noContent";
  static const String forbiddenError = "forbiddenError";
  static const String unauthorizedError = "unauthorizedError";
  static const String notFoundError = "notFoundError";
  static const String conflictError = "conflictError";
  static const String internalServerError = "internalServerError";
  static const String unknownError = "unknownError";
  static const String timeoutError = "timeoutError";
  static const String defaultError = "defaultError";
  static const String cacheError = "cacheError";
  static const String noInternetError = "noInternetError";
  static const String loadingMessage = "loading_message";
  static const String retryAgainMessage = "retry_again_message";
  static const String ok = "Ok";
}
