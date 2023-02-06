import '../../utils/utils.dart';

part 'view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeController();
}

class HomeController extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    SocketServices.instance.connectAndListen();
  }

  @override
  Widget build(BuildContext context) {
    return HomeView(this);
  }
}
