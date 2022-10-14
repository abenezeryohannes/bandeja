import 'package:feekpadel/src/core/widgets/image.form.dart';
import 'package:feekpadel/src/main/presentation/profile/widgets/mine.post.card.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(context),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Center(
                child: ImageForm(
                  imageLink: "",
                  placeholder: Image.asset(
                    "assets/icons/user_account.png",
                    height: 100,
                  ),
                  onUpload: (x) {},
                  isLoading: (loading) {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text("BoAli",
                    style: Theme.of(context).textTheme.titleMedium),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text("+965 50606050",
                    style: Theme.of(context).textTheme.bodyText2),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 60),
                child: InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 40,
                        ),
                        Image.asset(
                          "assets/icons/calendar-clock.png",
                          height: 20,
                          width: 20,
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        Text("My Booking",
                            style: Theme.of(context).textTheme.bodyText2),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 40,
                        ),
                        Image.asset(
                          "assets/icons/tennis.png",
                          height: 20,
                          width: 20,
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        Text("My Courts",
                            style: Theme.of(context).textTheme.bodyText2),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              _myPosts(context),
            ],
          ),
        ));
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      centerTitle: true,
      title: Text("My Profile", style: Theme.of(context).textTheme.titleMedium),
      actions: [
        Stack(alignment: Alignment.center, children: [
          Align(
            alignment: const Alignment(0, 0),
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Image.asset(
                "assets/icons/bell.png",
                height: 30,
                width: 24,
              ),
            ),
          )
        ])
      ],
    );
  }

  _myPosts(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "My Posts",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              TextButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Icon(
                      Icons.add,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    Text("Add",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                  ],
                ),
              )
            ],
          ),
        ),
        // ListView(
        //   shrinkWrap: true,
        //   scrollDirection: Axis.horizontal,
        //   children: [MyPostCard()],
        // )
        Row(
          children: const [
            SizedBox(
              width: 10,
            ),
            MinePostCard(),
          ],
        )
      ],
    );
  }
}
