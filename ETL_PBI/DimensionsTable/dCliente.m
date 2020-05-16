let
    Fonte = PowerBI.Dataflows(null),
    #"62685399-e81e-4c28-bb3e-37dd18427335" = Fonte{[workspaceId="62685399-e81e-4c28-bb3e-37dd18427335"]}[Data],
    #"7bcfcd1b-9374-4c30-811e-29d2a8f08f62" = #"62685399-e81e-4c28-bb3e-37dd18427335"{[dataflowId="7bcfcd1b-9374-4c30-811e-29d2a8f08f62"]}[Data],
    dCliente1 = #"7bcfcd1b-9374-4c30-811e-29d2a8f08f62"{[entity="dCliente"]}[Data],
    
    #"Outras Colunas Removidas" = 
        Table.SelectColumns(dCliente1,{"CODCLI", "CLIENTE", "REDE", "CLIENTE_REDE", "PRACA"})
in
    #"Outras Colunas Removidas"