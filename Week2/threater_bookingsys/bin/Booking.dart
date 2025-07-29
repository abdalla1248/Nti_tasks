import 'dart:io';

class Booking {
  List<Map<String, dynamic>> usersData = [];

  List<List<String>> array = List.generate(
    5,
    (_) => List.filled(5, '💺', growable: false),
  );

  void selection() {
    print('🎭 Welcome to the Theater Booking System!');
    while (true) {
      print('\nPlease select an option:');
      print('1. Book Ticket');
      print('2. View Theater Seats');
      print('3. Show Users Data');
      print('4. Exit');
      int selectedOption = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

      switch (selectedOption) {
        case 1:
          bookTicket();
          break;
        case 2:
          theaterseats();
          break;
        case 3:
          showUserData();
          break;
        case 4:
          print('👋 SEE YOU BACK!');
          return;
        default:
          print('❌ Invalid selection. Please try again.');
      }
    }
  }

  void bookTicket() {
    try {
      print('💺 Select seat (row,column):');
      String? input = stdin.readLineSync();

      if (input == null || !input.contains(',')) {
        print('❌ Invalid seat input. Format must be: row,column');
        return;
      }

      List<String> parts = input.split(',').map((e) => e.trim()).toList();
      if (parts.length != 2 || parts.any((p) => p.isEmpty)) {
        print('❌ Please enter both row and column numbers.');
        return;
      }

      int? row = int.tryParse(parts[0]);
      int? col = int.tryParse(parts[1]);

      if (row == null ||
          col == null ||
          row <= 0 ||
          col <= 0 ||
          row > 5 ||
          col > 5) {
        print('❌ Row and column must be between 1 and 5.');
        return;
      }

      if (array[row - 1][col - 1] != '💺') {
        print('❌ Seat already booked. Please choose another seat.');
        return;
      }

      // Ask user details only if seat is available
      print('👤 Enter your name:');
      String? userName = stdin.readLineSync();
      if (userName == null || userName.trim().isEmpty) {
        print('❌ Name cannot be empty.');
        return;
      }
      if (int.tryParse(userName.trim()) != null) {
        print('❌ Name cannot be only numbers.');
        return;
      }

      print('🎬 Enter movie name:');
      String? movieName = stdin.readLineSync();
      if (movieName == null || movieName.trim().isEmpty) {
        print('❌ Movie name cannot be empty.');
        return;
      }

      print('🎟️ Enter number of tickets:');
      int? numberOfTickets = int.tryParse(stdin.readLineSync() ?? '');
      if (numberOfTickets == null || numberOfTickets <= 0) {
        print('❌ Invalid ticket number.');
        return;
      }

      print('📞 Enter your phone number:');
      String? phoneNumber = stdin.readLineSync();
      if (phoneNumber == null || phoneNumber.trim().isEmpty) {
        print('❌ Phone number cannot be empty.');
        return;
      }

      // Mark seat and save booking
      array[row - 1][col - 1] = '❌';
      usersData.add({
        'name': userName,
        'movie': movieName,
        'tickets': numberOfTickets,
        'phone': phoneNumber,
        'seat': '$row,$col',
      });

      print(
          '✅ Ticket booked successfully for $userName to watch "$movieName".');
    } catch (e) {
      print('❌ An unexpected error occurred: $e');
    }
  }

  void showUserData() {
    if (usersData.isEmpty) {
      print('📭 No bookings found.');
    } else {
      print('\n📋 User Booking Data:');
      for (var data in usersData) {
        print(
            '💺 Seat: ${data['seat']}, 👤 Name: ${data['name']},🎬 Movie: ${data['movie']}, 🎟️ Tickets: ${data['tickets']}, 📞 Phone: ${data['phone']}');
      }
    }
  }

  void theaterseats() {
    print('\n🎭 Theater Seat Layout (💺 = Empty, ❌ = Booked):');
    for (var row in array) {
      print(row.join(' '));
    }
  }
}
