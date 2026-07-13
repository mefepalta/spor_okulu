import 'dart:convert';

import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../models/app_models.dart';
import '../services/chat_service.dart';
import '../services/profile_service.dart';
import '../theme/app_colors.dart';
import '../utils/streak.dart';
import '../widgets/empty_state.dart';
import '../widgets/wave_background.dart';

/// Kulüp genel sohbeti — tek oda, tüm onaylı üyeler yazar.
///
/// Mesajlar gerçek zamanlı akar (StreamBuilder). Her mesajda gönderenin
/// avatarı, ad-soyadı ve tarih-saati gösterilir. Avatarlar
/// `users/{uid}.photoBase64`'ten gönderen başına bir kez okunup önbelleğe
/// alınır ([_avatarCache]); bu ücretsiz Firestore kotasını korur.
class ClubChatScreen extends StatefulWidget {
  /// Giriş yapan kullanıcının güncel günlük giriş serisi — gönderilen mesaja
  /// denormalize edilir (isim rengi/rozeti için).
  final int currentUserStreak;

  const ClubChatScreen({super.key, this.currentUserStreak = 0});

  @override
  State<ClubChatScreen> createState() => _ClubChatScreenState();
}

class _ClubChatScreenState extends State<ClubChatScreen> {
  final ChatService _chatService = ChatService();
  final ProfileService _profileService = ProfileService();
  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  /// Gönderen uid → avatar (base64). Değer boş dizi ise "çözüldü ama foto yok".
  final Map<String, String> _avatarCache = {};

  /// Avatarı istenmiş (uçuşta ya da çözülmüş) uid'ler — tekrar okumayı önler.
  final Set<String> _avatarRequested = {};

  String _myName = '';
  bool _isAdmin = false;
  bool _sending = false;
  int _lastCount = 0;

  @override
  void initState() {
    super.initState();
    _loadMyProfile();
  }

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadMyProfile() async {
    final profile = await _profileService.loadMyProfile();
    if (!mounted || profile == null) {
      return;
    }
    setState(() {
      _myName = profile.displayName.trim().isNotEmpty
          ? profile.displayName.trim()
          : profile.email.split('@').first;
      _isAdmin = profile.role == 'admin';
      // Kendi avatarımızı önbelleğe ekle (ekstra okuma yok).
      final uid = _chatService.currentUid;
      if (uid != null) {
        _avatarRequested.add(uid);
        _avatarCache[uid] = profile.photoBase64;
      }
    });
  }

  /// [uid] için avatar önbellekte yoksa bir kez okur (build sırasında güvenli;
  /// setState await'ten sonra çalışır).
  void _ensureAvatar(String uid) {
    if (uid.isEmpty || _avatarRequested.contains(uid)) {
      return;
    }
    _avatarRequested.add(uid);
    _chatService.fetchAvatar(uid).then((base64) {
      if (!mounted) {
        return;
      }
      setState(() => _avatarCache[uid] = base64);
    });
  }

