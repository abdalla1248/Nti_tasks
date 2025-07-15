import 'dart:io';


final List<int> productIds = [1, 2, 3, 4, 5];
final List<String> productNames = ['Keyboard', 'Mouse', 'Monitor', 'USB Cable', 'Headphones'];
final List<double> productPrices = [100.0, 50.0, 300.0, 20.0, 150.0];

void main(List<String> arguments) {
  while (true) {
    showMenu();
    checkout();
    print('\nReady for next customer...\n');
    stdout.write('Is there a new customer? (yes/no): ');
    String answer = stdin.readLineSync()!.toLowerCase();
    if (answer != 'yes') {
      print('Thank you! Program closed.');
      break;
    }
  }
}

void showMenu() {
  print('\nWelcome to the store!');
  print('Available products:');
  for (int i = 0; i < productIds.length; i++) {
    print('${productIds[i]}. ${productNames[i]} - \$${productPrices[i]}');
  }
}

double calculateTax(double subtotal) => subtotal * 0.13;

double calculateDiscount(double subtotal) {
  return subtotal >= 1000 ? subtotal * 0.1 : 0.0;
}

double calculateDeliveryFee(double distance) {
  if (distance <= 0) return 0.0;
  if (distance <= 10) return 10.0;
  if (distance <= 20) return 20.0;
  return 45.0;
}

void checkout() {
  List<int> cartProductIndexes = [];
  List<int> cartQuantities = [];
  double subtotal = 0;

  while (true) {
    stdout.write('\nEnter product number to add to cart (0 to finish): ');
    int choice = int.tryParse(stdin.readLineSync()!) ?? -1;

    if (choice == 0) break;

    int index = productIds.indexOf(choice);

    if (index == -1) {
      print('Invalid product number.');
      continue;
    }

    stdout.write('Enter quantity: ');
    int quantity = int.tryParse(stdin.readLineSync()!) ?? 0;

    if (quantity <= 0) {
      print('Invalid quantity.');
      continue;
    }

    cartProductIndexes.add(index);
    cartQuantities.add(quantity);
    subtotal += productPrices[index] * quantity;
  }

  stdout.write('Please enter your name: ');
  String name = stdin.readLineSync()!;

  stdout.write('Please enter your phone number: ');
  String phone = stdin.readLineSync()!;

  double tax = calculateTax(subtotal);
  double discount = calculateDiscount(subtotal);

  stdout.write('Do you want delivery? (yes/no): ');
  bool wantsDelivery = stdin.readLineSync()!.toLowerCase() == 'yes';

  double deliveryFee = 0;
  if (wantsDelivery) {
    stdout.write('Enter delivery distance in km: ');
    double distance = double.tryParse(stdin.readLineSync()!) ?? 0.0;
    deliveryFee = calculateDeliveryFee(distance);
  }

  double total = subtotal + tax - discount + deliveryFee;

  print('''
----------------------------
Receipt for $name
Phone: $phone

Items Purchased:
''');

  for (int i = 0; i < cartProductIndexes.length; i++) {
    int idx = cartProductIndexes[i];
    int qty = cartQuantities[i];
    double itemTotal = productPrices[idx] * qty;
    print('${productNames[idx]} x$qty = \$${itemTotal.toStringAsFixed(2)}');
  }

  print('''
Subtotal: \$${subtotal.toStringAsFixed(2)}
Tax (13%): \$${tax.toStringAsFixed(2)}
Discount: \$${discount.toStringAsFixed(2)}
Delivery fee: \$${deliveryFee.toStringAsFixed(2)}
----------------------------
Total amount to pay: \$${total.toStringAsFixed(2)}

Thank you for shopping with us, $name!
-----------------------------------------
''');
}
