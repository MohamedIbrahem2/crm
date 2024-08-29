import 'package:flutter/material.dart';


class LeadImport extends StatelessWidget {
  const LeadImport({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Import Leads')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImportInstructions(),
              SizedBox(height: 20),
              ImportLeadsSection(),
              SizedBox(height: 20),
              SampleDataTable(),
              SizedBox(height: 20),
              FileUploadSection(),
              SizedBox(height: 20),
              FallbackFields(),
            ],
          ),
        ),
      ),
    );
  }
}

class ImportInstructions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('# Rules Import Leads', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('1. Your CSV data should be in the format below. The first line of your CSV file should be the column headers as in the table example. Also make sure that your file is UTF-8 to avoid unnecessary encoding problems.'),
            Text('2. If the column you are trying to import is date make sure that is formatted in format Y-m-d (2024-08-28).'),
            Text('3. Based on your leads unique validation configured options, the lead won\'t be imported if:'),
            Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text('- Lead email already exists'),
            ),
            SizedBox(height: 10),
            Text('If you still want to import all leads, uncheck all unique validation field'),
          ],
        ),
      ),
    );
  }
}

class ImportLeadsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('# Import Leads', style: TextStyle(fontWeight: FontWeight.bold)),
        ElevatedButton(
          onPressed: () {},
          child: Text('Download Sample'),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
        ),
      ],
    );
  }
}

class SampleDataTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          DataColumn(label: Text('Name')),
          DataColumn(label: Text('Position')),
          DataColumn(label: Text('Email Address')),
          DataColumn(label: Text('Website')),
          DataColumn(label: Text('Phone')),
          DataColumn(label: Text('Lead Value')),
          DataColumn(label: Text('Company')),
          DataColumn(label: Text('City')),
        ],
        rows: [
          DataRow(cells: [
            DataCell(Text('Sample Data')),
            DataCell(Text('Sample Data')),
            DataCell(Text('Sample Data')),
            DataCell(Text('Sample Data')),
            DataCell(Text('Sample Data')),
            DataCell(Text('Sample Data')),
            DataCell(Text('Sample Data')),
            DataCell(Text('Sample Data')),
          ]),
        ],
      ),
    );
  }
}

class FileUploadSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Choose CSV File'),
        SizedBox(height: 8),
        OutlinedButton(
          onPressed: () {},
          child: Text('Choose File'),
        ),
        SizedBox(height: 4),
        Text('No File Chosen', style: TextStyle(color: Colors.grey)),
      ],
    );
  }
}

class FallbackFields extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownField(label: 'Status (fallback)'),
        SizedBox(height: 16),
        DropdownField(label: 'Source (fallback)'),
        SizedBox(height: 16),
        DropdownField(label: 'Responsible (Assignee)'),
      ],
    );
  }
}

class DropdownField extends StatelessWidget {
  final String label;

  const DropdownField({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Select...', style: TextStyle(color: Colors.grey)),
              Icon(Icons.arrow_drop_down, color: Colors.grey),
            ],
          ),
        ),
      ],
    );
  }
}