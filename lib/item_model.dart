class Item{
  final String name;
  final String category;
  final double price;
  final DateTime date;
  const Item({required this.name , required this.category, required this.price, required this.date});

  factory Item.fromMap(Map<String, dynamic> map) {    //take data as a Map as map
    final properties = map['properties'] as Map<String, dynamic>;
    final dateStr = properties['Date']?['date']?['start'];
    return Item(
        name: properties['Name']?['title']?[0]?['plain_text'] ?? '?',
        category: properties['category']?['select']?['name'] ?? 'Any',
      price: (properties['price']?['Number']?['name'] ?? 0).toDouble(),
      date: dateStr != null ? DateTime.parse(dateStr) : DateTime.now(),
    );
  }
}