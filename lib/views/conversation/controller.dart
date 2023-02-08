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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
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
    String senderDeviceId = (await PlatformDeviceId.getDeviceId)!;
    List<String> conversationIds = [
      senderDeviceId,
      widget.messageInfo.recipientDeviceId
    ];
    final conversationId = conversationIds.join('-');
    String messageId = 'chat_${DateTime.now().toIso8601String()}';
    List<String> sortConversationId = conversationIds.toList();
    sortConversationId.sort();
    await ref.read(messageProvider.notifier).addMessage(
          MessageModel(
            dateTime: DateTime.now(),
            message: messageController.text.trim(),
            senderDeviceId: senderDeviceId,
            recipientDeviceId: widget.messageInfo.recipientDeviceId,
            sortConversationId: sortConversationId.join('-'),
            messageId: messageId,
            senderName: 'User $senderDeviceId',
            recipientName: 'User ${widget.messageInfo.recipientDeviceId}',
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
