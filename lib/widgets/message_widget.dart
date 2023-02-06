import '../utils/utils.dart';

class MessageWidget extends StatelessWidget {
  final MessageModel messageModel;
  const MessageWidget({
    super.key,
    required this.messageModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: messageModel.isSender
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(
            left: 12.r,
            right: 12.r,
            top: 12.r,
            bottom: 4.r,
          ),
          constraints: BoxConstraints(
            minWidth: 10,
            maxWidth: MediaQuery.of(context).size.width / 1.6,
          ),
          decoration: BoxDecoration(
            color: Colors.teal.shade200,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                messageModel.message,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      DateFormat('h:mm a').format(
                        messageModel.dateTime,
                      ),
                      style: TextStyle(
                        fontSize: 11.sp,
                      ),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Icon(
                      Icons.done_all,
                      size: 15.r,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 12.h,
        ),
      ],
    );
  }
}
