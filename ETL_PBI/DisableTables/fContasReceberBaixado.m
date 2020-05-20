let
    Fonte = PowerBI.Dataflows(null),
    #"62685399-e81e-4c28-bb3e-37dd18427335" = Fonte{[workspaceId="62685399-e81e-4c28-bb3e-37dd18427335"]}[Data],
    #"8039f4ff-a199-4f5f-8040-21f6488872c5" = #"62685399-e81e-4c28-bb3e-37dd18427335"{[dataflowId="8039f4ff-a199-4f5f-8040-21f6488872c5"]}[Data],
    fContasReceberBaixado1 = #"8039f4ff-a199-4f5f-8040-21f6488872c5"{[entity="fContasReceberBaixado"]}[Data],
    
    #"Colunas Renomeadas" = 
        Table.RenameColumns(fContasReceberBaixado1,{{"DATA", "DTPAG"},{"VALOR", "VALORLIQ"}}),
    
    #"Receita Adicionada" = 
        Table.AddColumn(#"Colunas Renomeadas", "Receitas", each 
            if List.Contains({"CARC", "CADB"},[CODCOB])
            then "Varejo" 
            else if [CODCOB] = "BK" then "Boleto" 
            else if [CODCOB] = "C" then "Carteira" 
            else "Outros", type text),

    #"Num Adicionada" = 
        Table.AddColumn(#"Receita Adicionada", "Num", each 
            if [Receitas] = "Boleto" then 1 
            else if [Receitas] = "Carteira" then 2 
            else if [Receitas] = "Varejo" then 3 
            else 4, type number),
    
    #"Outras Colunas Removidas" = 
        Table.SelectColumns(#"Num Adicionada",{"CODFILIAL", "CODCLI", "DUPLICATA", "DTPAG", "DTVENC", "DTEMISSAO", "CODCOB", "VALORLIQ", "CODUSUR", "Receitas", "Num"}),
    
    #"Tipo Alterado" = 
        Table.TransformColumnTypes(#"Outras Colunas Removidas",{{"DTPAG", type date}, {"DTVENC", type date}, {"DTEMISSAO", type date}})
in
    #"Tipo Alterado"