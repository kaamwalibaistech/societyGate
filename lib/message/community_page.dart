import 'package:flutter/material.dart';
import 'package:society_gate/constents/sizedbox.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: const Color(0xFFF0F7FF),
            body: ListView(
              children: [
                _post(context),
                _post(context),
                _post(context),
                _post(context),
                _post(context),
                _post(context),
                _post(context),
                _post(context),
                _post(context),
              ],
            )

            // SingleChildScrollView(child: _post(context)),
            ));
  }
}

Widget _post(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const ListTile(
        leading: CircleAvatar(
          foregroundImage: NetworkImage(
              "https://ui-avatars.com/api/?background=random&name=User+Names"),
        ),
        title: Text("Society Name"),
        subtitle: Text("Admin Name"),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "This is title, This is title. This is title, This is title.",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const ExpansionTile(
              title: Text(
                "This is description. This is description. This is description.",
                overflow: TextOverflow.ellipsis,
              ),
              dense: true,
              iconColor: Colors.green,
              collapsedIconColor: Colors.red,
              minTileHeight: 10,
              expandedAlignment: Alignment.topLeft,
              childrenPadding: EdgeInsets.only(left: 15, right: 10, bottom: 5),
              children: [
                Text(
                    "This is description. This is description. This is description. This is description. This is description.This is description.This is description.This is description.This is description.")
              ],
            ),
            // sizedBoxH10(context),
            SizedBox(
                height: 400,
                width: double.maxFinite,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: Image.asset(
                    'lib/assets/girlphoto1.jpg',
                    fit: BoxFit.fill,
                  ),
                )),
            Container(
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  )),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 5, left: 6),
                    child: Text("123k"),
                  ),
                  sizedBoxW5(context),
                  const Icon(
                    Icons.thumb_up_outlined,
                    color: Colors.blueGrey,
                  ),
                  sizedBoxW10(context),
                  const Padding(
                    padding: EdgeInsets.only(top: 5, left: 6),
                    child: Text("123k"),
                  ),
                  sizedBoxW5(context),
                  const Icon(
                    Icons.thumb_up_outlined,
                    color: Colors.blueGrey,
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => showCommentsBottomSheet(context),
                    child: const Icon(
                      Icons.chat,
                      color: Colors.blueGrey,
                    ),
                  ),
                  sizedBoxW15(context),
                  const Icon(
                    Icons.share,
                    color: Colors.blueGrey,
                  ),
                  sizedBoxW10(context),
                ],
              ),
            ),
            sizedBoxH5(context),
            GestureDetector(
              onTap: () => showCommentsBottomSheet(context),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      )),
                  child: Column(
                    children: [
                      commentTile(context),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("See all"),
                            Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: const Color(0xFF6B4EFF).withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.arrow_forward,
                                color: Color(0xFF6B4EFF),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
            ),
          ],
        ),
      )
    ],
  );
}

Widget commentTile(BuildContext context) {
  return const Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ListTile(
        leading: CircleAvatar(
          radius: 15,
          foregroundImage: NetworkImage(
              "https://ui-avatars.com/api/?background=random&name=User+Namez"),
        ),
        title: Text(
          "User Name",
          style: TextStyle(fontSize: 12),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 18),
        child: Text(
          "This is title, This is title. This is title, This is title.",
          style: TextStyle(fontSize: 12),
        ),
      ),
      Divider(
        color: Colors.white60,
      ),
    ],
  );
}

showCommentsBottomSheet(BuildContext ctx) {
  return showModalBottomSheet(
    context: ctx,
    showDragHandle: true,
    isScrollControlled: true,
    isDismissible: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewPadding.bottom,
        ),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 1.5,
                child: ListView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => commentTile(ctx),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue.shade100),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                margin: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Add a comment...',
                          border: InputBorder.none,
                        ),
                        maxLines: null,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Color(0xFF6B4EFF),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      );
    },
  );
}
