import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WhatsappFloatingIcon extends StatelessWidget {
  final void Function()? onPressed;

  const WhatsappFloatingIcon({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.green.shade300,
      onPressed: onPressed,
      child: const FaIcon(FontAwesomeIcons.whatsapp),
    );
  }
}
