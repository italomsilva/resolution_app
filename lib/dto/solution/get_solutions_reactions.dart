class SolutionFeedbackChartData {
  final String solutionTitle;
  final int likes;
  final int dislikes;
  final DateTime createdAt;

  SolutionFeedbackChartData({
    required this.solutionTitle,
    required this.likes,
    required this.dislikes,
    required this.createdAt,
  });
}

Future<List<SolutionFeedbackChartData>> getMockSolutionsReactionsData() async {
  // Simula um atraso de rede de 3 segundos
  await Future.delayed(const Duration(seconds: 3));

  return [
    SolutionFeedbackChartData(
      solutionTitle: 'Reparo Tubulação Principal',
      likes: 45,
      dislikes: 5,
      createdAt: DateTime.parse('2025-07-25T10:30:00Z'),
    ),
    SolutionFeedbackChartData(
      solutionTitle: 'Fechamento de Buraco em Via',
      likes: 30,
      dislikes: 10,
      createdAt: DateTime.parse('2025-07-24T14:00:00Z'),
    ),
    SolutionFeedbackChartData(
      solutionTitle: 'Troca de Lâmpada Pública',
      likes: 62,
      dislikes: 2,
      createdAt: DateTime.parse('2025-07-23T18:15:00Z'),
    ),
    SolutionFeedbackChartData(
      solutionTitle: 'Plano de Coleta de Lixo',
      likes: 18,
      dislikes: 15,
      createdAt: DateTime.parse('2025-07-22T09:45:00Z'),
    ),
    SolutionFeedbackChartData(
      solutionTitle: 'Poda de Árvore Risco',
      likes: 50,
      dislikes: 3,
      createdAt: DateTime.parse('2025-07-21T11:00:00Z'),
    ),
    SolutionFeedbackChartData(
      solutionTitle: 'Reforma de Calçada',
      likes: 25,
      dislikes: 8,
      createdAt: DateTime.parse('2025-07-20T16:20:00Z'),
    ),
    SolutionFeedbackChartData(
      solutionTitle: 'Otimização Semáforo',
      likes: 40,
      dislikes: 1,
      createdAt: DateTime.parse('2025-07-19T08:00:00Z'),
    ),
    SolutionFeedbackChartData(
      solutionTitle: 'Limpeza de Grafites',
      likes: 35,
      dislikes: 7,
      createdAt: DateTime.parse('2025-07-18T13:30:00Z'),
    ),
    SolutionFeedbackChartData(
      solutionTitle: 'Plano Saneamento Esgoto',
      likes: 58,
      dislikes: 12,
      createdAt: DateTime.parse('2025-07-17T07:40:00Z'),
    ),
    SolutionFeedbackChartData(
      solutionTitle: 'Desobstrução Beco Escuro',
      likes: 20,
      dislikes: 5,
      createdAt: DateTime.parse('2025-07-16T19:00:00Z'),
    ),
        SolutionFeedbackChartData(
      solutionTitle: 'Reparo Tubulação Principal',
      likes: 45,
      dislikes: 5,
      createdAt: DateTime.parse('2025-07-25T10:30:00Z'),
    ),
    SolutionFeedbackChartData(
      solutionTitle: 'Fechamento de Buraco em Via',
      likes: 30,
      dislikes: 10,
      createdAt: DateTime.parse('2025-07-24T14:00:00Z'),
    ),
    SolutionFeedbackChartData(
      solutionTitle: 'Troca de Lâmpada Pública',
      likes: 62,
      dislikes: 2,
      createdAt: DateTime.parse('2025-07-23T18:15:00Z'),
    ),
    SolutionFeedbackChartData(
      solutionTitle: 'Plano de Coleta de Lixo',
      likes: 18,
      dislikes: 15,
      createdAt: DateTime.parse('2025-07-22T09:45:00Z'),
    ),
    SolutionFeedbackChartData(
      solutionTitle: 'Poda de Árvore Risco',
      likes: 50,
      dislikes: 3,
      createdAt: DateTime.parse('2025-07-21T11:00:00Z'),
    ),
    SolutionFeedbackChartData(
      solutionTitle: 'Reforma de Calçada',
      likes: 25,
      dislikes: 8,
      createdAt: DateTime.parse('2025-07-20T16:20:00Z'),
    ),
    SolutionFeedbackChartData(
      solutionTitle: 'Otimização Semáforo',
      likes: 40,
      dislikes: 1,
      createdAt: DateTime.parse('2025-07-19T08:00:00Z'),
    ),
    SolutionFeedbackChartData(
      solutionTitle: 'Limpeza de Grafites',
      likes: 35,
      dislikes: 7,
      createdAt: DateTime.parse('2025-07-18T13:30:00Z'),
    ),
    SolutionFeedbackChartData(
      solutionTitle: 'Plano Saneamento Esgoto',
      likes: 58,
      dislikes: 12,
      createdAt: DateTime.parse('2025-07-17T07:40:00Z'),
    ),
    SolutionFeedbackChartData(
      solutionTitle: 'Desobstrução Beco Escuro',
      likes: 20,
      dislikes: 5,
      createdAt: DateTime.parse('2025-07-16T19:00:00Z'),
    ),
    SolutionFeedbackChartData(
      solutionTitle: 'Reparo Tubulação Principal',
      likes: 45,
      dislikes: 5,
      createdAt: DateTime.parse('2025-07-25T10:30:00Z'),
    ),
    SolutionFeedbackChartData(
      solutionTitle: 'Fechamento de Buraco em Via',
      likes: 30,
      dislikes: 10,
      createdAt: DateTime.parse('2025-07-24T14:00:00Z'),
    ),
    SolutionFeedbackChartData(
      solutionTitle: 'Troca de Lâmpada Pública',
      likes: 62,
      dislikes: 2,
      createdAt: DateTime.parse('2025-07-23T18:15:00Z'),
    ),
    SolutionFeedbackChartData(
      solutionTitle: 'Plano de Coleta de Lixo',
      likes: 18,
      dislikes: 15,
      createdAt: DateTime.parse('2025-07-22T09:45:00Z'),
    ),
    SolutionFeedbackChartData(
      solutionTitle: 'Poda de Árvore Risco',
      likes: 50,
      dislikes: 3,
      createdAt: DateTime.parse('2025-07-21T11:00:00Z'),
    ),
    SolutionFeedbackChartData(
      solutionTitle: 'Reforma de Calçada',
      likes: 25,
      dislikes: 8,
      createdAt: DateTime.parse('2025-07-20T16:20:00Z'),
    ),
    SolutionFeedbackChartData(
      solutionTitle: 'Otimização Semáforo',
      likes: 40,
      dislikes: 1,
      createdAt: DateTime.parse('2025-07-19T08:00:00Z'),
    ),
    SolutionFeedbackChartData(
      solutionTitle: 'Limpeza de Grafites',
      likes: 35,
      dislikes: 7,
      createdAt: DateTime.parse('2025-07-18T13:30:00Z'),
    ),
    SolutionFeedbackChartData(
      solutionTitle: 'Plano Saneamento Esgoto',
      likes: 58,
      dislikes: 12,
      createdAt: DateTime.parse('2025-07-17T07:40:00Z'),
    ),
    SolutionFeedbackChartData(
      solutionTitle: 'Desobstrução Beco Escuro',
      likes: 20,
      dislikes: 5,
      createdAt: DateTime.parse('2025-07-16T19:00:00Z'),
    ),

  ];
}
