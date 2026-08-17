# SQL Practice

Repositório destinado ao armazenamento e versionamento de scripts SQL, modelos de banco de dados e exercícios desenvolvidos ao longo da graduação.

## Visão Geral

O repositório documenta a evolução no aprendizado de Bancos de Dados Relacionais, cobrindo desde consultas fundamentais e junções até conceitos avançados de modelagem dimensional, procedures e scripts de povoamento/carga de dados.

---

## Estrutura do Repositório

sql-practice/
│
├── data_base/             # DDL/DML de carga e esquemas de dados de apoio
│   ├── Carloca.png        # Modelo do banco de dados (DER/Diagrama)
│   ├── Cria_Carloca.txt   # Script DDL de criação do banco de dados
│   └── Carrega_Carloca.txt# Script DML de povoamento e carga de dados
│
├── exercícios/            # Exercícios práticos e testes por tópico
│   ├── select_basico.sql
│   ├── funcoes_simples.sql
│   ├── join.sql
│   └── DBE - SQL - Aula 140 - Lista de Exercícios SQL MySQL.doc
│
├── semestre_1/            # Banco de Dados I — DDL, DML e Avaliações
│   ├── aluno_armario_exportado.sql
│   ├── Aulas - SQL - Carloca.sql
│   ├── aulas.sql
│   ├── EC3-questoes.sql
│   ├── EC4-questoes.sql
│   ├── EC5-questoes.sql
│   ├── P1.sql
│   ├── P2.sql
│   ├── primeira_aula.sql
│   └── Questoes.sql
│
└── semestre_2/            # Banco de Dados II — Procedures, Dimensões e MWB
    ├── create_procedure.sql
    ├── criacao_dimensao_exemplo.sql
    ├── DimProduto.sql
    ├── EC1.sql
    ├── EC2-Media-1.mwb    # Modelo MySQL Workbench
    ├── EC3.sql
    ├── logica_introducao.sql
    ├── logica1.sql
    ├── logica2.sql
    ├── P1_Tipo_2.sql
    ├── P2_Tipo_2.sql
    └── rescue.sql

---

## Conteúdo Programático

### Fundamentos & Consultas
* Definição de Dados (DDL) — CREATE, ALTER, DROP
* Manipulação de Dados (DML) — INSERT, UPDATE, DELETE
* Consultas e Filtros com SELECT, WHERE, ORDER BY
* Agregações e Agrupamentos (GROUP BY, HAVING, COUNT, SUM, AVG)
* Junções de Tabelas (INNER JOIN, LEFT JOIN, RIGHT JOIN)

### Tópicos Avançados & Modelagem
* Criação e Manipulação de Stored Procedures
* Modelagem Dimensional (Tabelas Fato e Dimensão — ex: DimProduto)
* Modelagem Lógica e Física de Bancos de Dados (Arquivos .mwb do MySQL Workbench e .png)
* Carga e Povoamento de Bases de Dados (Cria_Carloca, Carrega_Carloca)

---

## Ferramentas Utilizadas

* MySQL / MySQL Workbench
* Ferramentas de Gerenciamento e Execução de Scripts SQL

---

## Licença

Este repositório está sob a licença MIT (LICENSE).
