# HMV Challenge - HMV Assist App

Projeto em Flutter desenvolvido para o Challenge da FIAP com o Hospital Moinhos de Ventos.

## Preparando ambiente local

### Instalando o Flutter

Para instalar o Flutter, basta abrir o seguinte endereço: [Install Flutter](https://docs.flutter.dev/get-started/install)

### Preparando o editor de texto

Para preparar um editor de texto para o Flutter, basta seguir as instruções deste endereço: [Set up an editor](https://docs.flutter.dev/get-started/editor?tab=androidstudio)

### Executando o projeto localmente

Para executar o projeto localmente, basta seguir os passos descritos neste endereço, de acordo com o editor escolhido: [Run the app](https://docs.flutter.dev/get-started/test-drive?tab=androidstudio)

## Sobre a app

Para o projeto do Challenge HMV, foi desenvolvido uma app em Flutter, no qual foi implementado a funcionalidade de agendamentos de consultas médicas online.

Na app foram desenvolvidas 4 telas:

- **Login**: Tela apenas visual, sem conexão com backend, possui apenas validação que verifica se os campos "Usuário" e "Senha" estão preenchidos para liberar o botão de "Login", que apenas redireciona para a tela principal "Meus Agendamentos". 
- **Meus Agendamentos**: Nessa tela é mostrada os agendamentos do usuário. Possui um calendário com marcação dos dias que o usuário possui um agendamento ou os dias nos quais passou por alguma consulta. Ao tocar em um dia com eventos, será mostrado abaixo, os eventos daquele dia. Possui também um botão de "+" para fazer um novo agendamento, redirecionando para a tela de "Novo Agendamento"
- **Novo Agendamento**: Essa tela é dividida em duas partes.
  - **Parte 1**: Após o usuário clicar em "+" na tela de "Meus Agendamentos" ele será redirecionado para esta tela, onde será mostrado uma lista de especialidades médicas, no qual ele deve escolher uma para seguir para a próxima parte.
  - **Parte 2**: Após escolher uma especialidade, o usuário é redirecionando para essa segunda parte, no qual é mostrado um filtro de período de datas e de médico e uma lista de agendas livres para o período e médico escolhidos. Uma vez escolhido um horário, é mostrado uma mensagem de confirmação e caso seja confirmado e feito o agendamento com sucesso, o usuário é redirecionado novamente para a tela "Meus Agendamentos"
