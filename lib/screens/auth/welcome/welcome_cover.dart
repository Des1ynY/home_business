part of 'welcome.dart';

class WelcomeCover extends StatelessWidget {
  const WelcomeCover({
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.color,
    required this.index,
    Key? key,
  }) : super(key: key);

  final String title, subtitle, imagePath;
  final Color color;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomTheme.backgroundColor,
      padding: getSafeAreaPadding(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 260,
            margin: const EdgeInsets.only(top: 40),
            child: Image.asset(imagePath),
          ),
          Container(
            height: 130,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: Get.textTheme.headline2,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      subtitle,
                      style: Get.textTheme.subtitle1,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _getIndicator(0),
                    _getIndicator(1),
                    _getIndicator(2),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 270,
            width: Get.width,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.elliptical(150, 20),
                topRight: Radius.elliptical(150, 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getIndicator(int pos) {
    return Container(
      width: 8,
      height: 8,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: index == pos ? Colors.black : const Color(0xFF979797),
      ),
    );
  }
}
