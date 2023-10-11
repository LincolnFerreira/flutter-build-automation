import 'dart:io';

import 'flutter_build_automation.dart';

int selectVersionOption() {
  final options = ['Padrão', 'Major', 'Minor', 'Patch'];
  var selectedOption = 0;

  stdin.echoMode = false;
  stdin.lineMode = false;

  while (true) {
    clearScreen();
    print('Selecione uma opção:');

    for (int i = 0; i < options.length; i++) {
      final option = options[i];
      final isSelected = i == selectedOption;
      final arrow = isSelected ? '\x1B[32m • ' : '   ';
      print('$arrow\x1B[37m${i + 1} - $option');
    }

    final key = stdin.readByteSync();

    if (key == 27) {
      stdin.readByteSync();
      final arrowKey = stdin.readByteSync();

      if (arrowKey == 65 && selectedOption > 0) {
        // Seta para cima
        selectedOption--;
      } else if (arrowKey == 66 && selectedOption < options.length - 1) {
        // Seta para baixo
        selectedOption++;
      }
    } else if (key == 10) {
      stdin.echoMode = true;
      stdin.lineMode = true;
      return selectedOption;
    } else {
      // Ignorar outras teclas
    }
  }
}
