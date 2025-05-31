// views/comunidade/comunidade_screen.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'package:provider/provider.dart'; // Import Provider

// Import the model and controller
import '../../models/comunidade_post_model.dart';
import '../../controllers/comunidade_controller.dart';

class ComunidadeScreen extends StatefulWidget {
  const ComunidadeScreen({super.key});

  @override
  State<ComunidadeScreen> createState() => _ComunidadeScreenState();
}

class _ComunidadeScreenState extends State<ComunidadeScreen> {

  // Function to show the dialog for creating a new post
  void _showAddPostDialog(ComunidadeController controller) {
    final TextEditingController postContentController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Nova Postagem'),
          content: TextField(
            controller: postContentController,
            decoration: const InputDecoration(
              hintText: 'O que você está pensando?',
              border: OutlineInputBorder(),
            ),
            maxLines: 5,
            maxLength: 280, // Similar to Twitter limit
          ),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Postar'),
              onPressed: () {
                if (postContentController.text.trim().isNotEmpty) {
                  // Get mock author name (replace with actual user later)
                  const String mockAuthor = "Usuário Atual";
                  controller.adicionarPost(postContentController.text.trim(), mockAuthor);
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Postagem adicionada com sucesso!')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('A postagem não pode estar vazia.')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  // Function to build individual post cards
  Widget _buildPostCard(ComunidadePost post, ComunidadeController controller) {
    final Color primaryColor = Theme.of(context).colorScheme.primary;
    final Color cardBackgroundColor = Theme.of(context).colorScheme.surface;
    final Color textColor = Theme.of(context).colorScheme.onSurface;
    final DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm', 'pt_BR');

    return Card(
      color: cardBackgroundColor,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: primaryColor.withOpacity(0.2),
                  child: Icon(Icons.person, color: primaryColor),
                  // backgroundImage: post.authorAvatarUrl != null ? NetworkImage(post.authorAvatarUrl!) : null,
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.authorName,
                      style: TextStyle(fontWeight: FontWeight.bold, color: textColor, fontSize: 16),
                    ),
                    Text(
                      formatter.format(post.timestamp),
                      style: TextStyle(fontSize: 12, color: textColor.withOpacity(0.6)),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              post.content,
              style: TextStyle(color: textColor.withOpacity(0.9), fontSize: 14, height: 1.4),
            ),
            const SizedBox(height: 16),
            Divider(color: textColor.withOpacity(0.1)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInteractionButton(Icons.thumb_up_outlined, "${post.likes}", () {
                  controller.curtirPost(post.id); // Call controller method
                }),
                _buildInteractionButton(Icons.comment_outlined, "${post.commentsCount}", () {
                  // TODO: Implement comment functionality/navigation
                  print('Comment button pressed for post ${post.id}');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Funcionalidade de Comentários (Placeholder)')),
                  );
                }),
                _buildInteractionButton(Icons.share_outlined, "Compartilhar", () {
                  // TODO: Implement share functionality
                  print('Share button pressed for post ${post.id}');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Funcionalidade de Compartilhar (Placeholder)')),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget for interaction buttons (Like, Comment, Share)
  Widget _buildInteractionButton(IconData icon, String label, VoidCallback onPressed) {
    final Color textColor = Theme.of(context).colorScheme.onSurface;
    return TextButton.icon(
      icon: Icon(icon, size: 18, color: textColor.withOpacity(0.7)),
      label: Text(
        label,
        style: TextStyle(fontSize: 12, color: textColor.withOpacity(0.7)),
      ),
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).colorScheme.primary;
    final Color onPrimaryColor = Theme.of(context).colorScheme.onPrimary;

    // Use Consumer to listen to changes in ComunidadeController
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comunidade'),
        backgroundColor: primaryColor,
        foregroundColor: onPrimaryColor,
      ),
      body: Consumer<ComunidadeController>(
        builder: (context, controller, child) {
          final posts = controller.getPosts(); // Get the latest list of posts
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              // Pass the controller to the card builder
              return _buildPostCard(posts[index], controller);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Access the controller via Provider to add a post
          final controller = Provider.of<ComunidadeController>(context, listen: false);
          _showAddPostDialog(controller);
        },
        backgroundColor: primaryColor,
        foregroundColor: onPrimaryColor,
        tooltip: 'Nova Postagem',
        child: const Icon(Icons.edit),
      ),
    );
  }
}

