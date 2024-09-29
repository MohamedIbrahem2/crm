class Lead {
  final String name;
  final String position;
  final String company;
  final double amount;
  final String status;
  final String date;
  final String phone;
  final String website;
  final String address;
  final String city;
  final String state;
  final String zipcode;
  final String country;
  final String leadId;


  Lead({
    required this.name,
    required this.position,
    required this.company,
    required this.amount,
    required this.status,
    required this.date,
    required this.phone,
    required this.website,
    required this.address,
    required this.city,
    required this.state,
    required this.zipcode,
    required this.country,
    required this.leadId,

  });

  @override
  String toString() {
    return 'Lead(name: $name, position: $position, company: $company, amount: $amount,'
        ' status: $status, date: $date ,phone: $phone, website: $website, address: $address,'
        ' city: $city, state: $status, zipcode: $zipcode, country: $country, leadId: $leadId)';
  }

  factory Lead.fromJson(Map<String, dynamic> json) {
    // Add null checks and handle errors
    String name = json['name'] ?? 'Unknown';
    String position = json['position'] ?? 'Not specified';
    String company = json['company'] ?? 'Not specified';
    String status = json['state'] ?? 'Unknown';
    double amount = double.tryParse(json['lead_value']?.toString() ?? '0.0') ?? 0.0;
    String date = json['needs'] ?? 'Not specified';
    String phone = json['phone'] ?? 'Not specified';
    String website = json['website'] ?? 'Not specified';
    String address = json['address'] ?? 'Not specified';
    String city = json['city'] ?? 'Not specified';
    String state = json['state'] ?? 'Not specified';
    String zipcode = json['zip_code'] ?? 'Not specified';
    String country = json['country']['name'] ?? 'Not specified';
    String leadId = json['id'].toString() ?? 'Not specified';



    return Lead(
      name: name,
      position: position,
      company: company,
      status: status,
      amount: amount,
      date: date,
      phone: phone,
      website: website,
      address: address,
      city: city,
      state: state,
      zipcode: zipcode,
      country: country,
        leadId: leadId
    );
  }
}
