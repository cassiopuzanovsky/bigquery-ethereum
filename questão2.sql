CREATE OR REPLACE TABLE
  projetostone-352416.Ethereum.q2_blocos_por_dia AS
SELECT
  FORMAT_DATE("%Y-%m-%d", timestamp) AS dia,
  COUNT(number) AS qtd_blocos
FROM
  `bigquery-public-data.crypto_ethereum.blocks`
GROUP BY
  dia
ORDER BY
  dia DESC


-- URL DA CONSULTA: https://console.cloud.google.com/bigquery?sq=612225522575:db2274ae17f34ba9a5664b657e9c4533