import '../utils/utils.dart';

final GoRouter routes = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/home',
  routes: <GoRoute>[
    GoRoute(
      path: '/home',
      name: 'home',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const HomeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            animation = CurvedAnimation(
              curve: Curves.fastLinearToSlowEaseIn,
              parent: animation,
              reverseCurve: Curves.fastOutSlowIn,
            );
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/conversation',
      name: 'conversation',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const ConversationScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            animation = CurvedAnimation(
              curve: Curves.fastLinearToSlowEaseIn,
              parent: animation,
              reverseCurve: Curves.fastOutSlowIn,
            );
            return SlideTransition(
              position: Tween(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              textDirection: TextDirection.rtl,
              child: child,
            );
          },
        );
      },
    ),
  ],
);
