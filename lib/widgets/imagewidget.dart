import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final Widget error;
  final backdrop;
  final quality;
  final double loadingHeight;

  const ImageWidget(
      {Key key,
      this.error = const Center(
        child: Icon(Icons.error),
      ),
      this.backdrop,
      this.quality,
      this.loadingHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var url = "https://image.tmdb.org/t/p/$quality$backdrop";
    return Image.network(
      url,
      // width: double.infinity,
      fit: BoxFit.contain,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent loadingProgress) {
        if (loadingProgress == null) return child;
        return loadingHeight==null? Center(
         child: CircularProgressIndicator(
           value: loadingProgress.expectedTotalBytes != null
               ? loadingProgress.cumulativeBytesLoaded /
                   loadingProgress.expectedTotalBytes
               : null,
         ),
          ): Container(
          height: loadingHeight??double.minPositive,
          child: Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes
                  : null,
            ),
          ),
        );
      },
      errorBuilder: (context, obj, e) {
        return error;
      },
    );
  }
}
