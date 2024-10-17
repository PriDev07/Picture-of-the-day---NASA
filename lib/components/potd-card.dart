import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nasa_api/components/desc-text.dart';
import 'package:nasa_api/models/potd.dart';
import 'package:shimmer/shimmer.dart';

class PotdCard extends StatefulWidget {
  const PotdCard({
    super.key,
    required this.potd,
  });

  final List<Potd>? potd;

  @override
  State<PotdCard> createState() => _PotdCardState();
}

class _PotdCardState extends State<PotdCard> {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.potd?.length,
      itemBuilder: (BuildContext context, int index) {
        final currentPotd = widget.potd![index];
        
        return Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: currentPotd.mediaType == MediaType.IMAGE
                        ? NetworkImage(currentPotd.url)
                        : null,
                    backgroundColor: Colors.grey[200],
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentPotd.copyright != null
                              ? currentPotd.copyright!.replaceAll('\n', '')
                              : 'No copyright',
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                        Text(currentPotd.title,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 5),
                        Text(DateFormat('yyyy-MM-dd')
                            .format(currentPotd.date)),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              DescriptionTextWidget(text: currentPotd.explanation),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: currentPotd.mediaType == MediaType.IMAGE
                    ? Stack(
                        children: [
                          Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              width: double.infinity,
                              height: 200,
                              color: Colors.white,
                            ),
                          ),
                          Image.network(
                            currentPotd.url,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 200,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child; // Image loaded
                              } else {
                                return Container(); // Shimmer will be shown until the image loads
                              }
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.error); // Handle image load error
                            },
                          ),
                        ],
                      )
                    :null
                        
              )
            ],
          ),
        );
      },
    );
  }
}
