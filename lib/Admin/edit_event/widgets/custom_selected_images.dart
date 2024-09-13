import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/edit_event_controller_test.dart';

class EditCustomSelectedImeges extends GetView<EditEventControllerImp> {
  const EditCustomSelectedImeges({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      height: size.width * 0.3,
      child: ListView.builder(
        itemBuilder: (ctx, i) {
          return controller.media[i].isVideo!
              ? Container(
                  width: size.width * 0.3,
                  height: size.width * 0.3,
                  margin: const EdgeInsets.only(
                      right: 15, bottom: 10, top: 10),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: MemoryImage(controller.media[i].thumbnail!),
                        fit: BoxFit.fill),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: CircleAvatar(
                              child: IconButton(
                                onPressed: () {
                                  controller.media.removeAt(i);
                                  controller.update();
                                },
                                icon: const Icon(Icons.close),
                              ),
                            ),
                          )
                        ],
                      ),
                      const Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.slow_motion_video_rounded,
                          color: Colors.white,
                          size: 40,
                        ),
                      )
                    ],
                  ),
                )
              : Container(
                  width: size.width * 0.3,
                  height: size.width * 0.3,
                  margin: const EdgeInsets.only(
                      right: 15, bottom: 10, top: 10),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: FileImage(controller.media[i].image!),
                        fit: BoxFit.fill),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: CircleAvatar(
                              child: IconButton(
                                onPressed: () {
                                  controller.media.removeAt(i);
                                  controller.update();
                                },
                                icon: const Icon(Icons.close),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                );
        },
        itemCount: controller.media.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
