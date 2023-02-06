part of 'controller.dart';

class HomeView extends StatelessView<HomeScreen, HomeController> {
  const HomeView(HomeController state, {Key? key}) : super(state, key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Lottie.asset(
            'assets/lottie/chat.json',
          ),
          const Spacer(),
          ProceedButton(
            onTap: () => controller.goToChat(),
          ),
          SizedBox(
            height: 30.h,
          ),
        ],
      ),
    );
  }
}
