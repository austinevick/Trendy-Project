enum MediaType {
  image('image'),
  video('video'),
  none('null');

  final String type;

  const MediaType(this.type);
}

extension ConvertToString on String {
  MediaType toEnum() {
    switch (this) {
      case 'image':
        return MediaType.image;
      case 'video':
        return MediaType.video;
      default:
        return MediaType.none;
    }
  }
}
