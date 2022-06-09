CREATE OR REPLACE TABLE
  projetostone-352416.Ethereum.q3_delta_quantidade_de_blocos_que_possuem_tokens AS
SELECT
  -- contar quantos blocos possuem tokens hoje,quantos possuiam a 15 dias atras, e calcular a variação percentual entre AS duas observações. 
  MAX(CASE
    WHEN tf.dia = FORMAT_DATE("%Y-%m-%d", DATE_SUB(CURRENT_TIMESTAMP(), INTERVAL 15 DAY)) THEN tf.Bloco
    ELSE
    0
  END
    ) AS menos15dias,
  MAX(CASE
      WHEN tf.dia = FORMAT_DATE("%Y-%m-%d", CURRENT_TIMESTAMP()) THEN tf.Bloco
    ELSE
    0
  END
    ) AS hoje,
  (MAX(CASE
        WHEN tf.dia = FORMAT_DATE("%Y-%m-%d", CURRENT_TIMESTAMP()) THEN tf.Bloco
      ELSE
      0
    END
      )/MAX(CASE
        WHEN tf.dia = FORMAT_DATE("%Y-%m-%d", DATE_SUB(CURRENT_TIMESTAMP(), INTERVAL 15 DAY)) THEN tf.Bloco
      ELSE
      0
    END
      ))-1 AS delta_percentual
FROM (
  SELECT
    -- selecionar somento os blocos que possuem tokens e da DATA de hoje e 15 dias atras 
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
      block_hash
    ORDER BY
      Qtd_Tokens ) tk
  ON
    bk.HASH = tk.block_hash
  WHERE
    tk.Qtd_Tokens IS NOT NULL
    AND FORMAT_DATE("%Y-%m-%d", bk.timestamp) IN (FORMAT_DATE("%Y-%m-%d", DATE_SUB(CURRENT_TIMESTAMP(), INTERVAL 15 DAY)),
      FORMAT_DATE("%Y-%m-%d", CURRENT_TIMESTAMP()))
  GROUP BY
    dia
  ORDER BY
    dia ) tf