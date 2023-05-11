import 'package:flutter/material.dart';
import 'package:toto_android/boardview.dart';
import 'package:toto_android/colors.dart';
import 'api/post.dart';
import 'image.dart';
import 'postview.dart';
import 'textstyles.dart';
import 'package:flutter_svg/svg.dart';

class TotoUtils {
  static Padding getHeader(
      BuildContext context, String destinationName, StatefulWidget sw) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            child: const Icon(
              Icons.keyboard_backspace_sharp,
              color: TotoColors.primary,
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BoardPage(),
              ),
            ),
          ),
          SvgPicture.asset('assets/logo.svg', height: 20),
          InkWell(
            child: Text(
              destinationName,
              style: TotoTextStyles.labelMedium(context),
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => sw,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Positioned buildAccessButton(
      BuildContext context, String text, Function function) {
    return Positioned(
      bottom: MediaQuery.of(context).viewInsets.bottom,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
        child: MaterialButton(
          onPressed: () => null,
          color: TotoColors.primary,
          child: Text(
            text,
            style: TotoTextStyles.labelLarge(context),
          ),
        ),
      ),
    );
  }

  static
  Card buildPost(BuildContext context, Post post) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostViewPage(
              post:
                post
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Title(
                        color: TotoColors.textColor,
                        child: Text(
                          post.title,
                          style: TotoTextStyles.displayMedium(context),
                        ),
                      ),
                    ),
                    Title(
                      color: TotoColors.textColor,
                      child: Text(
                        post.username,
                        style: TotoTextStyles.labelMedium(context),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Title(
                      color: TotoColors.textColor,
                      child: Text(
                        'No.${post.id} ${post.date} ${post.filename}',
                        style: TotoTextStyles.labelSmall(context),
                      ),
                    ),
                    Title(
                      color: TotoColors.textColor,
                      child: Text(
                        '14 Comments',
                        style: TotoTextStyles.labelSmall(context),
                      ),
                    ),
                  ],
                ),
                InkWell(
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Image(
                        image: NetworkImage(
                            'https://i.pinimg.com/originals/87/ae/83/87ae8360cfe56fda3b49e609eb3b7c25.jpg')),
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ImagePage(
                          url:
                          'https://i.pinimg.com/originals/87/ae/83/87ae8360cfe56fda3b49e609eb3b7c25.jpg'),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      post.content,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  static
  Card buildPostComment(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Title(
                    color: TotoColors.textColor,
                    child: Text(
                      'No.4 23-05-2023 6:39 juanymedio.jpg',
                      style: TotoTextStyles.labelSmall(context),
                    ),
                  ),
                  Title(
                    color: TotoColors.textColor,
                    child: Text(
                      'JordiSoto',
                      style: TotoTextStyles.labelMedium(context),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Title(
                    color: TotoColors.textColor,
                    child: Text(
                      'OP',
                      style: TotoTextStyles.labelMedium(context),
                    ),
                  ),
                  Title(
                    color: TotoColors.textColor,
                    child: Text(
                      '14 Comments',
                      style: TotoTextStyles.labelSmall(context),
                    ),
                  ),
                ],
              ),
              InkWell(
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Image(
                      image: NetworkImage(
                          'https://pngimg.com/uploads/glass/wineglass_PNG2872.png')),
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ImagePage(
                        url:
                        'https://pngimg.com/uploads/glass/wineglass_PNG2872.png'),
                  ),
                ),
              ),
              const Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla quam velit, vulputate eu pharetra nec, mattis ac neque. Duis vulputate commodo lectus, ac blandit elit tincidunt id. Sed rhoncus, tortor sed a sidsssi',
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
      ),
    );
  }
}
