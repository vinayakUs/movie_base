import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final Widget error;
  final backdrop;
  final quality;

  const ImageWidget(
      {Key key,
      this.error = const Icon(Icons.error),
      this.backdrop,
      this.quality})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    var url ="https://image.tmdb.org/t/p/$quality$backdrop";
    print(url);
    return Image.network(
      url,
      width: double.infinity,
      fit: BoxFit.cover,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes
                : null,
          ),
        );
      },
      errorBuilder: (context, obj, e) {
        return error;
      },
    );
  }
}
