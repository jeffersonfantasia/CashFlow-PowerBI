CREATE OR REPLACE VIEW VIEW_JC_CONTAS_PAGAR AS
SELECT L.CODFILIAL,
       L.RECNUM,
       L.DTEMISSAO,
       L.DTVENC,
       L.DTPAGTO,
       L.CODCONTA,
       L.CODFORNEC,
       L.TIPOPARCEIRO,
       L.HISTORICO,
       (L.NUMNOTA || ' - ' || L.DUPLIC) AS DUPLICATA,
       L.TIPOLANC,
       L.VALOR,
       (NVL(L.VALOR, 0) - NVL(L.DESCONTOFIN, 0) - NVL(L.VALORDEV, 0)) AS VALORLIQ,
       TRIM(L.HISTORICO2) AS HISTORICO2
  FROM PCLANC L
 WHERE L.DTPAGTO IS NULL
   AND L.DTCANCEL IS NULL;
