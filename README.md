# Backend-Controle_de_Relatorios
Backend do sistema de alunos utilizando o framework Yesod.

Rotas/funcionalidades a serem implementadas:


Lista de alunos: receber um json com os alunos da disciplina e exibir.
rota: /alunos

Calendário da disciplina: receber a planilha da disciplina e exibir.
rota: /cronograma

Relatório geral: receber um JSON via rest e exibir.
rota: /notas

Relatório de cada atividade: receber um JSON via REST gerado pela correção automática das atividadades e exibir. O link para essa exibição deve estar na célula da atividade correspondente no cronograma.
rota: /report?id=XXXX
