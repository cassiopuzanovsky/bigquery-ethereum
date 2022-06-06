CREATE OR REPLACE TABLE
  projetostone-352416.Ethereum.q4_tokens_do_bloco_com_mais_taxa AS
SELECT
  tks.block_hash,
  tks.name,
  mg.gas,
  mg.Qtd_Tokens
FROM
  `bigquery-public-data.crypto_ethereum.tokens` tks
LEFT JOIN (
  SELECT
    --bloco que possui token e maior gas 
    bk.HASH AS Bloco,
    gas_used AS gas,
    tk.Qtd_Tokens
  FROM
    `bigquery-public-data.crypto_ethereum.blocks` bk
  LEFT JOIN (
    SELECT
      -- contar os token nos blocos 
      block_hash,
      COUNT(address) AS Qtd_Tokensa
    FROM
      `bigquery-public-data.crypto_ethereum.tokens`
    GROUP BY
      block_hash) tk
  ON
    bk.HASH = tk.block_hash
  WHERE
    tk.Qtd_Tokens IS NOT NULL
  ORDER BY
    gas DESC
  LIMIT
    1) mg
ON
  mg.bloco = tks.block_hash
WHERE
  gas IS NOT NULL


-- URL DA CONSULTA: https://console.cloud.google.com/bigquery?sq=612225522575:ffcd6db51fca4dacbc6b1f3704c32627