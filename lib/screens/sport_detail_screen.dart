import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/sports_data.dart';
import '../l10n/app_localizations.dart';
import '../widgets/wave_background.dart';

/// Bir sporun tanıtım videosu ve açıklamalarını gösteren ekran.
///
/// Video, cihazın YouTube/tarayıcı uygulamasında dışarıda açılır. [Sport.videoUrl]
/// boşsa ilgili sporu YouTube'da arayan bir bağlantı açılır.
class SportDetailScreen extends StatelessWidget {
  final Sport sport;

  const SportDetailScreen({super.key, required this.sport});

  Future<void> _openVideo(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final url = sport.videoUrl.isNotEmpty
        ? sport.videoUrl
        : 'https://www.youtube.com/results?search_query='
              '${Uri.encodeComponent('${sport.name} ${l10n.youtubeHowToPlay}')}';

    try {
      final launched = await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      );
      if (!launched && context.mounted) {
        _showError(context);
      }
    } catch (_) {
      if (context.mounted) {
        _showError(context);
      }
    }
  }

  void _showError(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context).videoOpenError)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final sectionTitleColor = Theme.of(context).colorScheme.primary;

    return WaveScaffold(
      appBar: AppBar(title: Text(sport.name)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _VideoCover(sport: sport, onTap: () => _openVideo(context)),
          const SizedBox(height: 16),
          for (final section in sport.sections) ...[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      section.title,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: sectionTitleColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    for (final item in section.items)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 7, right: 8),
                              child: Icon(
                                Icons.circle,
                                size: 6,
                                color: sport.color,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 15,
                                  height: 1.45,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}

/// Dokununca videoyu dışarıda açan renkli kapak.
class _VideoCover extends StatelessWidget {
  final Sport sport;
  final VoidCallback onTap;

  const _VideoCover({required this.sport, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Ink(
            height: 190,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  sport.color,
                  Color.alphaBlend(Colors.black26, sport.color),
                ],
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  right: -10,
                  bottom: -10,
                  child: Icon(
                    sport.icon,
                    size: 130,
                    color: Colors.white.withValues(alpha: 0.15),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.22),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.play_arrow,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        AppLocalizations.of(context).watchIntroVideo,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
