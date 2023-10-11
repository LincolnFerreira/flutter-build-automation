import 'dart:io';
import 'package:pub_semver/pub_semver.dart';

void main(List<String> arguments) {
  if (arguments.length != 1) {
    print('Uso: dart build_apks.dart <nova_versao>');
    exit(1);
  }

  final selectedOption = selectVersionOption();
  final versaoAtual = getCurrentVersion();

  final updatedVersion = updateVersion(versaoAtual, selectedOption);
  print('Versão atual: $versaoAtual');
  print('Versão após atualização: $updatedVersion');
}

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

void clearScreen() {
  print('\x1B[2J\x1B[0;0H');
}

String getCurrentVersion() {
  final pubspecFile = File('pubspec.yaml');
  final content = pubspecFile.readAsStringSync();

  final pattern = RegExp(r'version:\s+([0-9]+\.[0-9]+\.[0-9]+)');
  final match = pattern.firstMatch(content);

  if (match != null) {
    return match.group(1)!;
  }

  throw Exception(
      'Não foi possível encontrar a versão no arquivo pubspec.yaml.');
}

String updateVersion(String currentVersion, int category) {
  Version version = Version.parse(currentVersion);

  switch (category) {
    case 1:
      version = version.nextMajor;
      break;
    case 2:
      version = version.nextMinor;
      break;
    case 3:
      version = version.nextPatch;
      break;
    default:
      break;
  }

  return version.toString();
}
