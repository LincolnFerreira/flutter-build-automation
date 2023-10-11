import 'package:pub_semver/pub_semver.dart';

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
