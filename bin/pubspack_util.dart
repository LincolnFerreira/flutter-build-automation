import 'dart:io';
import 'package:pub_semver/pub_semver.dart';

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

void updatePubspecVersions(String updatedVersion) {
  final diretorioAtual = Directory.current;
  final arquivosPubspec = diretorioAtual
      .listSync(recursive: true, followLinks: false)
      .where(
          (entity) => entity is File && entity.path.endsWith('pubspec.yaml'));

  for (final arquivo in arquivosPubspec) {
    final linhas = (arquivo as File).readAsLinesSync();
    for (var i = 0; i < linhas.length; i++) {
      if (linhas[i].contains('version:')) {
        linhas[i] = 'version: $updatedVersion';
        arquivo.writeAsStringSync(linhas.join('\n'));
        print('Versão atualizada em ${arquivo.path}');
        break;
      }
    }
  }
}
