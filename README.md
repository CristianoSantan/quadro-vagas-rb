# Quadro de Vagas - Ruby

Este projeto é uma aplicação de quadro de vagas desenvolvida em Ruby on Rails. Ele permite a publicação e gerenciamento de vagas de emprego.

## Requisitos

- Docker
- Docker Compose

## Configuração e Execução com Docker

### 1. Clonar o repositório
```bash
git clone https://github.com/rubinostrilhos/quadro-vagas-rb.git
cd quadro-vagas-rb
```

### 2. Construir e subir os containers
```bash
docker-compose up --build
```
Isso irá criar os containers e iniciar a aplicação junto com o banco de dados.

### 3. Criar e migrar o banco de dados
Abra um novo terminal e execute:
```bash
docker-compose exec app rails db:create db:migrate
```

### 4. Acessar a aplicação
A aplicação estará disponível em: [http://localhost:3000](http://localhost:3000)

## Comandos Úteis

### Parar os containers
```bash
docker-compose down
```

### Acessar o container do app
```bash
docker-compose exec app bash
```

### Rodar testes dentro do container
```bash
docker-compose exec app rspec
```

Se precisar de mais informações ou ajustes, fique à vontade para contribuir!

