void main() {
  final input = 'Hello, check google.com and also https://dart.dev!';
  final parts = input.extractLinks();

  for (final part in parts) {
    if (part is LinkPart) {
      print('Link: ${part.url}');
    } else if (part is TextPart) {
      print('Text: ${part.content}');
    }
  }
}

/// Базовый класс для частей текста
abstract class TextPart {}

/// Обычный текст
class TextPartImpl extends TextPart {
  final String content;
  TextPartImpl(this.content);
}

/// Ссылка
class LinkPart extends TextPart {
  final String url;
  LinkPart(this.url);
}

/// Расширение для String
extension LinkParser on String {
  /// Метод извлекает ссылки и обычный текст в виде списка TextPart
  List<TextPart> extractLinks() {
    final linkRegex = RegExp(
      r'((https?:\/\/)?([a-zA-Z0-9\-]+\.)+[a-zA-Z]{2,}(:\d+)?(\/\S*)?)',
      caseSensitive: false,
    );

    final matches = linkRegex.allMatches(this);
    final parts = <TextPart>[];

    int lastIndex = 0;

    for (final match in matches) {
      if (match.start > lastIndex) {
        // Добавляем текст между ссылками
        parts.add(TextPartImpl(substring(lastIndex, match.start)));
      }

      final url = match.group(0)!;
      parts.add(LinkPart(url));
      lastIndex = match.end;
    }

    if (lastIndex < length) {
      // Добавляем оставшийся текст
      parts.add(TextPartImpl(substring(lastIndex)));
    }

    return parts;
  }
}
