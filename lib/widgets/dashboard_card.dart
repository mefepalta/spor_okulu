import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Dashboard'daki dokunulabilir kart.
///
/// Mavi dalga zeminle çakışmaması için nötr gri gradyanlı; ikon marka
/// mavisiyle küçük bir "rozet" içinde durur. Aydınlık/karanlık moda uyar.
class DashboardCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const DashboardCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final gradient = isDark
        ? AppColors.cardGradientDark
        : AppColors.cardGradientLight;
    final borderColor = isDark
        ? Colors.white.withValues(alpha: 0.06)
        : AppColors.cardBorderLight;
    final badgeColor = isDark
        ? AppColors.primary.withValues(alpha: 0.22)
        : AppColors.cardBadgeLight;
    final iconColor = isDark ? AppColors.sky : AppColors.primary;
    final subtitleColor = isDark ? Colors.white70 : Colors.grey.shade600;
    final shadowColor = isDark
        ? Colors.black.withValues(alpha: 0.40)
        : const Color(0xFF1A2542).withValues(alpha: 0.20);

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradient,
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 22,
            offset: const Offset(0, 9),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: badgeColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 28, color: iconColor),
                ),
                const SizedBox(height: 12),
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      title,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: subtitleColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
