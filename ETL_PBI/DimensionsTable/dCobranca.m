let
    Fonte = PowerBI.Dataflows(null),
    #"62685399-e81e-4c28-bb3e-37dd18427335" = Fonte{[workspaceId="62685399-e81e-4c28-bb3e-37dd18427335"]}[Data],
    #"0a270a17-6199-4f02-8c53-1c833befbbec" = #"62685399-e81e-4c28-bb3e-37dd18427335"{[dataflowId="0a270a17-6199-4f02-8c53-1c833befbbec"]}[Data],
    dCobranca1 = #"0a270a17-6199-4f02-8c53-1c833befbbec"{[entity="dCobranca"]}[Data]
in
    dCobranca1