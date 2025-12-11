import 'package:go_router/go_router.dart';
import 'package:simple_subscription_example/navigation/app_route.dart';
import 'package:simple_subscription_example/screens/home_page.dart';
import 'package:simple_subscription_example/screens/onboarding_page.dart';
import 'package:simple_subscription_example/screens/subscribtion_page.dart';
import 'package:simple_subscription_example/services/local_storage.dart';

class AppRouter {
  final LocalStorage storage;
  late final GoRouter router;

  AppRouter(this.storage) {
    final initialLocation = storage.isSubscribed
        ? AppRoute.home.path
        : AppRoute.onboarding.path;

    router = GoRouter(
      initialLocation: initialLocation,
      routes: [
        GoRoute(
          name: AppRoute.onboarding.name,
          path: AppRoute.onboarding.path,
          builder: (context, state) => OnboardingPage(storage: storage),
        ),
        GoRoute(
          name: AppRoute.subscription.name,
          path: AppRoute.subscription.path,
          builder: (context, state) => SubscriptionPage(storage: storage),
        ),
        GoRoute(
          name: AppRoute.home.name,
          path: AppRoute.home.path,
          builder: (context, state) => HomePage(storage: storage),
        ),
      ],
    );
  }
}
