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
            {"CODFILIAL", "CODCLI", "DUPLICATA", "DTEMISSAO", "DTVENC", "DTPAG", "STATUS", "CODCOB", "VALOR", "VALORLIQ", "CODUSUR", "Num", "RECNUM", "CODCONTA", "CODFORNEC", "TIPOPARCEIRO", "HISTORICO", "TIPOLANC", "HISTORICO2"}, 
            "Fluxo", "Categoria"),
    
    #"Consultas Mescladas" = 
        Table.NestedJoin(#"Colunas Não Dinâmicas", {"DTVENC"}, dDiasUteis, {"DATA"}, "dDiasUteis", JoinKind.LeftOuter),
    
    #"dDiasUteis Expandido" = 
        Table.ExpandTableColumn(#"Consultas Mescladas", "dDiasUteis", {"DataDiaUtil"}, {"DataDiaUtil"})
in
    #"dDiasUteis Expandido"