part of 'controller.dart';

class ConversationView
    extends StatelessView<ConversationScreen, ConversationController> {
  const ConversationView(ConversationController state, {Key? key})
      : super(state, key: key);

  Widget topBar() => Container(
        height: 80.h,
        padding: EdgeInsets.only(
          left: 15.w,
          right: 15.w,
          bottom: 10.h,
        ),
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            InkWell(
              onTap: () => controller.context.pop(),
              overlayColor: MaterialStateProperty.resolveWith(
                (states) => Colors.transparent,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.arrow_back_ios),
                  CircleAvatar(
                    radius: 20.r,
                    child: const Icon(
                      Icons.person,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Roseline Ejiofor'),
                  Text('online'),
                ],
              ),
            ),
            const Icon(
              Icons.phone_outlined,
            ),
            SizedBox(
              width: 15.w,
            ),
            const Icon(
              Icons.search,
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final message = controller.ref.watch(messageProvider);
    return Scaffold(
      backgroundColor: scaffoldBg,
      bottomSheet: Container(
        height: 90.h,
        width: double.maxFinite,
        color: Colors.white,
        alignment: Alignment.center,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.attachment,
              ),
            ),
            Expanded(
              child: CustomTextInput(
                controller: controller.messageController,
                minLines: 1,
                maxLines: 3,
                onChanged: (value) => controller.rebuild(),
                keyboardType: TextInputType.multiline,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10.h,
                  horizontal: 15.w,
                ),
                border: 30.r,
              ),
            ),
            if (controller.messageController.text.trim().isNotEmpty)
              IconButton(
                onPressed: () => controller.sendMessage(),
                icon: const Icon(
                  Icons.send,
                ),
              )
            else
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.mic,
                ),
              ),
          ],
        ),
      ),
      body: Column(
        children: [
          topBar(),
          Expanded(
            child: Stack(
              children: [
                ListView.builder(
                  reverse: true,
                  controller: controller.listController,
                  padding: EdgeInsets.only(
                    top: 10.h,
                    left: 20.w,
                    right: 20.w,
                  ),
                  itemCount: message.length,
                  itemBuilder: (context, index) => MessageWidget(
                    messageModel: message.reversed.toList()[index],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: AnimatedContainer(
                    width: controller.visible ? 50.r : 0,
                    height: controller.visible ? 50.r : 0,
                    duration: const Duration(
                      seconds: 1,
                    ),
                    child: GestureDetector(
                      onTap: () => controller.listController.animateTo(
                        0,
                        duration: const Duration(milliseconds: 100),
                        curve: Curves.easeIn,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 15.r,
                          child: const Center(
                            child: Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 90.h,
          ),
        ],
      ),
    );
  }
}
