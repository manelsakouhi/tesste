import 'dart:io';
import 'dart:typed_data';

class EventMediaModel {
  final File? image;
  final File? video;
  final Uint8List? thumbnail;
  final bool isVideo;

  EventMediaModel({
    this.image,
    this.video,
    this.thumbnail,
    required this.isVideo,
  });

  Map<String, dynamic> toMap() {
    return {
      'isVideo': isVideo,
      'url': isVideo ? video?.path : image?.path,
      'thumbnail': isVideo && thumbnail != null ? thumbnail : null,
    };
  }

  factory EventMediaModel.fromMap(Map<String, dynamic> map) {
    return EventMediaModel(
      isVideo: map['isVideo'] ?? false,
      video: map['isVideo'] ? File(map['url']) : null,
      image: !map['isVideo'] ? File(map['url']) : null,
      thumbnail: map['thumbnail'] != null ? Uint8List.fromList(List<int>.from(map['thumbnail'])) : null,
    );
  }
}
