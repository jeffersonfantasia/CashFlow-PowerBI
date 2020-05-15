(Filial as text) =>
let
    Fonte = PowerBI.Dataflows(null),
    #"62685399-e81e-4c28-bb3e-37dd18427335" = Fonte{[workspaceId="62685399-e81e-4c28-bb3e-37dd18427335"]}[Data],
    #"17ba9f69-32e1-407f-8cd9-c84c347d4f05" = #"62685399-e81e-4c28-bb3e-37dd18427335"{[dataflowId="17ba9f69-32e1-407f-8cd9-c84c347d4f05"]}[Data],
    dDiasUteis1 = #"17ba9f69-32e1-407f-8cd9-c84c347d4f05"{[entity="dDiasUteis"]}[Data],
    
    #"Outras Colunas Removidas" = 
        Table.SelectColumns(dDiasUteis1,{"CODFILIAL", "DATA", "DIAFINANCEIRO"}),
    
    #"Linhas Filtradas" = 
        Table.SelectRows(#"Outras Colunas Removidas", each [CODFILIAL] = Filial),
    
    #"Índice Adicionado" = 
        Table.AddIndexColumn(#"Linhas Filtradas", "Index", 0, 1),
    
    fnCountNonWorkingDays = (Indice) =>
        let 
            Indice = Table.SelectColumns( Table.SelectRows(#"Índice Adicionado" , each ([Index]) >= Indice),  {"DIAFINANCEIRO"} ),
            Result = List.Count( List.FirstN( Indice[DIAFINANCEIRO], each _ = "N" ) )
        in 
            Result,  

    AddNonWorkingDays = 
        Table.AddColumn(
            #"Índice Adicionado" , 
            "CountNonWorkingDays", 
            each fnCountNonWorkingDays([Index])      
        )
in        
    AddNonWorkingDays