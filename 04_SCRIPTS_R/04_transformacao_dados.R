# Etapa 4 - Transformacao
# Agrupa a nota de qualidade em tres niveis interpretaveis.
# Os 240 duplicados exatos sao mantidos: o dataset nao tem identificador de
# amostra, logo nada prova que sejam erro de registo em vez de vinhos distintos
# com a mesma medicao.

transformar_dados <- function(clean) {
  clean$quality_group <- cut(clean$quality,
                             breaks = c(-Inf, 5, 6, Inf),
                             labels = c("low (3-5)", "medium (6)", "high (7-8)"))
  clean
}
