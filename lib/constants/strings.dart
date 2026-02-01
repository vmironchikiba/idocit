class StringsConstants {
  static final basePath = 'https://ai-assistant.ibagroupit.com/idocit';

  static final String fallbackHtmlTemplate = '''
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body { font-family: sans-serif; padding: 20px; }
        mark.search-match { background: yellow; padding: 2px; }
        mark.search-match.current-match { background: orange; border: 2px solid red; }
    </style>
</head>
<body>
    <!-- CONTENT_PLACEHOLDER -->
    <!-- NAVIGATION_PLACEHOLDER -->
    <script>
        let currentMatchIndex = 0;
        let allMatches = [];
        
        document.addEventListener('DOMContentLoaded', function() {
            allMatches = Array.from(document.querySelectorAll('mark.search-match'));
            if (allMatches.length > 0) {
                setTimeout(() => {
                    allMatches[0].classList.add('current-match');
                    allMatches[0].scrollIntoView({ behavior: 'smooth', block: 'center' });
                }, 300);
            }
        });
        
        window.scrollToFirstMatch = function() {
            if (allMatches.length > 0) {
                allMatches[0].scrollIntoView({ behavior: 'smooth', block: 'center' });
                return true;
            }
            return false;
        };
    </script>
</body>
</html>''';
}
