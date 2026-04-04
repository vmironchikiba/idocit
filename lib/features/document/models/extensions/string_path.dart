import 'package:path/path.dart' as p;

extension StringPath on String {
  bool hasExtension(String extension) => p.extension(this).toLowerCase() == ".${extension.toLowerCase()}";
  String get basenameWithoutExtension => p.basenameWithoutExtension(this);
  String withExtension(String extension) => hasExtension(extension) ? this : "$basenameWithoutExtension.$extension";
}
