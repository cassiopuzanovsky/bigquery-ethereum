CREATE OR REPLACE TABLE
  projetostone-352416.Ethereum.q1_tokens_por_bloco AS
SELECT
  block_hash AS Bloco,
  COUNT(address) AS Qtd_Tokens
FROM
  `bigquery-public-data.crypto_ethereum.tokens`
GROUP BY
  block_hash
ORDER BY
  Qtd_Tokens DESC


-- URL DA CONSULTA: https://console.cloud.google.com/bigquery?sq=612225522575:4b3023b9f6bd4d278a16452f51f4df96