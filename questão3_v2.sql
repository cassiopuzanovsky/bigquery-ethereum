CREATE OR REPLACE TABLE
  projetostone-352416.Ethereum.q3_var_qnt_blocos_com_tokens AS
SELECT
  var_pop(tf.Bloco) AS var_qnt_blocos_com_tokens,
  STDDEV(tf.Bloco) AS desv_pad_qnt_blocos_com_tokens,
  AVG(tf.Bloco) AS media_qnt_blocos_com_tokens,
  MIN(tf.Bloco) AS min_qnt_blocos_com_tokens,
  MAX(tf.Bloco) AS max_qnt_blocos_com_tokens
FROM (
  SELECT
    FORMAT_DATE("%Y-%m-%d", bk.timestamp) AS dia,
    COUNT(bk.HASH) AS Bloco
  FROM
    `bigquery-public-data.crypto_ethereum.blocks` bk
  LEFT JOIN (
    SELECT
      -- contar os token nos blocos 
      block_hash,
      COUNT(address) AS Qtd_Tokens
    FROM
      `bigquery-public-data.crypto_ethereum.tokens`
    GROUP BY
      block_hash) tk
  ON
    bk.HASH = tk.block_hash
  WHERE
    tk.Qtd_Tokens IS NOT NULL
    AND bk.timestamp >= DATE_SUB(CURRENT_TIMESTAMP(), INTERVAL 15 DAY)
  GROUP BY
    dia
  ORDER BY
    dia ) tf

