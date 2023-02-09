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
    if (message.isRequest == true) {
      showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.h),
            topRight: Radius.circular(30.h),
          ),
        ),
        builder: (context) => Container(
          height: 150.h,
          padding: EdgeInsets.symmetric(
            horizontal: 30.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const BottomSheetTop(),
              const Spacer(),
              InkWell(
                onTap: () async {
                  Navigator.of(context).pop();
                  await acceptRequest(message);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: Colors.blue,
                      width: 2.r,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 12.h,
                    ),
                    child: const Text(
                      'Accept Request',
                    ),
                  ),
                ),
              ),
              const Spacer()
            ],
          ),
        ),
      );
    } else if (message.isRequest == false) {
      context.pushNamed(
        'conversation',
        extra: message,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    SocketServices.instance.connectAndListen(ref);
    searchController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      ref.watch(lastMessageProvider.notifier).getLastMessage();
    });
  }

  filter() {}

  findUsers() {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.h),
          topRight: Radius.circular(30.h),
        ),
      ),
      context: context,
      builder: (_) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: Column(
            children: [
              const BottomSheetTop(),
              Expanded(
                child: FutureBuilder(
                  future: AuthService().getRequestHandler('users'),
                  builder: (context, AsyncSnapshot<Response> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    } else {
                      if (snapshot.hasData &&
                          snapshot.data != null &&
                          snapshot.data!.statusCode == 200) {
                        final users = snapshot.data!.data['users'] as List;
                        return Column(
                          children: [
                            const Text(
                              'Send a request to initiate conversation',
                              textAlign: TextAlign.center,
                            ),
                            Expanded(
                              child: ListView.separated(
                                itemCount: users.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(
                                      GlobalVariable.socketId ==
                                              users[index]['userID']
                                          ? 'You'
                                          : users[index]['userID'],
                                    ),
                                    onTap: () {
                                      if (GlobalVariable.socketId !=
                                          users[index]['userID']) {
                                        Navigator.of(context).pop();

                                        sendRequest(
                                          users[index]['userID'],
                                          GlobalVariable.socketId!,
                                        );
                                      }
                                    },
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const Divider(),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const Center(
                          child: Text('Erorr'),
                        );
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> sendRequest(
      String receipientSocketId, String senderSocketId) async {
    String senderDeviceId = (await PlatformDeviceId.getDeviceId)!;
    String messageId = 'chat_${DateTime.now().toIso8601String()}';
    String senderName = await LocalStorage.instance.getDisplayName();
    await AuthService().postRequestHandler('initiate', {
      'receipientSocketId': receipientSocketId,
      'senderDeviceId': senderDeviceId,
      'messageId': messageId,
      'senderName': senderName,
      'senderSocketId': senderSocketId,
    });

    final message = MessageModel(
      dateTime: DateTime.now(),
      message: 'Request sent',
      messageId: messageId,
      isRequest: null,
      type: 'send',
      conversationId: 'test-test',
      sortConversationId: 'test-test',
      senderName: 'User $senderDeviceId',
      senderSocketId: senderSocketId,
      senderDeviceId: senderDeviceId,
      recipientName: 'User',
      recipientDeviceId: 'recipientDeviceId',
      recipientSocketId: receipientSocketId, //to do
    );
    ref.read(lastMessageProvider.notifier).showRequest(message);
  }

  Future<void> acceptRequest(MessageModel message) async {
    String senderDeviceId = (await PlatformDeviceId.getDeviceId)!;
    String messageId = 'chat_${DateTime.now().toIso8601String()}';
    String senderName = await LocalStorage.instance.getDisplayName();
    await AuthService().postRequestHandler('accept', {
      'receipientSocketId': message.senderSocketId,
      'senderDeviceId': senderDeviceId,
      'messageId': messageId,
      'senderName': senderName,
      'senderSocketId': GlobalVariable.socketId,
    });
    final conv = message.conversationId.split('-').reversed.toList();
    final sort = conv.toList();
    await ref.read(lastMessageProvider.notifier).getLastMessage();
    final messsage = MessageModel(
      dateTime: message.dateTime,
      message: 'Request Accepted!',
      messageId: messageId,
      type: 'send',
      conversationId: conv.join('-'),
      sortConversationId: sort.join('-'),
      senderName: 'User $senderDeviceId',
      senderSocketId: message.senderSocketId,
      senderDeviceId: senderDeviceId,
      recipientName: message.senderName,
      recipientDeviceId: message.senderDeviceId,
      recipientSocketId: message.senderSocketId,
    );
    ref.read(lastMessageProvider.notifier).showRequest(messsage);
  }

  @override
  Widget build(BuildContext context) {
    return MainView(this);
  }
}
