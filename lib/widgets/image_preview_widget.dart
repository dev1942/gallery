import 'dart:io';

import 'package:flutter/material.dart';

/// Widget for displaying a preview of images
class ImagePreviews extends StatelessWidget {
  /// The image paths of the displayed images
  final List<String> imagePaths;

  /*-------- Callback when an image should be removed-----------*/
  final Function(int)? onDelete;
  final Function(int)? onSelect;

  /*------- Creates a widget for preview of images. [imagePaths] can not be empty---------*/
  // and all contained paths need to be non empty.
  const ImagePreviews(this.imagePaths, {Key? key, this.onDelete, this.onSelect})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imagePaths.isEmpty) {
      return Container();
    }

    final imageWidgets = <Widget>[];

    for (var i = 0; i < imagePaths.length; i++) {
      imageWidgets.add(_ImagePreview(
        imagePaths[i],
        onDelete: onDelete != null ? () => onDelete!(i) : null,
        onSelect: onSelect != null ? () => onSelect!(i) : null,
      ));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: imageWidgets),
    );
  }
}

class _ImagePreview extends StatelessWidget {
  final String imagePath;
  final VoidCallback? onDelete;
  final VoidCallback? onSelect;

  const _ImagePreview(this.imagePath, {Key? key, this.onDelete, this.onSelect})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageFile = File(imagePath);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: <Widget>[
          InkWell(
            onTap: onSelect,
            // child: ConstrainedBox(
            //   constraints: const BoxConstraints(
            //     maxWidth: 100,
            //     maxHeight: 100,
            //   ),
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  image: DecorationImage(
                    image: FileImage(
                      imageFile,
                    ),
                    fit: BoxFit.cover,
                  )),
              // child: Image.file(
              //   imageFile,
              //   fit: BoxFit.cover,
              // )
            ),
            //),
          ),
          Positioned(
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: SizedBox(
                height: 20,
                width: 20,
                child: FloatingActionButton(
                    elevation: 0.0,
                    backgroundColor: Colors.transparent,
                    onPressed: onDelete,
                    child: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
