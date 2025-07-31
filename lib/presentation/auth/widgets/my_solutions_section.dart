import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resolution_app/presentation/auth/controllers/my_profile_controller.dart';
import 'package:resolution_app/presentation/auth/widgets/indicator_graph.dart';
import 'package:resolution_app/presentation/auth/widgets/line_chart.dart';
import 'package:resolution_app/presentation/commom_widgets/MyFormButton.dart';

class MySolutionsSection extends StatefulWidget {
  const MySolutionsSection({super.key});

  @override
  State<MySolutionsSection> createState() => _MySolutionsSectionState();
}

class _MySolutionsSectionState extends State<MySolutionsSection> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyProfileController>(
      builder: (context, controller, child) {
        final theme = Theme.of(context);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          "Estatísticas das minhas Soluções mais recentes",
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          height: 250,
                          child: MyLineChart(
                            data: controller.dataSolutions ?? [],
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IndicatorGraph(
                              color: theme.primaryColorDark,
                              text: 'Likes',
                            ),
                            const SizedBox(width: 20),
                            IndicatorGraph(
                              color: theme.colorScheme.error,
                              text: 'Dislikes',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                controller.seeSolutions == false
                    ? MyFormButton(
                        text: "Ver minhas Soluções",
                        onPressed: controller.handleSeeSolutions,
                        isLoading: controller.solutionsLoading,
                      )
                    : const SizedBox(height: 0),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.solutions?.length,
                  itemBuilder: (context, index) {
                    final solution = controller.solutions?[index];
                    if (solution == null) return null;
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        solution.problemTitle,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: theme.textTheme.bodySmall
                                            ?.copyWith(
                                              color: theme.primaryColorDark,
                                            ),
                                      ),
                                      Text(
                                        solution.title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: theme.textTheme.titleMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                (solution.approved == true
                                    ? Icon(
                                        Icons.verified,
                                        color: theme.primaryColor,
                                      )
                                    : VerticalDivider()),
                                IconButton(
                                  onPressed: controller.deleteSolution,
                                  icon: Icon(Icons.delete_forever),
                                  color: theme.colorScheme.error,
                                ),
                              ],
                            ),
                            Text(
                              solution.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodyMedium,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.thumb_up_alt_outlined,
                                      color: theme.primaryColor,
                                    ),
                                    SizedBox(width: 4),
                                    Text(solution.likes.toString()),
                                    SizedBox(height: 20, width: 24),
                                    Icon(
                                      Icons.thumb_down_alt_outlined,
                                      color: theme.colorScheme.error,
                                    ),
                                    SizedBox(width: 4),
                                    Text(solution.dislikes.toString()),
                                  ],
                                ),
                                Text(
                                  solution.createdAt.toLocal().toString().split(
                                    ' ',
                                  )[0],
                                  style: theme.textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
