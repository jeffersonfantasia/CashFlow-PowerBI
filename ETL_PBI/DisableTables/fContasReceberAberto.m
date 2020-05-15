let
    Fonte = PowerBI.Dataflows(null),
    #"62685399-e81e-4c28-bb3e-37dd18427335" = Fonte{[workspaceId="62685399-e81e-4c28-bb3e-37dd18427335"]}[Data],
    #"8dbe0bcc-4b6e-4dff-a959-48f003967598" = #"62685399-e81e-4c28-bb3e-37dd18427335"{[dataflowId="8dbe0bcc-4b6e-4dff-a959-48f003967598"]}[Data],
    fContasReceberAberto1 = #"8dbe0bcc-4b6e-4dff-a959-48f003967598"{[entity="fContasReceberAberto"]}[Data],
    
    #"Receita Adicionada" = 
        Table.AddColumn(fContasReceberAberto1, "Receitas", each 
            if ([CARTAO] = "S" or List.Contains({"CARC", "CADB"},[CODCOB])) 
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
        Table.SelectColumns(#"Num Adicionada",{"CODFILIAL", "CODCLI", "DUPLICATA", "DTEMISSAO", "DTVENC", "DTPAG", "STATUS", "CODCOB", "VALOR", "VALORLIQ", "CODUSUR", "Receitas", "Num"}),
    
    #"Tipo Alterado" = 
        Table.TransformColumnTypes(#"Outras Colunas Removidas",{{"DTEMISSAO", type date}, {"DTVENC", type date}, {"DTPAG", type date}})
in
    #"Tipo Alterado"