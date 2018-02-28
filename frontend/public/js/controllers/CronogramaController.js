angular.module('app').controller('CronogramaController',
  function($scope) {

     $scope.cronograma = [
      {
        idAula: "A01",
        nome: "Aula inicial",
        descricao: "Aula explicando os conceitos de programação funcional e Haskell",
        data_liberacao: "09/10/2017 14:00:00",
        data_limite_envio: "09/10/2017 16:00:00",
        data_limite_envio_atrasado: "11/10/2017 14:00:00",
        monitores: "Maquiavel",
        data_inicio_correcao: "12/10/2017 14:00:00",
        data_entrega_correcao: "19/10/2017 14:00:00",
        link_videoAula: "http://youtu.be/uoO_Cn_xmmk?hd=1"
      },
      {
        idAula: "A02",
        nome: "Types e Typeclasses",
        descricao: "Explicação dos conceitos de Types e Typeclasses em Haskell",
        data_liberacao: "09/10/2017 14:00:00",
        data_limite_envio: "09/10/2017 16:00:00",
        data_limite_envio_atrasado: "11/10/2017 14:00:00",
        monitores: "Rousseau",
        data_inicio_correcao: "12/10/2017 14:00:00",
        data_entrega_correcao: "19/10/2017 14:00:00",
        link_videoAula: "http://youtu.be/uoO_Cn_xmmk?hd=1"
      },
      {
        idAula: "A03",
        nome: "Aula inicial",
        descricao: "Explicação sobre o conceito de funções puras",
        data_liberacao: "09/10/2017 14:00:00",
        data_limite_envio: "09/10/2017 16:00:00",
        data_limite_envio_atrasado: "11/10/2017 14:00:00",
        monitores: "Lutero",
        data_inicio_correcao: "12/10/2017 14:00:00",
        data_entrega_correcao: "19/10/2017 14:00:00",
        link_videoAula: "http://youtu.be/uoO_Cn_xmmk?hd=1"
      },
      {
        idAula: "PP1",
        nome: "Prova prática 1",
        descricao: "Prova Pratica 1. Verifique constantemente a hora atual do servido, pois o recebimento de submissões após essa hora NÃO ACONTECERÁ! As notas da prova serão publicadas e os alunos avisados. Até isso acontecer NÃO ENTREM EM CONTATO COM OS PROFESSORES para justificar nada, querer ver a prova ou querer saber porque deu erro de compilação. Será publicado no site o horário para revisão de provas e será comentado em sala sobre a solução! Alunos NÃO devem levar nenhum código pronto. Tenham em mente os algoritmos de ordenação vistos em sala de aula e suas características bem consolidadas. Vejam o vídeo abaixo para entender a solução esperada para o problema.",
        data_liberacao: "09/10/2017 14:00:00",
        data_limite_envio: "09/10/2017 16:00:00",
        data_limite_envio_atrasado: "11/10/2017 14:00:00",
        monitores: "Da Vinci",
        data_inicio_correcao: "12/10/2017 14:00:00",
        data_entrega_correcao: "19/10/2017 14:00:00",
        link_videoAula: "Vídeo explicativo---http://youtu.be/uoO_Cn_xmmk?hd=1"
      }
      ];
});
