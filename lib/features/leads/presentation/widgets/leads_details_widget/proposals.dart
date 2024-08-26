import 'package:flutter/material.dart';

class ProposalsTab extends StatelessWidget {
  const ProposalsTab({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Proposal'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFileItem('doc.pdf', 'PDF', '29 KB', '2 hrs ago'),
            SizedBox(height: 8),
            _buildFileItem('image.jpg', '', '29 KB', '2 hrs ago', hasIcon: true),
            SizedBox(height: 24),
            Text(
              'Upload Proposal',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            _buildUploadArea(),
          ],
        ),
      ),
    );
  }

  Widget _buildFileItem(String name, String type, String size, String time, {bool hasIcon = false}) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: type == 'PDF' ? Colors.red : Colors.grey[200],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: hasIcon
                  ? Icon(Icons.image, color: Colors.grey[600])
                  : Text(
                type,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
                Text('$size • $time', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
              ],
            ),
          ),
          Icon(Icons.visibility_outlined, color: Colors.grey[600]),
          SizedBox(width: 16),
          Icon(Icons.file_download_outlined, color: Colors.grey[600]),
          SizedBox(width: 16),
          Icon(Icons.delete_outline, color: Colors.grey[600]),
        ],
      ),
    );
  }

  Widget _buildUploadArea() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.cloud_upload_outlined, size: 40, color: Colors.grey[600]),
            ),
            SizedBox(height: 16),
            Text('Click to upload or drag and drop', style: TextStyle(color: Colors.grey[600])),
          ],
        ),
      ),
    );
  }
}