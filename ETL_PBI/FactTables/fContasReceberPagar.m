let
    Fonte = 
        Table.Combine(
            {
                fContasReceberAberto,
                fContasReceberBaixado, 
                fLancContasPagar
            }
        ),

    #"Colunas Não Dinâmicas" = 
        Table.UnpivotOtherColumns(
            Fonte, 
            {"CODFILIAL", "CODCLI", "DUPLICATA", "DTEMISSAO", "DTVENC", "DTPAG", "CODCOB", "VALOR", "VALORLIQ", "CODUSUR", "Num", "RECNUM", "CODCONTA", "CODFORNEC", "TIPOPARCEIRO", "HISTORICO", "TIPOLANC", "HISTORICO2"}, 
            "Fluxo", "Categoria"),
    
    #"Consultas Mescladas" = 
        Table.NestedJoin(#"Colunas Não Dinâmicas", {"CODFILIAL", "DTVENC"}, dDiasUteis, {"CODFILIAL", "DATA"}, "dDiasUteis", JoinKind.LeftOuter),
    
    #"dDiasUteis Expandido" = 
        Table.ExpandTableColumn(#"Consultas Mescladas", "dDiasUteis", {"DataDiaUtil"}, {"DataDiaUtil"}),
    
    DataAtual = Date.From( DateTimeZone.SwitchZone( DateTimeZone.LocalNow(), -3) ),

    #"Status Adicionada" = 
        Table.AddColumn(#"dDiasUteis Expandido", "STATUS", each if [DataDiaUtil] < DataAtual and [DTPAG] is null then "VENCIDO" else if [DTPAG] is null then "A VENCER" else "PAGO", type text)
in
    #"Status Adicionada"