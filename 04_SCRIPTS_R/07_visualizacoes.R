# Etapa 7 - Visualizacoes

criar_graficos <- function(clean, analise, project_root) {
  dir.create(file.path(project_root, "06_GRAFICOS"), FALSE, TRUE)
  grafico <- function(nome) file.path(project_root, "06_GRAFICOS", nome)

  png(grafico("alcohol_by_quality.png"), 1440, 900, res = 150)
  par(mar = c(5, 5, 4, 2))
  boxplot(alcohol ~ quality, data = clean, col = "#74B9FF",
          xlab = "Nota de qualidade", ylab = "Alcool (% vol.)",
          main = "Distribuicao do alcool por nota de qualidade")
  dev.off()

  q <- analise$quality_correlations
  png(grafico("correlation_with_quality.png"), 1440, 900, res = 150)
  par(mar = c(5, 11, 4, 2))
  barplot(rev(q$correlation_with_quality), names.arg = rev(q$variable), horiz = TRUE, las = 1,
          col = ifelse(rev(q$correlation_with_quality) < 0, "#C0392B", "#1E8449"),
          xlab = "Correlacao de Pearson com a qualidade",
          main = "O que se associa a qualidade do vinho")
  abline(v = 0, col = "grey40")
  dev.off()

  d <- analise$quality_distribution
  png(grafico("quality_distribution.png"), 1440, 900, res = 150)
  par(mar = c(5, 5, 4, 2))
  barplot(d$wines, names.arg = d$quality, col = "#8E44AD",
          xlab = "Nota de qualidade", ylab = "Numero de vinhos",
          main = "Distribuicao das notas de qualidade")
  dev.off()
}
