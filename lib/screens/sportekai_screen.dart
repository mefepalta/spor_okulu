import 'package:flutter/material.dart';

import '../constants/ai_config.dart';
import '../services/ai_service.dart';
import '../theme/app_colors.dart';
import '../widgets/empty_state.dart';
import '../widgets/wave_background.dart';

/// Personel için varsayılan hazır komutlar.
const List<String> kStaffAiSuggestions = [
  'Bu ayı özetle',
  'Nelere dikkat etmeliyim?',
  'Devamsızlık için veliye kısa bir mesaj taslağı yaz',
  'Tahsilatı artırmak için 3 öneri ver',
];

/// Veli için varsayılan hazır komutlar.
const List<String> kParentAiSuggestions = [
  'Çocuğumun durumunu özetle',
  'Devamsızlık durumu nasıl?',
  'Ödeme durumumu açıkla',
  'Gelişimi için ne önerirsin?',
];

/// SporTekAi ✨ — anonim özeti bağlam alan sohbet asistanı.
///
/// Cloudflare Worker proxy üzerinden Groq'a bağlanır (bkz. cloudflare/README).
/// Modele yalnızca [summary] (anonim) + kullanıcının sorusu gider.
class SporTekAiScreen extends StatefulWidget {
  /// Anonim özet (AiSummary ile üretilir).
  final String summary;

  /// Boş ekranda gösterilen hazır komutlar (role göre).
  final List<String> suggestions;

  /// Giriş ekranındaki açıklama metni (role göre).
  final String introSubtitle;

  const SporTekAiScreen({
    super.key,
    required this.summary,
    this.suggestions = kStaffAiSuggestions,
    this.introSubtitle =
        'Kulübünüzün güncel özetini biliyorum. Aşağıdakilerden birini '
        'seçebilir ya da kendi sorunu yazabilirsin.',
  });

  @override
  State<SporTekAiScreen> createState() => _SporTekAiScreenState();
}

class _SporTekAiScreenState extends State<SporTekAiScreen> {
  final AiService _aiService = AiService();
  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<AiMessage> _messages = [];
  bool _isSending = false;

  String get _systemPrompt =>
      'Sen SporTekAi\'sın; bir spor okulu yönetim asistanısın. Aşağıda kulübün '
      'güncel ANONİM özeti var. Sorulara Türkçe, kısa ve uygulanabilir yanıt '
      'ver; uygun olduğunda maddeler halinde yaz. Sana verilen özet toplu ya da '
      'genel olabilir; yine de eldeki bilgilerle en yararlı özeti/yanıtı sun. '
      'Sayı uydurma; bir bilgi gerçekten yoksa kısaca belirt ama olabildiğince '
      'yardımcı ol.\n\n'
      '${widget.summary}';

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _send(String text) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty || _isSending) {
      return;
    }

    setState(() {
      _messages.add(AiMessage.user(trimmed));
      _isSending = true;
      _inputController.clear();
    });
    _scrollToBottom();

    try {
      final reply = await _aiService.chat([
        AiMessage.system(_systemPrompt),
        ..._messages,
      ]);
      if (!mounted) {
        return;
      }
      setState(() => _messages.add(AiMessage.assistant(reply)));
    } on AiException catch (error) {
      if (!mounted) {
        return;
      }
      setState(
        () => _messages.add(AiMessage.assistant('⚠️ ${error.message}')),
      );
    } finally {
      if (mounted) {
        setState(() => _isSending = false);
        _scrollToBottom();
      }
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WaveScaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.auto_awesome, size: 20),
            SizedBox(width: 8),
            Text('SporTekAi'),
          ],
        ),
      ),
      body: !AiConfig.isConfigured
          ? const EmptyState(
              icon: Icons.auto_awesome,
              title: 'SporTekAi henüz hazır değil',
              message:
                  'Yapay zekâ asistanını kullanmak için Cloudflare Worker '
                  'adresi (SPORTEKAI_ENDPOINT) tanımlanmalı. Kurulum: '
                  'cloudflare/README.md',
            )
          : Column(
              children: [
                Expanded(
                  child: _messages.isEmpty
                      ? _buildIntro(context)
                      : ListView.builder(
                          controller: _scrollController,
                          padding: const EdgeInsets.all(16),
                          itemCount: _messages.length + (_isSending ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index >= _messages.length) {
                              return _buildTypingBubble(context);
                            }
                            return _buildBubble(context, _messages[index]);
                          },
                        ),
                ),
                _buildComposer(context),
              ],
            ),
    );
  }

  Widget _buildIntro(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SizedBox(height: 8),
        CircleAvatar(
          radius: 30,
          backgroundColor: AppColors.primary.withValues(alpha: 0.14),
          child: const Icon(
            Icons.auto_awesome,
            color: AppColors.primary,
            size: 30,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Merhaba! Ben SporTekAi ✨',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Text(
          widget.introSubtitle,
          textAlign: TextAlign.center,
          style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color),
        ),
        const SizedBox(height: 20),
        for (final suggestion in widget.suggestions)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: OutlinedButton(
              onPressed: () => _send(suggestion),
              style: OutlinedButton.styleFrom(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.chat_bubble_outline, size: 18),
                  const SizedBox(width: 10),
                  Expanded(child: Text(suggestion)),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildBubble(BuildContext context, AiMessage message) {
    final isUser = message.role == 'user';
    final bg = isUser
        ? AppColors.primary
        : Theme.of(context).cardColor;
    final fg = isUser ? Colors.white : null;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.82,
        ),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(14),
            topRight: const Radius.circular(14),
            bottomLeft: Radius.circular(isUser ? 14 : 2),
            bottomRight: Radius.circular(isUser ? 2 : 14),
          ),
        ),
        child: Text(
          message.content,
          style: TextStyle(color: fg, height: 1.4),
        ),
      ),
    );
  }

  Widget _buildTypingBubble(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(14),
        ),
        child: const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );
  }

  Widget _buildComposer(BuildContext context) {
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
                onSubmitted: _isSending ? null : _send,
                decoration: InputDecoration(
                  hintText: 'SporTekAi\'ye sor...',
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
              onPressed: _isSending
                  ? null
                  : () => _send(_inputController.text),
              icon: const Icon(Icons.send),
            ),
          ],
        ),
      ),
    );
  }
}