  Future<void> _send() async {
    final text = _inputController.text.trim();
    if (text.isEmpty || _sending || _myName.isEmpty) {
      return;
    }
    setState(() => _sending = true);
    _inputController.clear();
    try {
      await _chatService.sendMessage(
        senderName: _myName,
        text: text,
        senderStreak: widget.currentUserStreak,
      );
    } finally {
      if (mounted) {
        setState(() => _sending = false);
      }
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return WaveScaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.forum, size: 20),
            const SizedBox(width: 8),
            Text(l10n.chatTitle),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<ChatMessage>>(
              stream: _chatService.watchMessages(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return EmptyState(
                    icon: Icons.error_outline,
                    title: l10n.chatTitle,
                    message: l10n.chatLoadError,
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting &&
                    !snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final messages = snapshot.data ?? const [];
                if (messages.isEmpty) {
                  return EmptyState(
                    icon: Icons.forum_outlined,
                    title: l10n.chatEmptyTitle,
                    message: l10n.chatEmptyBody,
                  );
                }
                // Yeni mesaj geldiyse en alta kaydır.
                if (messages.length != _lastCount) {
                  _lastCount = messages.length;
                  _scrollToBottom();
                }
                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: messages.length,
                  itemBuilder: (context, index) =>
                      _buildMessage(context, l10n, messages[index]),
                );
              },
            ),
          ),
          _buildComposer(context, l10n),
        ],
      ),
    );
  }

  Widget _buildMessage(
    BuildContext context,
    AppLocalizations l10n,
    ChatMessage message,
  ) {
    final isMine = message.senderId == _chatService.currentUid;
    _ensureAvatar(message.senderId);
    final avatar = _buildAvatar(message);

    final bubble = Flexible(
      child: Column(
        crossAxisAlignment: isMine
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 4, end: 4, bottom: 3),
            child: _buildMessageHeader(context, l10n, message),
          ),
          GestureDetector(
            onLongPress: () => _showMessageActions(l10n, message, isMine),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.68,
              ),
              decoration: BoxDecoration(
                color: isMine ? AppColors.primary : Theme.of(context).cardColor,
                borderRadius: BorderRadiusDirectional.only(
                  topStart: const Radius.circular(14),
                  topEnd: const Radius.circular(14),
                  bottomStart: Radius.circular(isMine ? 14 : 2),
                  bottomEnd: Radius.circular(isMine ? 2 : 14),
                ),
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  color: isMine ? Colors.white : null,
                  height: 1.35,
                ),
              ),
            ),
          ),
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment:
            isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: isMine
            ? [bubble, const SizedBox(width: 8), avatar]
            : [avatar, const SizedBox(width: 8), bubble],
      ),
    );
  }

  /// Mesaj üst bilgisi: gönderen adı (streak tier'ına göre renkli + alev
  /// rozeti) · tarih-saat · düzenlendi. Ad muted renk yerine tier rengiyle
  /// gösterilir; böylece ödül (seri) chat'te de görünür.
  Widget _buildMessageHeader(
    BuildContext context,
    AppLocalizations l10n,
    ChatMessage message,
  ) {
    final muted = Theme.of(context).textTheme.bodySmall?.color;
    final style = streakStyle(message.senderStreak);
    final nameColor = style.color ?? muted;
    final meta = ' · ${_formatTime(message.createdAt)}'
        '${message.editedAt != null ? ' · ${l10n.chatEdited}' : ''}';

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (style.showBadge) ...[
          Icon(Icons.local_fire_department, size: 12, color: nameColor),
          const SizedBox(width: 3),
        ],
        Flexible(
          child: Text(
            message.senderName.isEmpty ? '—' : message.senderName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11,
              fontWeight: style.showBadge ? FontWeight.w700 : FontWeight.w600,
              color: nameColor,
            ),
          ),
        ),
        Text(
          meta,
          style: TextStyle(fontSize: 11, color: muted),
        ),
      ],
    );
  }

  /// Mesaja uzun basınca: kendi mesajında Düzenle+Sil; başkasının mesajında
  /// yalnızca admin için Sil. Yetki yoksa menü açılmaz.
  Future<void> _showMessageActions(
    AppLocalizations l10n,
    ChatMessage message,
    bool isMine,
  ) async {
    final canEdit = isMine;
    final canDelete = isMine || _isAdmin;
    if (!canEdit && !canDelete) {
      return;
    }
    await showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (canEdit)
              ListTile(
                leading: const Icon(Icons.edit_outlined),
                title: Text(l10n.commonEdit),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _editMessage(l10n, message);
                },
              ),
            if (canDelete)
              ListTile(
                leading: const Icon(Icons.delete_outline, color: Colors.red),
                title: Text(
                  l10n.commonDelete,
                  style: const TextStyle(color: Colors.red),
                ),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _confirmDelete(l10n, message);
                },
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _editMessage(AppLocalizations l10n, ChatMessage message) async {
    final newText = await showDialog<String>(
      context: context,
      builder: (dialogContext) => _EditMessageDialog(
        title: l10n.chatEditTitle,
        initialText: message.text,
        cancelLabel: l10n.commonCancel,
        saveLabel: l10n.commonSave,
      ),
    );
    if (newText == null || newText.isEmpty || newText == message.text) {
      return;
    }
    await _chatService.editMessage(id: message.id, text: newText);
  }

  Future<void> _confirmDelete(AppLocalizations l10n, ChatMessage message) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.chatDeleteTitle),
        content: Text(l10n.chatDeleteConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(l10n.commonCancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(l10n.commonDelete),
          ),
        ],
      ),
    );
    if (confirmed != true) {
      return;
    }
    await _chatService.deleteMessage(message.id);
  }

  Widget _buildAvatar(ChatMessage message) {
    final base64 = _avatarCache[message.senderId] ?? '';
    if (base64.isNotEmpty) {
      return CircleAvatar(radius: 18, backgroundImage: MemoryImage(base64Decode(base64)));
    }
    return CircleAvatar(
      radius: 18,
      backgroundColor: AppColors.primary.withValues(alpha: 0.18),
      child: Text(
        _initials(message.senderName),
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildComposer(BuildContext context, AppLocalizations l10n) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _inputController,
                textCapitalization: TextCapitalization.sentences,
                minLines: 1,
                maxLines: 4,
                maxLength: ChatService.maxLength,
                onSubmitted: (_) => _send(),
                decoration: InputDecoration(
                  hintText: l10n.chatHint,
                  counterText: '',
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton.filled(
              onPressed: _sending ? null : _send,
              icon: const Icon(Icons.send),
            ),
          ],
        ),
      ),
    );
  }

  String _initials(String name) {
    final parts = name.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty);
    if (parts.isEmpty) {
      return '?';
    }
    final letters = parts.map((p) => p.substring(0, 1)).take(2).join();
    return letters.toUpperCase();
  }

  String _formatTime(DateTime? dt) {
    if (dt == null) {
      return '…';
    }
    String two(int n) => n.toString().padLeft(2, '0');
    return '${two(dt.day)}.${two(dt.month)}.${dt.year} ${two(dt.hour)}:${two(dt.minute)}';
  }
}

/// Mesaj düzenleme diyaloğu. Kendi [TextEditingController]'ını yönetip
/// [dispose] içinde bırakır; controller'ı dialog kapanır kapanmaz elle
/// dispose etmek "_dependents.isEmpty" assertion hatasına yol açtığı için
/// yaşam döngüsü StatefulWidget'a bırakıldı.
class _EditMessageDialog extends StatefulWidget {
  final String title;
  final String initialText;
  final String cancelLabel;
  final String saveLabel;

  const _EditMessageDialog({
    required this.title,
    required this.initialText,
    required this.cancelLabel,
    required this.saveLabel,
  });

  @override
  State<_EditMessageDialog> createState() => _EditMessageDialogState();
}

class _EditMessageDialogState extends State<_EditMessageDialog> {
  late final TextEditingController _controller =
      TextEditingController(text: widget.initialText);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: TextField(
        controller: _controller,
        autofocus: true,
        minLines: 1,
        maxLines: 4,
        maxLength: ChatService.maxLength,
        textCapitalization: TextCapitalization.sentences,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(widget.cancelLabel),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, _controller.text.trim()),
          child: Text(widget.saveLabel),
        ),
      ],
    );
  }
}
