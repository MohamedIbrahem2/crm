class DropdownItem {
  final int id;
  final String name;

  DropdownItem({required this.id, required this.name});

  factory DropdownItem.fromJson(Map<String, dynamic> json,String name) {
    return DropdownItem(
      id: json['id'],
      name: json[name],
    );
  }
}
