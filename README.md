# bigquery-ethereum

Nesse repositório estão algumas consultas que analisam dados de contratos inteligentes que estão disponíveis em um dataset público e gratuito da Google. Este dataset fica dentro do BigQuery, banco de dados voltado para analytics, no seguinte endereço:

- Projeto: “bigquery-public-data”
- Dataset: “crypto_ethereum”

Para acessar estes dados você precisará criar uma conta gratuita na Google Cloud Platform (GCP)

Essas consultas estão programadas para executar diariamente dentro da plataforma GCP e alimentar as tabelas que respondem as perguntas enumeradas: 

questão1 - Quantos contratos (tokens) estão sendo criados por bloco?
questão2 - Quantos blocos estão sendo criados em um dia?
questão3 - Em relação aos últimos 15 dias, qual foi a variação na quantidade de blocos contendo tokens em um dia?
questão4 - Qual o bloco que gerou contratos (tokens) e utilizou mais taxa (gas)? Informar o nome de todos os tokens contidos neste bloco

