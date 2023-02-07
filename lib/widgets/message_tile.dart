import '../utils/utils.dart';

class MessageTile extends StatelessWidget {
  final MessageModel message;
  final Function()? onTap;
  const MessageTile({
    Key? key,
    required this.message,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      overlayColor: MaterialStateProperty.resolveWith(
        (states) => Colors.transparent,
      ),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: 12.h,
          top: 12.h,
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 23.r,
              child: const Icon(
                Icons.person,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        message.recipientName ?? 'User ${message.deviceId}',
                      ),
                      Text(
                        DateFormat('h:mm a').format(
                          message.dateTime,
                        ),
                        style: TextStyle(
                          fontSize: 11.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.done_all,
                        size: 15.r,
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Flexible(
                        child: Text(
                          message.message,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageTileShimmer extends StatefulWidget {
  const MessageTileShimmer({super.key});

  @override
  State<MessageTileShimmer> createState() => _MessageTileShimmerState();
}

class _MessageTileShimmerState extends State<MessageTileShimmer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 12.h,
        top: 12.h,
      ),
      child: Row(
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey.shade200,
            highlightColor: Colors.grey.shade400,
            child: CircleAvatar(
              radius: 23.r,
              child: const Icon(
                Icons.person,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade200,
                      highlightColor: Colors.grey.shade400,
                      child: Container(
                        height: 12.h,
                        width: 80.w,
                        color: Colors.grey,
                      ),
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade200,
                      highlightColor: Colors.grey.shade400,
                      child: Text(
                        '',
                        style: TextStyle(
                          fontSize: 11.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8.h,
                ),
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade200,
                  highlightColor: Colors.grey.shade400,
                  child: Container(
                    height: 8.h,
                    width: 150.w,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
