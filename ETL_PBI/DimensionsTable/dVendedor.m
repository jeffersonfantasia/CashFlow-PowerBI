let
    Fonte = PowerBI.Dataflows(null),
    #"62685399-e81e-4c28-bb3e-37dd18427335" = Fonte{[workspaceId="62685399-e81e-4c28-bb3e-37dd18427335"]}[Data],
    #"147dbdb2-be83-481b-8703-5501bc1c6ce2" = #"62685399-e81e-4c28-bb3e-37dd18427335"{[dataflowId="147dbdb2-be83-481b-8703-5501bc1c6ce2"]}[Data],
    dVendedor1 = #"147dbdb2-be83-481b-8703-5501bc1c6ce2"{[entity="dVendedor"]}[Data]
in
    dVendedor1