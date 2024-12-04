import 'package:flutter/material.dart';
import 'package:good_mind/theme/app_theme.dart';
import '../../widgets/profile_widget/profile_about_widget.dart';
import '../../widgets/profile_widget/profile_info_field_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondColor,
        centerTitle: true,
        title: Text("User Profile", style: appbarHeadingStyle),
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
      ),
      body: ListView(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 100,
                decoration: const BoxDecoration(
                  color: secondColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
              ),
              const Positioned(
                top: 35,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 65,
                      backgroundImage: AssetImage(
                        'assets/images/profile_user.jpg',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 70),
          const ProfileAboutWidget(
            name: "Wafiy Anwarul Hikam",
            subtitle: "220605110022 | Software Engineer | Musician",
            about:
                "Hello all, my name is Wafiy Anwarul Hikam. I'm currently studying at Informatics Engineering UIN Maulana Malik Ibrahim Malang. I have a passion on Software Engineering",
          ),
          const SizedBox(height: 20),

          // Profile Button Groups
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: secondColor, // Teks putih
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50), // Sudut melengkung
                  ),
                ),
                child: const Text(
                  "Back to Home Page",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  foregroundColor: secondColor,
                  backgroundColor: Colors.white, // Teks merah
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  side: const BorderSide(
                      color: secondColor, width: 2), // Border merah
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50), // Sudut melengkung
                  ),
                ),
                child: const Text(
                  "Edit Profile",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                ProfileInfoFieldWidget(
                  icon: Icons.phone_android,
                  label: "Phone Number",
                  data: "6289567891234",
                ),
                SizedBox(height: 10),
                ProfileInfoFieldWidget(
                  icon: Icons.email_rounded,
                  label: "Email",
                  data: "wafiyanwarulhikam@gmail.com",
                ),
                SizedBox(height: 10),
                ProfileInfoFieldWidget(
                  icon: Icons.location_on_rounded,
                  label: "Location",
                  data: "Malang, Indonesia",
                ),
                SizedBox(height: 10),
                ProfileInfoFieldWidget(
                  icon: Icons.account_box,
                  label: "Account Type",
                  data: "USER",
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
