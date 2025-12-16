enum DocType { web, md, unknown }

extension StringDocType on String {
  DocType toDocType() {
    switch (this) {
      case 'WEB documents':
        return DocType.web;
      case 'MD Format':
        return DocType.md;
      default:
        return DocType.unknown;
    }
  }
}
