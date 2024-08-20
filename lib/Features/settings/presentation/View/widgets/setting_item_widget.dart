import 'package:car_rentting/core/functions/responsive.dart';
import 'package:car_rentting/core/utils/colors.dart';

class SettingsItem extends StatelessWidget {
  const SettingsItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.color,
  });

  final String title;
  final IconData icon;
  final Color? color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          height: 50,
          decoration: BoxDecoration(
              color: AppColors.primaryColor4,
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
              border: Border.all(color: Colors.grey.withOpacity(0.4)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0.5,
                )
              ]),
          child: Row(
            children: [
              Icon(
                icon,
                color: color ?? AppColors.primaryColor2,
              ),
              const SizedBox(width: 20),
              Text(title),
            ],
          )),
    );
  }
}
