import 'package:english_club/core/helpers/extensions.dart';
import 'package:english_club/core/routing/routes.dart';
import 'package:english_club/features/english_club/logic/create_section_cubit.dart';
import 'package:english_club/features/english_club/logic/create_section_state.dart';

import 'package:english_club/features/english_club/logic/english_club_cubit.dart';
import 'package:english_club/features/english_club/logic/english_club_state.dart';
import 'package:english_club/features/english_club/ui/widgets/english_club_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:english_club/features/english_club/data/models/english_club_response.dart';

class Englishclub extends StatefulWidget {
  const Englishclub({super.key});

  @override
  State<Englishclub> createState() => _EnglishclubState();
}

class _EnglishclubState extends State<Englishclub> {
  String?
  _selectedSectionName; // Holds the currently selected section name for the dropdown

  @override
  void initState() {
    super.initState();
    // API Call: This line triggers the API call to fetch English Club sections.
    // The EnglishClubCubit (from english_club_cubit.dart) handles the actual network request
    // and emits different states (loading, success, error) based on the API response.
    context.read<EnglishClubCubit>().emitGetEnglishClubSections();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(Routes.RoadMap);
        },
        backgroundColor: Colors.amber,
        child: CircleAvatar(
          backgroundColor: Colors.amber,
          child: Image.asset("assets/images/road.png", fit: BoxFit.contain),
        ),
      ),
      appBar: const EnglishClubAppBar(),
      body: MultiBlocListener(
        listeners: [
          BlocListener<EnglishClubCubit, EnglishClubState>(
            listener: (context, state) {
              state.whenOrNull(
                error: (error) {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.rightSlide,
                    title: 'Error!',
                    desc: 'Failed to load sections: //',
                    btnOkOnPress: () {},
                  ).show();
                },
              );
            },
          ),
          BlocListener<CreateSectionCubit, CreateSectionState>(
            listener: (context, state) {
              state.whenOrNull(
                loading: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Creating section...')),
                  );
                },
                success: (data) {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.success,
                    animType: AnimType.rightSlide,
                    title: 'Success!',
                    desc: 'Section "${data.data!.name}" created successfully.',
                    btnOkOnPress: () {},
                  ).show();
                },
                error: (error) {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.rightSlide,
                    title: 'Error!',
                    desc: 'Failed to create section: $error',
                    btnOkOnPress: () {},
                  ).show();
                },
              );
            },
          ),
        ],
        child: BlocBuilder<EnglishClubCubit, EnglishClubState>(
          builder: (context, state) {
            return state.when(
              initial: () =>
                  const Center(child: Text('Loading English Club data...')),
              loading: () => const Center(child: CircularProgressIndicator()),
              success:
                  (
                    oxfordDominoesBookworms,
                    oxfordReadDiscover,
                    nationalGeographic,
                    listeningSkill,
                    otherSections,
                  ) {
                    // Combine all categorized sections into one map for easier access
                    final Map<String, List<ClubData>> allSectionsCategorized = {
                      'OXFORD DOMINOES & BOOKWORMS': oxfordDominoesBookworms,
                      'OXFORD READ & DISCOVER 1-6': oxfordReadDiscover,
                      'NATIONAL GEOGRAPHIC': nationalGeographic,
                      'LISTENING SKILL': listeningSkill,
                    };

                    // Add ClubData items from 'otherSections' by their sectionName
                    for (var item in otherSections) {
                      final String sectionName =
                          item.sectionName ?? "Unknown Section";
                      allSectionsCategorized
                          .putIfAbsent(sectionName, () => [])
                          .add(item);
                    }

                    // Get all available unique section names for the dropdown
                    final List<String> availableDropdownSections =
                        allSectionsCategorized.keys.toList()..sort();

                    // If _selectedSectionName is null or not in the current available sections,
                    // set it to the first available section if any.
                    if (_selectedSectionName == null ||
                        !availableDropdownSections.contains(
                          _selectedSectionName,
                        )) {
                      if (availableDropdownSections.isNotEmpty) {
                        _selectedSectionName = availableDropdownSections.first;
                      } else {
                        _selectedSectionName = null; // No sections to select
                      }
                    }

                    // Get the data for the currently selected section
                    final List<ClubData> currentSelectedClubDataList =
                        allSectionsCategorized[_selectedSectionName] ?? [];

                    // Flatten ClubData into a single list of ClubSubData for ListView.builder
                    // Each ClubSubData will correspond to a yellow box + ExpansionTile
                    final List<ClubSubData> flatSubDataList = [];
                    for (var clubDataItem in currentSelectedClubDataList) {
                      if (clubDataItem.data != null) {
                        flatSubDataList.addAll(clubDataItem.data!);
                      }
                    }

                    return Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          color: Colors.white,
                          child: Row(
                            children: [
                              const Text('Sections:'),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: _selectedSectionName,
                                      isExpanded: true,
                                      icon: const Icon(Icons.arrow_drop_down),
                                      items: availableDropdownSections
                                          .map<DropdownMenuItem<String>>((
                                            String value,
                                          ) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          })
                                          .toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          _selectedSectionName = newValue;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Display data for the currently selected section
                        if (flatSubDataList.isEmpty)
                          const Expanded(
                            child: Center(
                              child: Text(
                                'No data available for this section.',
                              ),
                            ),
                          ),

                        if (flatSubDataList.isNotEmpty)
                          Expanded(
                            child: ListView.builder(
                              itemCount: flatSubDataList.length,
                              itemBuilder: (context, index) {
                                final ClubSubData subDataItem =
                                    flatSubDataList[index];

                                // Determine the title for the ExpansionTile based on the last part of subDataItem.name
                                final String expansionTileTitle =
                                    subDataItem.name != null &&
                                        subDataItem.name!.contains('/')
                                    ? subDataItem.name!.split('/').last.trim()
                                    : subDataItem.name ?? 'Sub-Section N/A';

                                return Column(
                                  children: [
                                    // Yellow box containing ClubSubData.name (the full name)
                                    Container(
                                      width: double.infinity,
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 5,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 15,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.orange,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Text(
                                          subDataItem.name ??
                                              'Sub-Section Name N/A', // Display ClubSubData.name as is
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                    // ExpansionTile with specific part of name as title and Stories inside
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 5,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            spreadRadius: 1,
                                            blurRadius: 3,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: ExpansionTile(
                                        // ExpansionTile title is now the part of ClubSubData.name after the last '/'
                                        title: Center(
                                          child: Text(
                                            expansionTileTitle,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ),
                                        trailing: const Icon(
                                          Icons.keyboard_arrow_down,
                                        ),
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child:
                                                (subDataItem.stories != null &&
                                                    subDataItem
                                                        .stories!
                                                        .isNotEmpty)
                                                ? GridView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    gridDelegate:
                                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount: 2,
                                                          crossAxisSpacing: 8.0,
                                                          mainAxisSpacing: 8.0,
                                                          childAspectRatio: 0.7,
                                                        ),
                                                    itemCount: subDataItem
                                                        .stories!
                                                        .length,
                                                    itemBuilder:
                                                        (
                                                          BuildContext context,
                                                          int storyIndex,
                                                        ) {
                                                          final Stories
                                                          story = subDataItem
                                                              .stories![storyIndex];
                                                          return Container(
                                                            decoration: BoxDecoration(
                                                              border: Border.all(
                                                                color: Colors
                                                                    .grey
                                                                    .shade300,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    8,
                                                                  ),
                                                            ),
                                                            child: Column(
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      story.coverUrl !=
                                                                              null &&
                                                                          story
                                                                              .coverUrl!
                                                                              .isNotEmpty
                                                                      ? Image.network(
                                                                          story
                                                                              .coverUrl!,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          errorBuilder:
                                                                              (
                                                                                context,
                                                                                error,
                                                                                stackTrace,
                                                                              ) {
                                                                                // print('Error loading image for ${story.title}: '); // Uncomment for detailed error logging
                                                                                return const Center(
                                                                                  child: Column(
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: [
                                                                                      Icon(
                                                                                        Icons.broken_image,
                                                                                        size: 30,
                                                                                        color: Colors.grey,
                                                                                      ),
                                                                                      Text(
                                                                                        'Image Error',
                                                                                        style: TextStyle(
                                                                                          fontSize: 10,
                                                                                          color: Colors.grey,
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                );
                                                                              },
                                                                        )
                                                                      : const Center(
                                                                          child: Icon(
                                                                            Icons.image_not_supported,
                                                                          ),
                                                                        ),
                                                                ),
                                                                // REMOVED THE TEXT WIDGET THAT DISPLAYED story.title
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                  )
                                                : const Padding(
                                                    padding: EdgeInsets.all(
                                                      8.0,
                                                    ),
                                                    child: Text(
                                                      'No stories available for this sub-section.',
                                                    ),
                                                  ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                );
                              },
                            ),
                          ),
                      ],
                    );
                  },
              error: (error) => Center(child: Text('Error: ')),
            );
          },
        ),
      ),
    );
  }
}
