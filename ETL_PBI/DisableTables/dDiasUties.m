let
    Fonte = PowerBI.Dataflows(null),
    #"62685399-e81e-4c28-bb3e-37dd18427335" = Fonte{[workspaceId="62685399-e81e-4c28-bb3e-37dd18427335"]}[Data],
    #"17ba9f69-32e1-407f-8cd9-c84c347d4f05" = #"62685399-e81e-4c28-bb3e-37dd18427335"{[dataflowId="17ba9f69-32e1-407f-8cd9-c84c347d4f05"]}[Data],
    dDiasUteis1 = #"17ba9f69-32e1-407f-8cd9-c84c347d4f05"{[entity="dDiasUteis"]}[Data],
    
    #"Outras Colunas Removidas" = 
        Table.SelectColumns(dDiasUteis1,{"CODFILIAL"}),
    
    #"Duplicatas Removidas" = 
        Table.Distinct(#"Outras Colunas Removidas"),
    
    #"Função Personalizada Invocada" = 
        Table.AddColumn(#"Duplicatas Removidas", "Tables", each fnCountNonWorkingDays([CODFILIAL])),
    
    #"Tables Expandido" = 
        Table.ExpandTableColumn(Table.Buffer( #"Função Personalizada Invocada"), "Tables", {"DATA", "DIAFINANCEIRO", "CountNonWorkingDays"}, {"DATA", "DIAFINANCEIRO", "CountNonWorkingDays"}),
    
    #"Tipo Alterado" = 
        Table.TransformColumnTypes(#"Tables Expandido",{{"DATA", type date}, {"DIAFINANCEIRO", type text}, {"CountNonWorkingDays", Int64.Type}}),
    
    #"DataDiaUtil Adicionada" = 
        Table.AddColumn(#"Tipo Alterado", "DataDiaUtil", each Date.AddDays( [DATA], [CountNonWorkingDays] ), type date)
in
    #"DataDiaUtil Adicionada"