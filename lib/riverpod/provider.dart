import '../utils/utils.dart';
import 'notifier.dart';

final messageProvider =
    StateNotifierProvider<MessageNotifierProvider, List<MessageModel>>(
  (_) => MessageNotifierProvider([]),
);

final lastMessageProvider =
    StateNotifierProvider<LastMessageNotifierProvider, List<MessageModel>>(
  (_) => LastMessageNotifierProvider([]),
);

final lastMessageAsyncProvider =
    FutureProvider((_) => LocalChatHistory.instance.getLastMessageList());

final lastMessageSearchTextProvider = StateProvider((_) => '');
final lastMessageSearchList = StateProvider<List<MessageModel>>((_) => []);

final lastMessageSearchListProvider = StateProvider((ref) {
  final searchText = ref.watch(lastMessageSearchTextProvider);
  final searchList = ref.watch(lastMessageSearchList);
  List<MessageModel> searchResult = [];

  if (searchText.isEmpty) {
    searchResult = searchList;
  } else {
    searchList.where(
      (element) =>
          element.message.toLowerCase().contains(searchText.toLowerCase()),
    );
  }
  return searchResult;
});
