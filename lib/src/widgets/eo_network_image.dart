import 'package:flutter/material.dart';

/// A network image loaded from EssentialOils.org.
class EoNetworkImage extends StatelessWidget {
  /// Creates a new [EoNetworkImage].
  const EoNetworkImage({
    required this.imageUrlSegment,
    super.key,
  });

  /// The URL segment to load.
  final String? imageUrlSegment;

  @override
  Widget build(BuildContext context) {
    return imageUrlSegment != null
        ? Image.network(
            alignment: Alignment.centerRight,
            'https://essentialoils.org/${imageUrlSegment!}',
            errorBuilder: (_, _, _) => const SizedBox.shrink(),
            loadingBuilder: (_, child, loadingProgress) {
              // Done loading.
              if (loadingProgress == null) return child;

              // Ambiguous file size.
              if (loadingProgress.expectedTotalBytes == null) {
                return const CircularProgressIndicator();
              }

              // Show real-time progress.
              final progressPercent =
                  loadingProgress.cumulativeBytesLoaded /
                  loadingProgress.expectedTotalBytes!;

              return CircularProgressIndicator(
                value: progressPercent,
              );
            },
          )
        : const Text('N/A');
  }
}
