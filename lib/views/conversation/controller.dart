import 'package:chat/riverpod/provider.dart';
import 'package:chat/widgets/message_widget.dart';

import '../../utils/utils.dart';

part 'view.dart';

class ConversationScreen extends ConsumerStatefulWidget {
  final MessageModel messageInfo;
  const ConversationScreen({
    Key? key,
    required this.messageInfo,
  }) : super(key: key);

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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        ref.read(messageProvider.notifier).getMessages(widget.messageInfo);
      }
    });
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  void sendMessage() async {
    FocusScope.of(context).unfocus();
    String deviceId = (await PlatformDeviceId.getDeviceId)!;
    List<String> conversationIds = [deviceId, widget.messageInfo.deviceId];
    String? displayName = await LocalStorage.instance.getDisplayName();
    final conversationId = conversationIds.join('-');
    await ref.read(messageProvider.notifier).addMessage(
          MessageModel(
            dateTime: DateTime.now(),
            message: messageController.text.trim(),
            deviceId: deviceId,
            displayName: displayName,
            conversationId: conversationId,
          ),
        );
    await ref.read(lastMessageProvider.notifier).getLastMessage();
    messageController.clear();
  }

  void rebuild() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return ConversationView(this);
  }
}
