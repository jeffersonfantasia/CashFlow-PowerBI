let
    Fonte = PowerBI.Dataflows(null),
    #"62685399-e81e-4c28-bb3e-37dd18427335" = Fonte{[workspaceId="62685399-e81e-4c28-bb3e-37dd18427335"]}[Data],
    #"d9a71564-c006-461a-95f6-e1feb68e9cd6" = #"62685399-e81e-4c28-bb3e-37dd18427335"{[dataflowId="d9a71564-c006-461a-95f6-e1feb68e9cd6"]}[Data],
    fSaldoBancos1 = #"d9a71564-c006-461a-95f6-e1feb68e9cd6"{[entity="fSaldoBancos"]}[Data],
    
    #"Tipo Alterado" = 
        Table.TransformColumnTypes(fSaldoBancos1,{{"DTCOMPENSACAO", type date}})
in
    #"Tipo Alterado"
