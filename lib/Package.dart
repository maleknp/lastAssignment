class Package {
  final String name;
  final String description;
  final double price;

  Package({required this.name, required this.description, required this.price});

  factory Package.fromJson(Map<String, dynamic> json) {
    return Package(
      name: json['reciever'] ?? '',
      description: json['description'] ?? '',
      price: double.tryParse(json['price'] ?? '0') ?? 0,
    );
  }
}
