import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../cubit/proposal_cubit.dart';

class ProposalsTab extends StatefulWidget {
  const ProposalsTab({super.key});

  @override
  State<ProposalsTab> createState() => _ProposalsTabState();
}

class _ProposalsTabState extends State<ProposalsTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<FileUploadCubit>(
        create: (context) => FileUploadCubit()..fetchProposals(),
        child: BlocBuilder<FileUploadCubit, FileUploadState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (state.errorMessage != null)
                    Text(state.errorMessage!, style: const TextStyle(color: Colors.red)),

                  // Display the list of fetched proposals
                  if (state.proposals != null)
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.proposals
                            !.length, // Note: You can safely use .length if you know it's a list now.
                        itemBuilder: (context, index) {
                          final proposal = state.proposals![index]; // Access the proposal object
                          return _buildFileItem(
                              proposal['document_name'], // Accessing document_name
                              'File',
                              'Uploaded at: ${proposal['created_at']}', // Accessing created_at
                              proposal['document_path'] ,
                            proposal['id'],// Accessing document_path
                          );
                        },
                      ),
                    ),


                  const SizedBox(height: 24),
                  const Text(
                    'Upload Proposal',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  _buildUploadArea(context),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: state.isUploading
                        ? null
                        : () {
                      context.read<FileUploadCubit>().uploadFile();
                    },
                    child: state.isUploading
                        ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                        : const Text('Upload'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildUploadArea(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        FilePickerResult? result = await FilePicker.platform.pickFiles();
        if (result != null && result.files.isNotEmpty) {
          File selectedFile = File(result.files.single.path!);
          context.read<FileUploadCubit>().selectFile(selectedFile);
        }
      },
      child: Container(
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
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.cloud_upload_outlined,
                    size: 40, color: Colors.grey[600]),
              ),
              const SizedBox(height: 16),
              Text(
                'Click to upload or drag and drop',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFileItem(String name, String type, String time, String filePath,int proposalId) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.yellow),
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            Image.network(filePath, width: 40, height: 40, fit: BoxFit.cover),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text('$type • $time', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                ],
              ),
            ),
            IconButton(icon:const Icon(Icons.visibility_outlined), color: Colors.grey[600], onPressed: () {
              _showImagePreview(context, filePath);
            },),
            IconButton(icon:const Icon(Icons.download), color: Colors.grey[600], onPressed: () {},),
        IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () async {
            final confirmDelete = await showDialog<bool>(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Confirm Delete'),
                  content: const Text('Are you sure you want to delete this image?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text('Delete'),
                    ),
                  ],
                );
              },
            );

            if (confirmDelete == true) {
              context.read<FileUploadCubit>().deleteImage(proposalId);
            }
          },
          )
          ],
        ),
      ),
    );
  }
  void _showImagePreview(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.all(0), // Remove default padding
          child: Container(
            width: MediaQuery.of(context).size.width, // Full width
            height: MediaQuery.of(context).size.height * 0.5, // 80% of screen height
            child: Column(
              children: [
                Expanded(
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover, // Fill the entire space
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Text('Close',style: TextStyle(color: Colors.black),),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


}
