/// Represents the app routes and their paths.
enum AppRoutes {
  onBoarding(
    name: 'on_boarding',
    path: '/on_boarding',
  ),
  login(
    name: 'login',
    path: '/login',
  ),
  home(
    name: 'home',
    path: '/home',
  ),
  homeSearch(
    name: 'home_search',
    path: '/home_search',
  ),
  search(
    name: 'search',
    path: '/search',
  ),
  rentalViewAll(
    name: 'rental_view_all',
    path: '/rental_view_all',
  ),
  foodViewAll(
    name: 'food_view_all',
    path: '/food_view_all',
  ),
  rental(
    name: 'rental',
    path: '/rental/:id',
  ),
  food(
    name: 'food',
    path: '/food/:id',
  ),
  map(
    name: 'map',
    path: '/map',
  ),
  favorite(
    name: 'favorite',
    path: '/favorite',
  ),
  profile(
    name: 'profile',
    path: '/profile',
  ),
  about(
    name: 'about',
    path: '/about',
  );

  const AppRoutes({
    required this.name,
    required this.path,
  });

  /// Represents the route name
  ///
  /// Example: `AppRoutes.splash.name`
  /// Returns: 'splash'
  final String name;

  /// Represents the route path
  ///
  /// Example: `AppRoutes.splash.path`
  /// Returns: '/splash'
  final String path;

  @override
  String toString() => name;
}
