

// import '../utils/utils.dart';



// final GoRouter routes = GoRouter(

//   routes: <GoRoute>[
//     GoRoute(
//       path: '/',
//       pageBuilder: (BuildContext context, GoRouterState state) {
//         return  MaterialPage(
//           key: state.pageKey,
//           child:Repository.instance.checkNewUser() != true
//               ? const OnboardingScreen()
//               : const GetStartedScreen(),
//         );
//       },
//       routes: [
//         GoRoute(
//           path: 'welcome',
//           pageBuilder: (BuildContext context, GoRouterState state) {
//             return MaterialPage(
//               key: state.pageKey,
//               child: const GetStartedScreen(),
//             );
//           },
//         ),
//         GoRoute(
//           path: 'welcome-back',
//           pageBuilder: (BuildContext context, GoRouterState state) {
//             return MaterialPage(
//               key: state.pageKey,
//               child: const WelcomeBackScreen(),
//             );
//           },
//         ),
//         GoRoute(
//           path: 'sign-up-form/:action',
//           name: 'sign-up',
//           pageBuilder: (BuildContext context, GoRouterState state) {
//             /// There needs to be a way for us to know if the person clicked on
//             /// as a user or as a vendor.
//             /// hence I put the action.
//             /// So, if it's as a user, the url looks like this: sign-up-form/user
//             /// if it's as a vendpr, it looks something like this: sign-up-form/vendor
//             /// That way, we can now make an if statement in the app'slogic
//             final action = state.params['action']!;
//             return MaterialPage(
//               key: state.pageKey,
//               child: SignUpFormScreen(action: action),
//             );
//           },
//         ),
//         GoRoute(
//           path: 'survey-page',
//           pageBuilder: (BuildContext context, GoRouterState state) {
//             return MaterialPage(
//               key: state.pageKey,
//               child: const SurveyPageScreen(),
//             );
//           },
//         ),
//       ],
//     ),
//     GoRoute(
//       path: '/recover-account',
//       pageBuilder: (BuildContext context, GoRouterState state) {
//         return MaterialPage(
//           key: state.pageKey,
//           child: const RecoverAccountScreen(),
//         );
//       },
//       routes: [
//         GoRoute(
//           path: 'email-recovery',
//           pageBuilder: (BuildContext context, GoRouterState state) {
//             return MaterialPage(
//               key: state.pageKey,
//               child: const EmailRecoveryScreen(),
//             );
//           },
//         ),
//         GoRoute(
//           path: 'phone-recovery',
//           pageBuilder: (BuildContext context, GoRouterState state) {
//             return MaterialPage(
//               key: state.pageKey,
//               child: const PhoneRecoveryScreen(),
//             );
//           },
//         ),
//         GoRoute(
//           path: 'other-recovery',
//           pageBuilder: (BuildContext context, GoRouterState state) {
//             return MaterialPage(
//               key: state.pageKey,
//               child: const OtherRecoveryScreen(),
//             );
//           },
//         ),
//         GoRoute(
//           path: 'create-password',
//           pageBuilder: (BuildContext context, GoRouterState state) {
//             return MaterialPage(
//               key: state.pageKey,
//               child: const CreatePasswordScreen(),
//             );
//           },
//         ),
//         GoRoute(
//           path: 'congratulations',
//           pageBuilder: (BuildContext context, GoRouterState state) {
//             return MaterialPage(
//               key: state.pageKey,
//               child: const CongratulationScreen(),
//             );
//           },
//         ),
//       ],
//     ),
//     GoRoute(
//       path: '/vendor-setup',
//       pageBuilder: (BuildContext context, GoRouterState state) {
//         return MaterialPage(
//           key: state.pageKey,
//           child: const VendorSetupScreen(),
//         );
//       },
//       routes: [
//         GoRoute(
//           path: 'step1',
//           pageBuilder: (BuildContext context, GoRouterState state) {
//             return MaterialPage(
//               key: state.pageKey,
//               child: const VendorStep1Screen(),
//             );
//           },
//         ),
//         GoRoute(
//           path: 'step2',
//           pageBuilder: (BuildContext context, GoRouterState state) {
//             return MaterialPage(
//               key: state.pageKey,
//               child: const VendorStep2Screen(),
//             );
//           },
//         ),
//         GoRoute(
//           path: 'step3',
//           pageBuilder: (BuildContext context, GoRouterState state) {
//             return MaterialPage(
//               key: state.pageKey,
//               child: const VendorStep3Screen(),
//             );
//           },
//         ), GoRoute(
//           path: 'step4',
//           pageBuilder: (BuildContext context, GoRouterState state) {
//             return MaterialPage(
//               key: state.pageKey,
//               child: const VendorStep4Screen(),
//             );
//           },
//         ),
//         GoRoute(
//           path: 'business-info',
//           pageBuilder: (BuildContext context, GoRouterState state) {
//             return MaterialPage(
//               key: state.pageKey,
//               child: const BusinessInformationScreen(),
//             );
//           },
//         ),
//       ],
//     ),

//     GoRoute(
//       path: '/agent-setup',
//       pageBuilder: (BuildContext context, GoRouterState state) {
//         return MaterialPage(
//           key: state.pageKey,
//           child: const AgentSetupScreen(),
//         );
//       },
//       routes: [
//         GoRoute(
//           path: 'agent-onboarding',
//           pageBuilder: (BuildContext context, GoRouterState state) {
//             return MaterialPage(
//               key: state.pageKey,
//               child: const AgentOnBoardingScreen(),
//             );
//           },
//         ),
//         GoRoute(
//           path: 'agent-business-info',
//           pageBuilder: (BuildContext context, GoRouterState state) {
//             return MaterialPage(
//               key: state.pageKey,
//               child: const AgentBusinessInfoScreen(),
//             );
//           },
//         ),

//         GoRoute(
//           path: 'agent-personal-info',
//           pageBuilder: (BuildContext context, GoRouterState state) {
//             return MaterialPage(
//               key: state.pageKey,
//               child: const AgentPersonalInfoScreen(),
//             );
//           },
//         ),
//         GoRoute(
//           path: 'agent-dashboard',
//           pageBuilder: (BuildContext context, GoRouterState state) {
//             return MaterialPage(
//               key: state.pageKey,
//               child: const AgentDashboardScreen(),
//             );
//           },
//         ),

//         GoRoute(
//           path: 'agent-verification',
//           pageBuilder: (BuildContext context, GoRouterState state) {
//             return MaterialPage(
//               key: state.pageKey,
//               child: const AgentVerificationScreen(),
//             );
//           },
//         ),
//         GoRoute(
//           path: 'agent-sidebar',
//           pageBuilder: (BuildContext context, GoRouterState state) {
//             return MaterialPage(
//               key: state.pageKey,
//               child: const AgentSidebarScreen(),
//             );
//           },
//         ),

//         GoRoute(
//           path: 'agent-success-registration',
//           pageBuilder: (BuildContext context, GoRouterState state) {
//             return MaterialPage(
//               key: state.pageKey,
//               child: const AgentSuccessRegistrationScreen(),
//             );
//           },
//         ),
//       ],
//     ),
//   ],
// );
