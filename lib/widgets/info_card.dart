import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/palette.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String content;
  final IconData icon;

  const InfoCard({
    super.key,
    required this.title,
    required this.content,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: PiratePalette.softPaper,
      elevation: 1,
      shadowColor: PiratePalette.deepNavy.withValues(alpha: 0.08),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: PiratePalette.treasureGold.withValues(alpha: 0.55),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 11),
        child: Column(
          children: [
            Icon(icon, color: PiratePalette.oceanBlue, size: 18),
            const SizedBox(height: 5),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: PiratePalette.darkBrown,
                fontSize: 9,
                fontWeight: FontWeight.w800,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              content,
              textAlign: TextAlign.center,
              maxLines: 2,
              softWrap: true,
              overflow: TextOverflow.visible,
              style: const TextStyle(
                color: PiratePalette.deepNavy,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                height: 1.15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
