enum AppRoute {
  onboarding('onboarding', '/onboarding'),
  subscription('subscription', '/subscription'),
  home('home', '/');

  final String name;
  final String path;
  const AppRoute(this.name, this.path);
}
