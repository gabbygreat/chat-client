part of 'controller.dart';

class MainView extends StatelessView<MainScreen, MvcController> {
  const MainView(MvcController state, {Key? key}) : super(state, key: key);

  @override
  Widget build(BuildContext context) {
    final lastMessage = controller.ref.watch(lastMessageProvider);
    final lastAsyncMessage = controller.ref.watch(lastMessageAsyncProvider);
    return Scaffold(
      appBar: const CustomAppBar(),
      backgroundColor: scaffoldBg,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Chats',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 25.sp,
                  ),
                ),
                IconButton(
                  onPressed: () => controller.findUsers(),
                  icon: const Icon(
                    Icons.maps_ugc,
                  ),
                )
              ],
            ),
            CustomTextInput(
              hintText: 'Search for chats & messages',
              onChanged: (value) => controller.filter(),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 8.h,
              ),
              readOnly: true,
            ),
            Expanded(
              child: lastAsyncMessage.when(
                data: (data) => lastMessage.isNotEmpty
                    ? ListView.builder(
                        padding: EdgeInsets.only(
                          top: 25.h,
                          bottom: 25.h,
                        ),
                        itemCount: lastMessage.length,
                        itemBuilder: (context, index) => MessageTile(
                          message: lastMessage[index],
                          onTap: () => controller.openMessage(
                            lastMessage[index],
                          ),
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Spacer(
                            flex: 2,
                          ),
                          SvgPicture.asset(
                            'assets/svg/chat.svg',
                            width: 100.h,
                            height: 200.h,
                          ),
                          const Spacer(
                            flex: 1,
                          ),
                          Text(
                            'No chats found',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20.sp,
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: Text(
                              'When you are ready, tap on the icon below to chat someone',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15.sp,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => controller.findUsers(),
                            child: Lottie.asset('assets/lottie/add.json',
                                width: 100.h, height: 100.h),
                          ),
                          const Spacer(
                            flex: 1,
                          ),
                        ],
                      ),
                error: (error, trace) => const Text('ERROR'),
                loading: () => ListView.builder(
                  itemCount: 15,
                  itemBuilder: (context, index) => const MessageTileShimmer(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
