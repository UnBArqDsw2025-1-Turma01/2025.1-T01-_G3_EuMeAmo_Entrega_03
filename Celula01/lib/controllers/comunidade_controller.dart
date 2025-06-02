// controllers/comunidade_controller.dart
import 'package:flutter/material.dart'; // Use ChangeNotifier for state management
import '../models/comunidade_post_model.dart';

class ComunidadeController extends ChangeNotifier { // Extend ChangeNotifier

  // Mock data using the ComunidadePost model
  final List<ComunidadePost> _posts = [
    ComunidadePost.mock({
      "id": "post1", // Add IDs for identification
      "author": "Ana Silva",
      "timestamp": DateTime.now().subtract(const Duration(hours: 2)),
      "content": "Comecei a fazer os exercícios de postura recomendados no app e já sinto uma melhora! Alguém mais está fazendo?",
      "likes": 15,
      "comments": 3,
    }),
    ComunidadePost.mock({
      "id": "post2",
      "author": "Carlos Mendes",
      "timestamp": DateTime.now().subtract(const Duration(hours: 5)),
      "content": "Dica de hidratação: sempre tenho uma garrafa de água na minha mesa. Ajuda muito a lembrar de beber! #hidratacao",
      "likes": 22,
      "comments": 5,
    }),
    ComunidadePost.mock({
      "id": "post3",
      "author": "Nutri Mariana",
      "timestamp": DateTime.now().subtract(const Duration(days: 1)),
      "content": "Lembrete importante: não pulem o café da manhã! É essencial para dar energia ao corpo e manter o metabolismo ativo. #nutricao",
      "likes": 45,
      "comments": 12,
    }),
    ComunidadePost.mock({
      "id": "post4",
      "author": "Pedro Rocha",
      "timestamp": DateTime.now().subtract(const Duration(days: 2)),
      "content": "Qual a meditação guiada favorita de vocês aqui no app? Gostei muito da de 10 minutos para relaxar.",
      "likes": 8,
      "comments": 2,
    }),
  ];

  // Method to get all posts (for the feed)
  List<ComunidadePost> getPosts() {
    // Sort posts by timestamp, newest first
    _posts.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return List.from(_posts); // Return a copy
  }

  // Method to add a new post
  void adicionarPost(String content, String authorName) { // Receive content and author
    final newPost = ComunidadePost(
      id: DateTime.now().millisecondsSinceEpoch.toString(), // Generate unique ID
      authorId: "mockUserId", // Replace with actual user ID later
      authorName: authorName, // Use provided author name
      timestamp: DateTime.now(),
      content: content,
    );
    _posts.insert(0, newPost); // Add to the beginning
    notifyListeners(); // Notify listeners to update UI
    print("Post adicionado: ${newPost.content.substring(0, 20)}...");
  }

  // Method to handle liking a post
  void curtirPost(String postId) {
    try {
      final postIndex = _posts.indexWhere((p) => p.id == postId);
      if (postIndex != -1) {
        // Simulate toggling like for simplicity in mock
        // In a real app, check if user already liked
        _posts[postIndex].likes++; // Increment likes
        notifyListeners(); // Notify listeners to update UI
        print("Post $postId curtido");
      } else {
        print("Erro ao curtir post $postId: Post não encontrado.");
      }
    } catch (e) {
      print("Erro ao curtir post $postId: $e");
    }
  }

// TODO: Add methods for commenting, sharing, fetching more posts (pagination), etc.
}

