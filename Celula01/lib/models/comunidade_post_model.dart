// models/comunidade_post_model.dart

class ComunidadePost {
  final String id;
  final String authorId; // ID do usuário que postou
  final String authorName;
  final String? authorAvatarUrl; // URL do avatar do autor
  final DateTime timestamp;
  final String content;
  int likes;
  int commentsCount;
  // List<ComunidadeComentario> comments; // Poderia ser adicionado depois

  ComunidadePost({
    required this.id,
    required this.authorId,
    required this.authorName,
    this.authorAvatarUrl,
    required this.timestamp,
    required this.content,
    this.likes = 0,
    this.commentsCount = 0,
    // this.comments = const [],
  });

  // Mock factory para criar posts de exemplo
  factory ComunidadePost.mock(Map<String, dynamic> data) {
    return ComunidadePost(
      id: data["id"] ?? DateTime.now().millisecondsSinceEpoch.toString(),
      authorId: data["authorId"] ?? "user_${DateTime.now().millisecondsSinceEpoch}",
      authorName: data["author"] ?? "Usuário Anônimo",
      authorAvatarUrl: data["avatarUrl"],
      timestamp: data["timestamp"] ?? DateTime.now(),
      content: data["content"] ?? "",
      likes: data["likes"] ?? 0,
      commentsCount: data["comments"] ?? 0,
    );
  }
}

// Poderia adicionar um modelo para Comentários aqui também
// class ComunidadeComentario { ... }

