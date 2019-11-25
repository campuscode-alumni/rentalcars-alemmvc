# Rental Cars

Rental Cars é um projeto de sistema administrativo de uma empresa que aluga
carros para o público em geral. O foco do sistema é gerenciar a frota de carros,
os clientes e as unidades (filiais) da empresa.


## Como iniciar o projeto

Para executar esse projeto você deve ter um computador, preferencialmente com
Linux, com a linguagem de programação Ruby na versão 2.6.3

Dentro do diretório do projeto, você deve instalar as dependências definidas no
arquivo `Gemfile` com o comando `bundle install`.

Com todas dependências instaladas, execute `rails server` e acesse
`localhost:3000` em seu navegador.


## Executando os testes

Com todas dependências instaladas, como descrito na seção anterior, em seu
terminal execute `rspec`.

## Principais Características e Funcionalidades

- O projeto RentalCars é focado somente nos funcionários da empresa de locação,
  servindo como um sistema interno e não como um site onde os clientes podem
agendar locações
- O sistema administra o cadastro de filiais (subsidiaries) 
- O sistema gerencia categorias de carros e modelos de carros disponíveis para
  locação, sem distinção de filiais
- A categoria de um carro define seu preço padrão de locação, no entanto é
  possívei customizar os preços de locação por filial
- Um carro da frota deve ser sempre vinculado a um a filial
- Uma locação deve ser agendada, definindo o cliente, as datas de retirada e
  devolução e a categoria de carro. Nesse momento é feita uma validação de que
existem carros disponíveis no período escolhido.
- Ao finalizar o agendamento é gerado um código único da locação
- Ao iniciar a locação, deve ser escolhido o carro de acordo com a categoria
  escolhida
- Uma locação deve ser composta de ao menos um carro e 0 ou N acessórios
  adicionais (AddOns)

