import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../util/logger.dart';

class ShareButton extends StatefulWidget {
  const ShareButton({required this.text, this.size = 24, this.color, super.key, this.padding});

  final String text;
  final double? size;
  final Color? color;
  final EdgeInsets? padding;

  @override
  State<ShareButton> createState() => _ShareButtonState();
}

class _ShareButtonState extends State<ShareButton> {
  Future<void> _onShareTap() async {
    if (widget.text.isEmpty) {
      severe('!!! SHARE TEXT IS EMPTY !!!');
      return;
    }

    final box = context.findRenderObject() as RenderBox?;

    if (box == null) return;

    final shareOrigin = box.localToGlobal(Offset.zero) & box.size;

    await SharePlus.instance.share(ShareParams(uri: Uri.tryParse(widget.text), sharePositionOrigin: shareOrigin));
  }

  @override
  Widget build(BuildContext context) => IconButton(
    onPressed: _onShareTap,
    icon: Padding(padding: widget.padding ?? EdgeInsets.zero, child: const Icon(Icons.share)),
  );
}
