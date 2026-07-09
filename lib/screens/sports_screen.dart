import 'package:flutter/material.dart';

import '../data/sports_data.dart';
import '../l10n/app_localizations.dart';
import '../widgets/wave_background.dart';
import 'sport_detail_screen.dart';

/// Velileri (ve herkesi) bilgilendiren spor kataloğu ekranı.
///
/// Her spor bir kart olarak listelenir; dokununca tanıtım videosu ve
/// açıklamaların olduğu [SportDetailScreen] açılır.
class SportsScreen extends StatelessWidget {
  const SportsScreen({super.key});

  void _openDetail(BuildContext context, Sport sport) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SportDetailScreen(sport: sport)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WaveScaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context).navSports)),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: sportsCatalog.length,
        itemBuilder: (context, index) {
          final sport = sportsCatalog[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              leading: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: sport.color.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(sport.icon, color: sport.color, size: 26),
              ),
              title: Text(
                sport.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(sport.tagline),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _openDetail(context, sport),
            ),
          );
        },
      ),
    );
  }
}
