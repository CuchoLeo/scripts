--Funcion para adviser
CREATE OR REPLACE TABLE FUNCTION `ent-qas-datawarecloud.ent_qas_operacional.consultar_adviser`(v_IdCliente NUMERIC) AS (
(
(
(
SELECT AS STRUCT  cat.codigo_acbi as codigo_acbi, consumo.* FROM `ent-dev-datawarecloud.ent_dev_operacional.consumo_pagos_fijos` as consumo
JOIN `ent-dev-datawarecloud.ent_dev_operacional.cat_tipo_acbi` cat
ON consumo.id_tipo_acbi = cat.id_tipo_acbi
    where consumo.id_cliente =  v_IdCliente
)
)
)
);
##################################
-- Devuelve Schema de BigQuery
bq show \
--schema \
--format=prettyjson \
project_id:dataset.table > path_to_file
bq show --schema --format=prettyjson ent-dev-datawarecloud:ent_dev_operacional.cat_tipo_acbi > cat_tipo_acbi.json
#################################
--Crear tabla a partir de una Jason
bq mk --table mydataset.mytable ./myschema.json
bq mk --table ent-qas-datawarecloud:ent_qas_operacional.cat_tipo_acbi /home/p_victor_ry/cat_tipo_acbi.json
#################################
--crear tabla particionada por fecha a partir de Jason
bq mk --table   --schema /home/p_victor_ry/BQ_person_table.json /   --time_partitioning_field primera_fecha_limite_pago   --time_partitioning_type DAY   ent-qas-datawarecloud:ent_qas_operacional.TF_VF_SEG_FIRST_PAYMENT_PERSON
