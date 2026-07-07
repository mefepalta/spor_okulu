import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../models/app_models.dart';
import '../services/profile_service.dart';
import '../theme/app_colors.dart';
import '../widgets/wave_background.dart';

/// Kullanıcının kendi adını, telefonunu ve profil fotoğrafını düzenlediği ekran.
///
/// Fotoğraf galeriden seçilir, küçültülüp sıkıştırılarak base64 olarak
/// kaydedilir; ekstra depolama servisi gerekmez. Kaydedince güncel [UserProfile]
/// çağırana döndürülür.
class EditAccountScreen extends StatefulWidget {
  final UserProfile profile;

  const EditAccountScreen({super.key, required this.profile});

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final ProfileService _profileService = ProfileService();
  final ImagePicker _picker = ImagePicker();

  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;

  late String _photoBase64;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.profile.displayName);
    _phoneController = TextEditingController(text: widget.profile.phone);
    _photoBase64 = widget.profile.photoBase64;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _pickPhoto() async {
    try {
      // Avatar için küçük boyut + sıkıştırma: belge küçük kalır, base64 hafif.
      final picked = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 256,
        maxHeight: 256,
        imageQuality: 60,
      );

      if (picked == null) {
        return;
      }

      final bytes = await picked.readAsBytes();

      if (!mounted) {
        return;
      }

      setState(() {
        _photoBase64 = base64Encode(bytes);
      });
    } catch (error) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Fotoğraf seçilemedi: $error')),
      );
    }
  }

  void _removePhoto() {
    setState(() {
      _photoBase64 = '';
    });
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      await _profileService.updateMyProfile(
        displayName: _nameController.text.trim(),
        phone: _phoneController.text.trim(),
        photoBase64: _photoBase64,
      );

      if (!mounted) {
        return;
      }

      final updated = widget.profile.copyWith(
        displayName: _nameController.text.trim(),
        phone: _phoneController.text.trim(),
        photoBase64: _photoBase64,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profil güncellendi.')),
      );

      Navigator.pop(context, updated);
    } catch (error) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kaydedilemedi: $error')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final avatarImage = _photoBase64.isNotEmpty
        ? MemoryImage(base64Decode(_photoBase64))
        : null;

    return WaveScaffold(
      appBar: AppBar(title: const Text('Hesabı Düzenle')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 52,
                  backgroundColor: AppColors.primary.withValues(alpha: 0.12),
                  backgroundImage: avatarImage,
                  child: avatarImage == null
                      ? const Icon(
                          Icons.person,
                          size: 52,
                          color: AppColors.primary,
                        )
                      : null,
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Material(
                    color: AppColors.primary,
                    shape: const CircleBorder(),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: _pickPhoto,
                      child: const Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(
                          Icons.photo_camera,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: TextButton.icon(
              onPressed: _pickPhoto,
              icon: const Icon(Icons.image),
              label: const Text('Fotoğraf seç'),
            ),
          ),
          if (_photoBase64.isNotEmpty)
            Center(
              child: TextButton.icon(
                onPressed: _removePhoto,
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                label: const Text(
                  'Fotoğrafı kaldır',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
          const SizedBox(height: 12),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    labelText: 'Ad Soyad',
                    prefixIcon: Icon(Icons.person_outline),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value != null && value.trim().length > 60) {
                      return 'Ad çok uzun.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Telefon',
                    hintText: '(5xx) xxx xx xx',
                    prefixIcon: Icon(Icons.phone_outlined),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value != null && value.trim().length > 20) {
                      return 'Telefon çok uzun.';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: _isSaving ? null : _save,
            icon: _isSaving
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.save),
            label: Text(_isSaving ? 'Kaydediliyor...' : 'Kaydet'),
          ),
        ],
      ),
    );
  }
}
