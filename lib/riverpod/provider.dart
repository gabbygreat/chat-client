import '../utils/utils.dart';
import 'notifier.dart';

final messageProvider =
    StateNotifierProvider<MessageNotifierProvider, List<MessageModel>>(
  (_) => MessageNotifierProvider(
    [
      MessageModel(
        dateTime: DateTime.now(),
        message: 'Hi',
        isSender: false,
      ),
      MessageModel(
        dateTime: DateTime.now(),
        message: 'Hello',
        isSender: true,
      ),
      MessageModel(
        dateTime: DateTime.now(),
        message: 'How body?',
        isSender: false,
      ),
      MessageModel(
        dateTime: DateTime.now(),
        message: 'I dey oo',
        isSender: true,
      ),
      MessageModel(
        dateTime: DateTime.now(),
        message: 'Are you working',
        isSender: false,
      ),
      MessageModel(
        dateTime: DateTime.now(),
        message: 'Yh.\n What are you doing?',
        isSender: true,
      ),
      MessageModel(
        dateTime: DateTime.now(),
        message: 'Nothing much, just thinking about you...',
        isSender: false,
      ),
      MessageModel(
        dateTime: DateTime.now(),
        message: 'Lol. We\'ll see na.',
        isSender: true,
      ),
      MessageModel(
        dateTime: DateTime.now(),
        message: 'What time are you coming?',
        isSender: false,
      ),
      MessageModel(
        dateTime: DateTime.now(),
        message: 'Around 2pm',
        isSender: true,
      ),
      MessageModel(
        dateTime: DateTime.now(),
        message: 'After I finish submitting',
        isSender: true,
      ),
    ],
  ),
);
