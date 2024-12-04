import 'package:flutter/material.dart';
import 'package:good_mind/theme/app_theme.dart';
import 'package:good_mind/widgets/custom_app_bar.dart';
import 'package:good_mind/widgets/custom_card.dart';
import 'package:good_mind/widgets/profile_widget/profile_section.dart';
import 'package:good_mind/widgets/search_field_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'GoodMind',
      ),
      body: ListView(children: [
        Container(
          width: MediaQuery.of(context).size.width,
          // height: MediaQuery.of(context).size.height * 0.27,
          decoration: const BoxDecoration(
            color: secondColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 20,
            ),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/profile-screen');
                  },
                  child: Column(
                    children: [
                      // Profile Section - Custom Widget
                      const ProfileSection(
                        name: 'Wafiy Anwarul Hikam',
                        imageUrl: 'assets/images/profile_user.jpg',
                        membershipStatus: 'Pro Member',
                      ),
                      const SizedBox(height: 20),
                      SearchFieldWidget(
                        hintText: "Search something...",
                        onSubmitted: (value) {
                          // print("Search submitted: $value");
                        },
                        onChanged: (value) {
                          // print("Search changed: $value");
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // const SizedBox(height: 30),
        Container(
          // color: Colors.amber,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Health Score",
                style: mainHeadingStyle,
              ),
              const SizedBox(height: 15),
              // Good Mind Score
              CustomCard(
                title: "GoodMind Score",
                description:
                    "Based on your data, we think your health status is above average",
                icon: Icons.score,
                iconColor: secondColor,
                containerColor: Colors.green.shade400,
                onTap: () {},
              ),
              const SizedBox(height: 20),
              // Sub-Title for Container Categories - Food Stations
              Text(
                "Food Station",
                style: mainHeadingStyle,
              ),
              const SizedBox(height: 15),
              // Recipe Analyzer
              CustomCard(
                title: "Recipe Analyzer",
                description: "Analyze your daily food recipe nutrients here",
                icon: FontAwesomeIcons.bowlFood,
                iconColor: secondColor,
                containerColor: const Color.fromARGB(
                    255, 175, 255, 69), // Custom container color
                onTap: () {
                  Navigator.pushNamed(context, '/single-food-analyzer-screen');
                },
              ),
              const SizedBox(height: 20),
              // Sub-Title for Container Categories - Activity Tracker
              Text("Healthy Activity", style: mainHeadingStyle),
              const SizedBox(height: 15),
              // Workouts
              CustomCard(
                title: "Workouts",
                description: "Build your healthy body with home workouts",
                icon: Icons.sports,
                iconColor: secondColor,
                containerColor: Colors.greenAccent,
                onTap: () {
                  Navigator.pushNamed(context, '/workouts-screen');
                },
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
