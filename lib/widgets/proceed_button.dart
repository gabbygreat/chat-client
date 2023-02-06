import '../utils/utils.dart';

class ProceedButton extends StatefulWidget {
  final Function() onTap;
  const ProceedButton({super.key, required this.onTap});

  @override
  State<ProceedButton> createState() => _ProceedButtonState();
}

class _ProceedButtonState extends State<ProceedButton>
    with TickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )
      ..forward()
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: animationController,
          builder: (context, child) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.blue.shade400,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(
                  8.0 * animationController.value,
                ),
                child: child,
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r)),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 80.w,
                vertical: 15.h,
              ),
              child: const Text('Proceed'),
            ),
          ),
        ),
      ),
    );
  }
}
