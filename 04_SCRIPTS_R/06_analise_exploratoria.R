# Etapa 6 - Analise exploratoria
# Distribuicao das notas e correlacao de cada variavel fisico-quimica com a
# qualidade sensorial.

analisar_dados <- function(clean) {
  resultado <- list()

  notas <- sort(unique(clean$quality))
  resultado$quality_distribution <- data.frame(
    quality = notas,
    wines   = as.integer(table(clean$quality)[as.character(notas)]),
    pct     = round(as.numeric(table(clean$quality)[as.character(notas)]) / nrow(clean) * 100, 1)
  )

  numericas <- clean[vapply(clean, is.numeric, logical(1))]
  co <- cor(numericas)
  resultado$correlations <- co

  qc <- data.frame(variable = rownames(co), correlation_with_quality = co[, "quality"],
                   row.names = NULL)
  qc <- qc[qc$variable != "quality", ]
  resultado$quality_correlations <- qc[order(-abs(qc$correlation_with_quality)), ]

  resultado$profile_by_quality_group <- local({
    vars <- c("alcohol", "volatile_acidity", "sulphates", "citric_acid", "p_h")
    z <- aggregate(numericas[vars], list(quality_group = clean$quality_group), mean)
    z$wines <- as.integer(table(clean$quality_group)[as.character(z$quality_group)])
    z
  })

  resultado
}
