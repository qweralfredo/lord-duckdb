# Aprenda em menos de 2 Horas Cursos

## [Aula 0: Introdução ao Pato](mastering-duckdb/00-intro.ipynb)
* O que é o Duckdb
* Conhecendo o Dataset
* Acessando o Dataset

## [Aula 1:](mastering-duckdb/aula1.ipynb)

* Configuração do Ambiente

- Opção 1 - Google Cloud Shell Editor [Clique aqui e divirta-se](https://ssh.cloud.google.com/cloudshell/open?cloudshell_git_repo=https://github.com/qweralfredo/aprendaem-2horas.git)

- Opção 2 - Linux / Windows
    git clone https://github.com/qweralfredo/aprendaem-2horas.git

    - Visual Studio Code: [Download](https://code.visualstudio.com/download)
    
- Extensões
    - [Notebook para VS Code](https://marketplace.visualstudio.com/items?itemName=ms-toolsai.jupyter-renderers)
    - [Jupyter](https://marketplace.visualstudio.com/items?itemName=ms-toolsai.jupyter)
    - [Jupyter Keymap](https://marketplace.visualstudio.com/items?itemName=ms-toolsai.jupyter-keymap) 
    - [Jupyter Cell Tags](https://marketplace.visualstudio.com/items?itemName=ms-toolsai.vscode-jupyter-cell-tags)


## [Aula 2 - Hello Duckdb]((mastering-duckdb/aula1.ipynb))

* Instalando o pato! [Link Oficial](https://duckdb.org/docs/installation/index)
    - Executável (duckdb.exe no windows ou ./duckdb no linux)


## Facilitando a vida com %dql

* %dql é uma magic function que permite executar queries SQL diretamente no Jupyter Notebook
    - Instalando a extensão do jupyter
        - !pip install duckdb
        - !pip install jupysql pandas duckdb-engine 
        - %pip install magic_duckdb --upgrade
        - %load_ext magic_duckdb
        - %config SqlMagic.autopandas = True (para retornar os resultados como dataframes pandas)
        - %dql select  * from  (values (1, 'a'), (2, 'b')) as t(a, b);



## Execução do Duckdb

- Exemplo no Linux 
    - ./duckdb 

- Exemplo no windows
    - duckdb.exe

- Abrindo ou criando um banco de dados
    - ./duckdb nomedobanco.duckdb

- Abrindo ou criando um banco no python
    - import duckdb
    - cnn = duckdb.connect(database='nomedobanco.duckdb')

### Obs: Quando não há nome do banco de dados, o pato irá rodar na memória


##  [Aula 3. Hands On](mastering-duckdb/00-intro.ipynb)

- Se você estiver em um notebook, rode os comandos abaixo: 
    - !wget https://github.com/duckdb/duckdb/releases/download/v1.0.0/duckdb_cli-linux-amd64.zip
    - !unzip duckdb_cli-linux-amd64.zip
    - !rm -f duckdb_cli-linux-amd64.zip


## Principais consultas:

- select * from read_\[ parquet|json|csv \](<caminho_arquivo.[parquet|json|csv|qqr-coisa]>);
    - Exemplos
        * select * from read_json("data/aula3/input.json");
        * select * from read_parquet("data/aula3/input.parquet");
        * select * from read_csv("data/aula3/input.csv");



## Consultando arquivos Externos 
- Estrutura 
    - select * from read_csv(URL);

- Cloud Storage
    - select * from read_csv("s3://url");


    - Obs: Veremos este tópico afundo jajá!  


    
## Rodando o trem na linha de comando

- ./duckdb -s "select * from read_csv("data/movie_metadata.csv");

- !./duckdb -c "select * from read_csv('data/movie_metadata.csv');"

- !./duckdb -c "describe select * from read_csv('data/movie_metadata.csv');"

- !./duckdb -c "select * from read_csv('data/aula3/input.csv');"


### Hands on:

- CLI
- Python
- Notebook


##  [Aula 4. Extensões na Prática](mastering-duckdb/aula4.ipynb)

- O que são extensões?
- Documentação [https://duckdb.org/docs/extensions/overview.html](https://duckdb.org/docs/extensions/overview.html)
- Oficiais [https://duckdb.org/docs/extensions/official_extensions](https://duckdb.org/docs/extensions/official_extensions)
- Hands On
    - arrow
    - autocomplete
    - aws
    - httpfs
    - azure
    - delta
    - excel
    - fts
    - iceberg
    - postgres
    - mysql 
    

