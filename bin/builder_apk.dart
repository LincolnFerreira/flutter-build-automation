import 'dart:io';

Future<void> gerarAPKs() async {
  try {
    final comandos = [
      'flutter build apk --flavor prod --release -t lib/main_prod.dart',
      'flutter build apk --flavor hmg --release -t lib/main_hmg.dart',
    ];

    for (final comando in comandos) {
      final resultado = await Process.run('bash', ['-c', comando]);

      if (resultado.exitCode == 0) {
        print('APK gerado com sucesso: $comando');
      } else {
        print('Erro ao gerar APK: $comando');
        print('Erro: ${resultado.stderr}');
      }
    }
  } catch (e) {
    print('Erro ao executar os comandos: $e');
  }
}
