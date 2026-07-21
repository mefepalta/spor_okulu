import 'package:flutter/widgets.dart';

/// iPad'de paylaşım menüsü (UIActivityViewController) popover olarak açılır ve
/// bir çapa dikdörtgeni zorunludur; verilmezse share_plus iPad'de hata
/// fırlatır. Bu yardımcı, çağıran ekranın RenderBox'ından güvenli bir çapa
/// üretir. Telefonlarda ve çapa bulunamazsa null döner (oralarda gerekmez).
Rect? shareOriginOf(BuildContext context) {
  final box = context.findRenderObject() as RenderBox?;
  if (box == null || !box.hasSize) {
    return null;
  }
  return box.localToGlobal(Offset.zero) & box.size;
}
