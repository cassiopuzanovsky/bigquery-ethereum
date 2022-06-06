SELECT
  FORMAT_DATE("%Y-%m-%d", timestamp) AS dia,
  COUNT(number) AS qtd_blocos
--into `civic-athlete-352303.Respostas.Questao022`
FROM
  `bigquery-public-data.crypto_ethereum.blocks`
GROUP BY
  dia
ORDER BY
  dia desc