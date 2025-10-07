class Item {
  String id;
  String name;
  String description;
  int quantity;
  double weight;
  int value; // Em moedas de cobre
  ItemType type;
  bool isEquipped;

  Item({
    required this.id,
    required this.name,
    this.description = '',
    this.quantity = 1,
    this.weight = 0.0,
    this.value = 0,
    this.type = ItemType.misc,
    this.isEquipped = false,
  });

  // Conversão de valor em diferentes moedas
  Map<String, int> getValueInCoins() {
    int copper = value;
    int silver = copper ~/ 10;
    copper = copper % 10;
    int gold = silver ~/ 10;
    silver = silver % 10;
    int platinum = gold ~/ 10;
    gold = gold % 10;

    return {
      'platinum': platinum,
      'gold': gold,
      'silver': silver,
      'copper': copper,
    };
  }

  @override
  String toString() {
    return 'Item{name: $name, quantity: $quantity, weight: $weight, value: $value, type: $type}';
  }

  /// Converte JSON para Item
  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String? ?? '',
      quantity: json['quantity'] as int? ?? 1,
      weight: (json['weight'] as num?)?.toDouble() ?? 0.0,
      value: (json['value'] as num?)?.toInt() ?? 0,
      type: ItemType.values.firstWhere(
        (type) => type.toString().split('.').last == json['type'],
        orElse: () => ItemType.misc,
      ),
      isEquipped: json['isEquipped'] as bool? ?? false,
    );
  }

  /// Converte Item para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'quantity': quantity,
      'weight': weight,
      'value': value,
      'type': type.toString().split('.').last,
      'isEquipped': isEquipped,
    };
  }
}

enum ItemType { weapon, armor, shield, tool, consumable, treasure, misc }
