import 'dart:io';

import 'package:pub_semver/pub_semver.dart';

void main(List<String> arguments) {
  if (arguments.length != 1) {
    print('Uso: dart build_apks.dart <nova_versao>');
    exit(1);
  }

  final novaVersao = arguments[0];

  // Verifique se a nova versão é válida
  // if (Version.parse(novaVersao)) {
  //   print('A nova versão não é válida.');
  //   exit(1);
  // }

  // Atualize o pubspec.yaml com a nova versão
  final pubspecFile = File('pubspec.yaml');
  final pubspec = pubspecFile.readAsStringSync();
  final linhas = pubspec.split('\n');
  for (var i = 0; i < linhas.length; i++) {
    if (linhas[i].contains('version:')) {
      linhas[i] = 'version: $novaVersao';
      break;
    }
  }
  pubspecFile.writeAsStringSync(linhas.join('\n'));

  print('Versão atualizada para $novaVersao.');

  // Gere os APKs (substitua pelo seu próprio código)
  // Você pode usar ferramentas como o Flutter para gerar APKs.

  // Execute o processo para gerar APKs
  final processo = Process.runSync('comando_para_gerar_apks', []);

  if (processo.exitCode == 0) {
    print('APKs gerados com sucesso.');
  } else {
    print('Erro ao gerar APKs.');
  }
}
