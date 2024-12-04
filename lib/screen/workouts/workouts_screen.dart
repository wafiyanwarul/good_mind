import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";
import "package:good_mind/widgets/body_part_list_widget.dart";
import "package:good_mind/theme/app_theme.dart";
import "package:provider/provider.dart";
import "../../controllers/exercise_controller.dart";
import "../../widgets/exercise_widget.dart";
import "../exercise/exercise_detail_screen.dart";

class WorkoutsScreen extends StatefulWidget {
  const WorkoutsScreen({super.key});

  @override
  State<WorkoutsScreen> createState() => _WorkoutsScreenState();
}

class _WorkoutsScreenState extends State<WorkoutsScreen> {
  // TextEditingController for search field
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final exerciseController = Provider.of<ExerciseController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Workouts",
          style: appbarHeadingStyle,
        ),
        backgroundColor: secondColor,
        centerTitle: true,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: Stack(
        children: <Widget>[
          // Search Bar
          Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 5),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: secondColor, width: 2),
                    ),
                    child: Row(
                      children: [
                        // Leading icon (Search icon)
                        const Icon(
                          CupertinoIcons.search,
                          color: secondColor,
                          size: 30,
                        ),
                        const SizedBox(width: 10),
                        // TextField (Search Bar)
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            onChanged: (value) {
                              exerciseController
                                  .searchExercises(value); // Pemanggilan search
                            },
                            style: const TextStyle(
                              color: secondColor,
                              fontSize: 17,
                            ),
                            decoration: const InputDecoration(
                              hintText: "Search workout training",
                              hintStyle: TextStyle(
                                color: secondColor,
                                fontSize: 17,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        // Clear icon (to reset search)
                        IconButton(
                          icon: const Icon(
                            Icons.clear,
                            color: secondColor,
                          ),
                          onPressed: () {
                            // Clear the search input in the controller
                            _searchController.clear();
                            exerciseController
                                .searchExercises(''); // Reset search
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 0.5),
                ],
              )),
          // Main Content
          Padding(
            padding: const EdgeInsets.only(top: 70), // Offset untuk search bar
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  Text(
                    "Body Part List",
                    style: mainHeadingStyle,
                  ),
                  const SizedBox(height: 15),
                  const BodyPartListWidget(),
                  const SizedBox(height: 20),
                  Text(
                    "Exercises",
                    style: mainHeadingStyle,
                  ),
                  const SizedBox(height: 15),
                  Expanded(
                    child: ListView(
                      // padding: const EdgeInsets.all(10),
                      children: [
                        ExerciseWidget(
                          onTapExercise: (exercise) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ExerciseDetailScreen(exercise: exercise),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
