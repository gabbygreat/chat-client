import 'package:chat/riverpod/provider.dart';
import 'package:chat/widgets/message_widget.dart';

import '../../utils/utils.dart';

part 'view.dart';

class ConversationScreen extends ConsumerStatefulWidget {
  const ConversationScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConversationScreen> createState() => ConversationController();
}

class ConversationController extends ConsumerState<ConversationScreen> {
  late TextEditingController messageController;
  late ScrollController listController;
  bool visible = false;

  @override
  void initState() {
    super.initState();
    messageController = TextEditingController();
    listController = ScrollController();

    listController.addListener(() {
      if (listController.offset > 0) {
        setState(() {
          visible = true;
        });
      } else {
        setState(() {
          visible = false;
        });
      }
    });
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  void sendMessage() {
    ref.read(messageProvider.notifier).addMessage(
          MessageModel(
            dateTime: DateTime.now(),
            message: messageController.text,
            isSender: true,
          ),
        );
    messageController.clear();
    FocusScope.of(context).unfocus();
  }

  void rebuild() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return ConversationView(this);
  }
}
