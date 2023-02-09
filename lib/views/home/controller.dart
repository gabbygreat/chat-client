import 'package:chat/widgets/proceed_button.dart';

import '../../utils/utils.dart';

part 'view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeController();
}

class HomeController extends State<HomeScreen> {
  goToChat() => context.pushNamed(
        'main',
      );

  @override
  Widget build(BuildContext context) {
    return HomeView(this);
  }
}
