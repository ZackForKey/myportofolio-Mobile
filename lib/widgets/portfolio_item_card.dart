import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/palette.dart';

class ItemHomepage {
  final String name;
  final IconData icon;
  final Color color;

  const ItemHomepage({
    required this.name,
    required this.icon,
    required this.color,
  });
}

class ItemCard extends StatelessWidget {
  final ItemHomepage item;
  final VoidCallback? onTap;

  const ItemCard(this.item, {super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    final foreground = _contrastingTextColor(item.color);

    return Material(
      color: item.color,
      borderRadius: BorderRadius.circular(20),
      elevation: 2,
      shadowColor: PiratePalette.deepNavy.withValues(alpha: 0.16),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap ?? () => _showSnackBar(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: foreground.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(item.icon, color: foreground, size: 25),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: foreground,
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Pilih untuk melanjutkan',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: foreground,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.arrow_forward_rounded, color: foreground, size: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('Kamu telah menekan tombol ${item.name}!'),
          backgroundColor: PiratePalette.deepNavy,
          behavior: SnackBarBehavior.floating,
        ),
      );
  }
}

Color _contrastingTextColor(Color backgroundColor) {
  const light = Colors.white;
  const dark = PiratePalette.deepNavy;
  final backgroundLuminance = backgroundColor.computeLuminance();
  final lightContrast = 1.05 / (backgroundLuminance + 0.05);
  final darkContrast =
      (backgroundLuminance + 0.05) / (dark.computeLuminance() + 0.05);

  return darkContrast >= lightContrast ? dark : light;
}
