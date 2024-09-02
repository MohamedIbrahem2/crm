import 'package:flutter/material.dart';

import '../../pages/tickets_details_page.dart';
import 'attachment_item_widget.dart';

class AttachmentsWidget extends StatelessWidget {
  const AttachmentsWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('2 Attachments', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Row(
          children: [
            AttachmentItemWidget(icon: Icons.picture_as_pdf, label: 'doc.pdf', size: '29 KB'),
            SizedBox(width: 16),
            AttachmentItemWidget(icon: Icons.image, label: 'image.jpg', size: '29 KB'),
          ],
        ),
      ],
    );
  }
}