import 'package:resolution_app/models/enums/problem_status.dart';
import 'package:resolution_app/models/enums/profile_type.dart';
import 'package:resolution_app/models/enums/solution_reaction.dart';
import 'package:resolution_app/models/problems.dart';
import 'package:resolution_app/models/solution.dart';
import 'package:resolution_app/models/user.dart';

class MockData {
  static final List<User> mockUsers = [
    User(
      id: 'user1',
      name: 'João Silva',
      email: 'joao@example.com',
      document: '12345678900',
      profile: ProfileType.individual,
      login: 'joaosilva',
      password: 'password123',
      token: 'fake-jwt-token-user1',
    ),
    User(
      id: 'user2',
      name: 'Prefeitura',
      email: 'contato@prefeitura.gov.br',
      document: '1234567890001',
      profile: ProfileType.government,
      login: 'prefeitura',
      password: 'password123',
      token: 'fake-jwt-token-user2',
    ),
  ];

  static final List<Problem> mockProblems = [
    Problem(
      id: '1',
      title: 'Buraco na rua',
      description:
          'Um buraco grande na rua principal causando danos aos carros.',
      location: 'Rua Principal, 123',
      status: ProblemStatus.open,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      userId: 'user1',
    ),
    Problem(
      id: '2',
      title: 'Luz queimada',
      description: 'Poste de luz com lâmpada queimada desde segunda-feira.',
      location: 'Av. Brasil, 456',
      status: ProblemStatus.inProgress,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      userId: 'user2',
    ),
    Problem(
      id: '3',
      title: 'Vazamento de água',
      description: 'Vazamento constante na calçada, desperdiçando muita água.',
      location: 'Rua das Flores, 78',
      status: ProblemStatus.resolved,
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      userId: 'user1',
    ),
    Problem(
      id: '4',
      title: 'Árvore caída',
      description: 'Uma árvore bloqueando toda a via após a tempestade.',
      location: 'Praça Central',
      status: ProblemStatus.open,
      createdAt: DateTime.now().subtract(const Duration(days: 4)),
      userId: 'user2',
    ),
    Problem(
      id: '5',
      title: 'Calçada quebrada',
      description: 'Calçada com rachaduras perigosas para pedestres.',
      location: 'Rua das Palmeiras, 99',
      status: ProblemStatus.open,
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      userId: 'user1',
    ),
    Problem(
      id: '6',
      title: 'Falta de sinalização',
      description: 'Placa de "Pare" derrubada no cruzamento principal.',
      location: 'Esquina da Rua 5 com a 10',
      status: ProblemStatus.open,
      createdAt: DateTime.now().subtract(const Duration(days: 6)),
      userId: 'user2',
    ),
    Problem(
      id: '7',
      title: 'Lixo acumulado',
      description: 'Acúmulo de lixo em terreno baldio atraindo insetos.',
      location: 'Rua de Trás, s/n',
      status: ProblemStatus.open,
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
      userId: 'user1',
    ),
    Problem(
      id: '8',
      title: 'Semáforo intermitente',
      description: 'Sinal amarelo piscando sem parar prejudicando o trânsito.',
      location: 'Cuzamento da Av. Norte',
      status: ProblemStatus.inProgress,
      createdAt: DateTime.now().subtract(const Duration(days: 8)),
      userId: 'user2',
    ),
  ];

  static final List<Solution> mockSolutions = [
    Solution(
      id: '101',
      title: 'Tapar buraco',
      description: 'Preencher com asfalto.',
      estimatedCost: 500.0,
      approved: false,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      problemId: '1',
      userId: 'user1',
    ),
    Solution(
      id: '102',
      title: 'Trocar lâmpada',
      description: 'Trocar lâmpada com caminhão cesto.',
      estimatedCost: 150.0,
      approved: true,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      problemId: '2',
      userId: 'user2',
    ),
  ];

  static final Map<String, Map<String, SolutionReaction>> mockReactions = {};
}
