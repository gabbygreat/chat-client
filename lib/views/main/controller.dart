import 'package:chat/riverpod/provider.dart';

import '../../utils/utils.dart';
part 'view.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MainScreen> createState() => MvcController();
}

class MvcController extends ConsumerState<MainScreen> {
  late TextEditingController searchController;
  void openMessage(MessageModel message) {
    context.pushNamed(
      'conversation',
      extra: message,
    );
  }

  @override
  void initState() {
    super.initState();
    SocketServices.instance.connectAndListen(ref);
    searchController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.watch(lastMessageProvider.notifier).getLastMessage();
    });
  }

  filter() {}

  @override
  Widget build(BuildContext context) {
    return MainView(this);
  }
}
