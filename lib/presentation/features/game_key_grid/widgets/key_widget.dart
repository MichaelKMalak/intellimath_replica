import 'package:intellimath_replica/presentation/core_flutter_packages.dart';

class KeyWidget extends StatelessWidget {
  final String text;
  final bool isPressed;
  final VoidCallback onPressed;

  const KeyWidget({
    Key? key,
    required this.text,
    required this.isPressed,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: isPressed
            ? getPressedContainer(textTheme)
            : getUnPressedContainer(textTheme),
      ),
    );
  }

  Widget getPressedContainer(TextTheme textTheme) {
    return Container(
      margin: const EdgeInsets.only(top: 1, left: 1, right: 1, bottom: 8),
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(5),
          topLeft: Radius.circular(5),
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: textTheme.headline6,
        ),
      ),
    );
  }

  Widget getUnPressedContainer(TextTheme textTheme) {
    return Center(
      child: Text(
        text,
        style: textTheme.headline6?.copyWith(color: Colors.black),
      ),
    );
  }
}
