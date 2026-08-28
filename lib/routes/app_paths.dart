class AppPaths {
  AppPaths._();

  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String mainNavigation = '/main-navigation';
  static const String products = '/products';
  static const String productDetail = '/product/:id';
  static const String childrenDetail = '/children-detail/:id';
  static const String helpdeskTicketList = '/helpdesk/tickets/list';
  static const String ticketDetail = '/helpdesk/tickets/detail/:id';
  static const String terms = '/terms';
  static const String usagePolicy = '/usage-policy';
  static const String aboutApp = '/about-app';
  static const String faq = '/faq';
  static const String classSchedule = '/class-schedule';
  static const String courseAttendance = '/course-attendance';
  static const String courseAttendanceDetail = '/course-attendance/detail/:id';
  static const String campusNews = '/campus-news';
  static const String notification = '/notification';
  static const String documentView = '/document/view';
  static const String chatbot = '/chatbot';
  static const String createTicket = '/helpdesk/tickets/create';

  static String productDetailWithId(int id) => '/product/$id';
  static String childrenDetailWithId(String id) => '/children-detail/$id';
  static String ticketDetailWithId(String ticketId) =>
      '/helpdesk/tickets/detail/${Uri.encodeComponent(ticketId)}';
  static String courseAttendanceDetailWithId(int id) =>
      '/course-attendance/detail/$id';
}
