// ignore_for_file: unused_local_variable

import 'dart:io';

void main() {
  // Validate name
  String name;
  while (true) {
    stdout.write("Enter your name: ");
    String? input = stdin.readLineSync();
    name = input?.trim() ?? '';
    if (name.isNotEmpty) break;
    print("Invalid input. Name cannot be empty.");
  }

  // Validate account number
  String accountNumber;
  while (true) {
    stdout.write("Enter account number: ");
    String? input = stdin.readLineSync();
    accountNumber = input?.trim() ?? '';
    if (accountNumber.isNotEmpty) break;
    print("Invalid input. Account number cannot be empty.");
  }

  // Validate account type
  String accountType;
  while (true) {
    stdout.write("Enter account type (savings/checking): ");
    String? input = stdin.readLineSync();
    accountType = input?.trim().toLowerCase() ?? '';
    if (accountType == "savings" || accountType == "checking") break;
    print("Invalid account type. Please enter 'savings' or 'checking'.");
  }

  // Validate initial balance
  double balance;
  while (true) {
    stdout.write("Enter initial balance: ");
    String? input = stdin.readLineSync();
    double? value = double.tryParse(input ?? '');
    if (value != null && value >= 0) {
      balance = value;
      break;
    }
    print("Invalid input. Balance must be a non-negative number.");
  }

  menu(name, accountNumber, accountType, balance);
}

void menu(String name, String number, String type, double balance) {
  while (true) {
    print("\n------ Menu ------");
    print("1. Deposit");
    print("2. Withdraw");
    print("3. Predict Future Balance (Profit Model)");
    print("4. View Account Summary");
    print("5. Exit");

    stdout.write("Choose an option: ");
    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        balance = deposit(balance);
        break;

      case '2':
        balance = withdraw(balance);
        break;

      case '3':
        predictFutureBalance(balance);
        break;

      case '4':
        accountSummary(name, number, type, balance);
        break;

      case '5':
        print("Thank you for using the banking system. Goodbye!");
        return;

      default:
        print("Invalid option. Please choose between 1 and 5.");
    }
  }
}

double deposit(double balance) {
  stdout.write('Enter amount to deposit: ');
  double depositAmount = double.tryParse(stdin.readLineSync() ?? '') ?? -1;
  if (depositAmount <= 0) {
    print('Invalid deposit amount.');
  } else {
    balance += depositAmount;
    print('Deposited: \$${depositAmount.toStringAsFixed(2)}');
  }
  return balance;
}

double withdraw(double balance) {
  stdout.write('Enter amount to withdraw: ');
  double withdrawAmount = double.tryParse(stdin.readLineSync() ?? '') ?? -1;
  if (withdrawAmount <= 0) {
    print('Invalid amount. Withdrawal failed.');
  } else if (withdrawAmount < balance) {
    balance -= withdrawAmount;
    print('Withdrawal successful. The current balance is: \$${balance.toStringAsFixed(2)}');
  } else {
    print('Insufficient balance. Withdrawal denied.');
  }
  return balance;
}

void predictFutureBalance(double balance) {
  print('Enter number of years:');
  int years = int.tryParse(stdin.readLineSync() ?? '') ?? 0;
  print('Enter annual profit rate (%):');
  double annualRate = double.tryParse(stdin.readLineSync() ?? '') ?? 0.0;
  if (years <= 0 || annualRate < 0) {
    print('Invalid input. Years must be positive and annual rate cannot be negative.');
    return;
  }
  double futureBalance = balance * (1 + annualRate / 100) * years;
  int roundedBalance = futureBalance.round();
  print('''
Future balance after $years years at $annualRate% annual rate: \$${futureBalance.toStringAsFixed(2)}
Rounded balance: \$$roundedBalance
''');
}

void accountSummary(String name, String number, String type, double balance) {
  print('''
Account Name: $name
Account Number: $number
Account Type: $type
Balance: \$${balance.toStringAsFixed(2)}
Rounded Balance: \$${balance.round()}
''');
}
