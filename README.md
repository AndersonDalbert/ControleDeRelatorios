# Controle_de_Relatorios

ATENÇÃO!

O QUE FALTA/PROBLEMAS:

1. A rota /notas no backend (/src/Handler/Notas.hs) não está convertendo a planilha em json de forma correta, apenas retorna uma lista vazia, o que impede que o front monte a tabela corretamente.

2. Falta configurar uma rota coringa no backend para exibir os reports das atividades (algo do tipo http://localhost:3000/report/:id), e depois integrá-la com o frontend já construído (public/js/controllers/ReportController.js).

3. A rota de alunos está funcionando mas por algum motivo não captura todos os estudantes da planilha, então só são exibidos alguns.
