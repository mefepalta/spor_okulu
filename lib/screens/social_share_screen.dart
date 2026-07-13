import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';

import '../l10n/app_localizations.dart';
import '../theme/app_colors.dart';
import '../widgets/wave_background.dart';

/// Sosyal medya paylaşımı: kullanıcı foto + metin hazırlar, "Paylaş" ile
/// cihazın paylaş menüsü açılır (Instagram/WhatsApp vb.'ye elle gönderir).
/// Uygulama içinde gönderi saklanmaz — yalnızca dışarı paylaşım köprüsü.
class SocialShareScreen extends StatefulWidget {
  const SocialShareScreen({super.key});

  @override
  State<SocialShareScreen> createState() => _SocialShareScreenState();
}

class _SocialShareScreenState extends State<SocialShareScreen> {
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _textController = TextEditingController();

  XFile? _photo;
  bool _sharing = false;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _pickPhoto() async {
    try {
      final picked = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1440,
        maxHeight: 1440,
        imageQuality: 85,
      );
      if (picked == null || !mounted) {
        return;
      }
      setState(() => _photo = picked);
    } catch (error) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).photoPickError(error))),
      );
    }
  }

  Future<void> _share() async {
    final l10n = AppLocalizations.of(context);
    final text = _textController.text.trim();
    final photo = _photo;

    if (text.isEmpty && photo == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.socialEmptyWarning)),
      );
      return;
    }

    setState(() => _sharing = true);
    try {
      await SharePlus.instance.share(
        ShareParams(
          text: text.isEmpty ? null : text,
          files: photo != null ? [photo] : null,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _sharing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return WaveScaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.share, size: 20),
            const SizedBox(width: 8),
            Text(l10n.socialTitle),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            l10n.socialCreatePost.toUpperCase(),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.6,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 12),
          _buildPhotoArea(l10n),
          const SizedBox(height: 12),
          TextField(
            controller: _textController,
            minLines: 3,
            maxLines: 6,
            maxLength: 1000,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              hintText: l10n.socialHint,
              border: const OutlineInputBorder(),
              alignLabelWithHint: true,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: _sharing ? null : _share,
              icon: _sharing
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.send),
              label: Text(l10n.socialShareButton),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoArea(AppLocalizations l10n) {
    final photo = _photo;
    if (photo == null) {
      return InkWell(
        onTap: _pickPhoto,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.4),
              width: 1.4,
            ),
            color: AppColors.primary.withValues(alpha: 0.05),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.add_photo_alternate_outlined,
                  size: 40, color: AppColors.primary),
              const SizedBox(height: 8),
              Text(
                l10n.socialAddPhoto,
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        children: [
          Image.file(
            File(photo.path),
            width: double.infinity,
            height: 220,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 8,
            right: 8,
            child: Material(
              color: Colors.black54,
              shape: const CircleBorder(),
              child: IconButton(
                tooltip: l10n.socialRemovePhoto,
                icon: const Icon(Icons.close, color: Colors.white, size: 20),
                onPressed: () => setState(() => _photo = null),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
