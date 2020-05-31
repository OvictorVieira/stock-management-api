### Gerenciador de estoque de produtos

[Documentação da API Gerenciador de estoque de produtos](https://documenter.getpostman.com/view/10569183/SztEYSBb?version=latest)

[Aplicação no Heroku](https://stock-management-api.herokuapp.com/)

<img src="https://img.shields.io/static/v1?label=COVERAGE&message=100&color=green&style=for-the-badge"/> <img src="https://img.shields.io/static/v1?label=Licese&message=MIT&color=blue&style=for-the-badge"/> <img src="https://img.shields.io/static/v1?label=Ruby&message=2.6.6&color=red&style=for-the-badge&logo=RUBY"/> <img src="https://img.shields.io/static/v1?label=Ruby%20on%20Rails&message=6.0.0&color=red&style=for-the-badge&logo=Ruby"/>

### Tópicos

:small_blue_diamond: [Descrição do projeto](#descrição-do-projeto)

:small_blue_diamond: [Features](#features)

:small_blue_diamond: [Pré-requisitos](#pré-requisitos)

:small_blue_diamond: [Como subir a aplicação ](#como-rodar-a-aplicação-arrow_forward)

:small_blue_diamond: [Como executar os testes ](#como-rodar-os-testes)


## Descrição do Projeto

Desenvolver uma API para realizar a gestão de estoque de produtos.

### Features
- Cadastrar uma loja
- Login/Logout com a loja

- Listar produtos de sua loja
- Visualizar os detalhes de um produto
- Atualizar um produto
- Remover um produto

- Adicionar itens a um produto
- Remover itens de um produto

> Status do Projeto: Concluido :heavy_check_mark:

## Pré-requisitos

:warning: [Docker](https://docs.docker.com/) :whale:

:warning: [Docker compose](https://docs.docker.com/compose/) :octopus:

## Como rodar a aplicação local :arrow_forward:

No terminal, clone o projeto:

```
https://github.com/OvictorVieira/stock-management-api.git
```

Entre na pasta do projeto:

```
cd stock-management-api/
```

Vamos criar nosso arquivo `.env` com as variáveis de ambiente necessárias:

*PS.: O arquivo credentials do projeto está criptografado, para ter a chave, entre em contato.*

```
RAILS_MASTER_KEY=

```

Para facilitar a construção dos containers da aplicação, nós criamos um script para você executar
em seu terminal.

Execute o comando abaixo:

No final da execução do script, você estará dentro do container da aplicação `stock-management-api`:

```
bash ./docker-setup.sh
```

Para acessar o container e desenvolver dentro do mesmo no seu dia a dia, basta executar o script a seguir:

```
bash ./initiate-work.sh
```

Fora do container, para verificar se as imagens estão executando rode o comando:

```
docker ps
```

Aparacerá três containers: pgadmin, postgres e stock-management-api.

PS.: Você pode instalar o gerenciador de containers [Portainer](https://www.portainer.io/installation/) 
se quiser, é um gerenciador visual dos containers.

Assim como o script de criação da aplicação, criamos um para instalar as dependências da aplicação e configuração do 
banco de dados.

Dentro do container, rode o script através do comando abaixo:

```
bash ./application-setup.sh
```

Para configurar o banco de dados, em seu browser acesse o [Pgadmin](http://localhost:16543/), usaremos as seguintes credenciais:

| email  | senha  |
| ------------ | ------------ |
|  user@gmail.com | SmA2020!  |

Em `Serves` clique com o botão direito do mouse e clique na opção `Create` :arrow_right: `Servers`

Abrirá uma tela e devemos colocar as seguintes informações:

| Campo  | Valor  | Aba  |
| ------------ | ------------ | ------------ |
|  Name | Stock Management Api  | General  |
| Host name/connection  |  postgres | Connection  |
| Username |  user | Connection  |
| Password  |  SmA2020! | Connection  |

Clicar no botão :floppy_disk: `Save`

Em seguida clique em cima de `Databases`, serão carregados os bancos da aplicação, tanto de teste quanto de desenvolvimento.

A aplicação utiliza o puma como server, então para subir a aplicação, execute o comando abaixo:

`puma -p 3000`

E acesse a url: `localhost:3000`

## Como executar os testes

Basta executar o RSPEC através do comando:

```
$ rspec
```

## CI/CD

A aplicação está hospedada no Heroku e o deploy foi feito através das 
[Actions](https://github.com/OvictorVieira/stock-management-api/actions) do Github.

## Arquitetura do Banco de Dados

Inicialmente seria adotado um modelo de relacionamento **1 x 1** entre as tabelas de **Store** e **Products**, porém isso iria
levar a um problema de concorrência, pois teriamos muitos tratamentos no código para evitar a concorrência.
Com isso, foi adotado um modelo diferente de relacionamento, um modelo **N x N**, onde temos uma loja com seus produtos 
e uma tabela gerada pelo relacionamento `n x n` que contém o estoque dos produtos.
Para evitar a concorrência neste modelo, adicionei uma "tag" em cada movimentação de item do produto, 
teriamos a quantidade de itens que foram adicionados e quantos itens foram removidos, mantendo um histórico da movimentação
dos itens do produto e calculamos a quantidade de itens em tempo real.

## Linguagens, dependencias e libs utilizadas :books:

- [Ruby 2.6.6](https://www.ruby-lang.org/en/news/2020/03/31/ruby-2-6-6-released/)
- [Ruby on Rails 6.0.0](https://edgeguides.rubyonrails.org/6_0_release_notes.html)
- [Rack Cors](https://github.com/cyu/rack-cors)
- [Devise](https://github.com/heartcombo/devise)
- [Simple Token Authentication](https://github.com/gonzalo-bulnes/simple_token_authentication)
- [Active Model Serializers](https://github.com/rails-api/active_model_serializers)
- [kaminari](https://github.com/kaminari/kaminari)

## Licença

The [MIT License]() (MIT)

Copyright :copyright: 2020 - Gerenciado de estoque
