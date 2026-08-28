class ImageHelper {
  static String generateAvatarByName(String name) {
    final trimmedName = name.trim().isEmpty ? 'user' : name.trim();
    return 'https://ui-avatars.com/api/?name=${Uri.encodeComponent(trimmedName)}';
  }
}
