let
    Fonte = PowerBI.Dataflows(null),
    #"62685399-e81e-4c28-bb3e-37dd18427335" = Fonte{[workspaceId="62685399-e81e-4c28-bb3e-37dd18427335"]}[Data],
    #"7ac74dcd-1a52-456b-84f7-93f7a5d03afe" = #"62685399-e81e-4c28-bb3e-37dd18427335"{[dataflowId="7ac74dcd-1a52-456b-84f7-93f7a5d03afe"]}[Data],
    fLancContasPagar1 = #"7ac74dcd-1a52-456b-84f7-93f7a5d03afe"{[entity="fLancContasPagar"]}[Data],
    
    #"Despesas Adicionada" = 
        Table.AddColumn(fLancContasPagar1, "Despesas", each 
            if Text.Contains( [HISTORICO2], "RISCO") 
            then "Risco Sacado" 
            else if [CODCONTA] = 100001 then "Compra Mercadoria" 
            else if [TIPOLANC] = "C" then "Confirmado" 
            else "Provisionado", type text),
    
    #"Valor Negativo Calculado" = 
        Table.TransformColumns(#"Despesas Adicionada",{{"VALORLIQ", each Value.Multiply(_,-1), type number}}),
    
    #"Num Adicionada" = 
        Table.AddColumn(#"Valor Negativo Calculado", "Num", each 
            if [Despesas] = "Risco Sacado" then 5 
            else if [Despesas] = "Compra Mercadoria" then 6 
            else if [Despesas] = "Confirmado" then 7 
            else 8, type number),
    
    #"Colunas Renomeadas" = 
        Table.RenameColumns(#"Num Adicionada",{{"DTPAGTO", "DTPAG"}}),
    
    #"Outras Colunas Removidas" = 
        Table.SelectColumns(#"Colunas Renomeadas",{"CODFILIAL", "RECNUM", "DTEMISSAO", "DTVENC", "DTPAG", "CODCONTA", "CODFORNEC", "TIPOPARCEIRO", "HISTORICO", "DUPLICATA", "TIPOLANC", "VALOR", "VALORLIQ", "HISTORICO2", "Despesas", "Num"}),
    
    #"Tipo Alterado" = 
        Table.TransformColumnTypes(#"Outras Colunas Removidas",{{"DTEMISSAO", type date}, {"DTVENC", type date}, {"DTPAG", type date}})
in
    #"Tipo Alterado"