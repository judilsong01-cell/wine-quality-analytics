# Qualidade do Vinho Tinto em R | Fatores Físico-Químicos

Análise reproduzível de **1.599 vinhos tintos** portugueses (Vinho Verde) para perceber que
propriedades químicas acompanham as melhores notas de prova.

**Stack:** R 4.5.2 · apenas R base · sem dependências externas

---

## Resultado principal

> **O álcool é o que mais acompanha a qualidade (r = +0,48). A acidez volátil é o que mais a
> penaliza (r = −0,39).** Nenhuma outra variável passa de ±0,26.

![Correlação com a qualidade](06_GRAFICOS/correlation_with_quality.png)

| Variável | Correlação com a qualidade |
|---|---:|
| Álcool | **+0,476** |
| Acidez volátil | **−0,391** |
| Sulfatos | +0,251 |
| Ácido cítrico | +0,226 |
| Dióxido de enxofre total | −0,185 |
| Densidade | −0,175 |
| Cloretos | −0,129 |
| Acidez fixa | +0,124 |
| pH | −0,058 |
| Dióxido de enxofre livre | −0,051 |
| Açúcar residual | +0,014 |

O perfil médio confirma-o de forma direta:

| Grupo de qualidade | Vinhos | Álcool | Acidez volátil | Sulfatos | Ácido cítrico |
|---|---:|---:|---:|---:|---:|
| Baixa (3–5) | 744 | 9,93 | 0,590 | 0,619 | 0,238 |
| Média (6) | 638 | 10,63 | 0,497 | 0,675 | 0,274 |
| Alta (7–8) | 217 | **11,52** | **0,406** | 0,743 | 0,376 |

![Álcool por nota de qualidade](06_GRAFICOS/alcohol_by_quality.png)

## O problema que os números escondem

**82,5% dos vinhos têm nota 5 ou 6.** As notas extremas quase não existem: 10 vinhos com 3 e
18 com 8, em 1.599.

| Nota | Vinhos | % |
|---:|---:|---:|
| 3 | 10 | 0,6% |
| 4 | 53 | 3,3% |
| 5 | 681 | 42,6% |
| 6 | 638 | 39,9% |
| 7 | 199 | 12,4% |
| 8 | 18 | 1,1% |

![Distribuição das notas](06_GRAFICOS/quality_distribution.png)

Isto tem consequências práticas: qualquer modelo treinado neste dataset vai acertar muito nas
notas 5 e 6 e falhar precisamente nos vinhos que interessa distinguir — os excelentes e os maus.
As correlações acima são calculadas sobre uma amostra concentrada no meio da escala e não devem
ser extrapoladas para os extremos.

## Decisão metodológica: os 240 duplicados foram mantidos

O dataset tem **240 linhas exatamente iguais a outras**. Não foram removidas.

Não existe identificador de amostra. Duas linhas idênticas podem ser um erro de registo — ou dois
vinhos diferentes com as mesmas 12 medições, o que é perfeitamente possível com valores
arredondados a uma ou duas casas decimais. Remover não é a opção conservadora: seria assumir um
erro que nada prova. Os duplicados ficam quantificados em `07_TABELAS/validacao_limpeza.csv`
para que quem reutilize os dados possa decidir de forma informada.

## Método

1. **Importação** — CSV original lido de `01_DADOS_BRUTOS`, sem alteração.
2. **Inspeção** — dimensões, valores em falta e duplicados exatos medidos antes da limpeza.
3. **Limpeza** — nomes normalizados para *snake_case*.
4. **Transformação** — criação de `quality_group` (baixa 3–5 / média 6 / alta 7–8).
5. **Validação** — registo de qualidade em `07_TABELAS/validacao_limpeza.csv`.
6. **Análise, gráficos e exportação.**

**Qualidade dos dados:** 1.599 linhas → 1.599 linhas · 0 valores em falta · **240 duplicados
exatos, mantidos** · 0 linhas removidas.

## Reproduzir

```bash
Rscript 04_SCRIPTS_R/09_executar_pipeline.R
```

## Estrutura

```
01_DADOS_BRUTOS/    CSV original, imutável
03_DADOS_LIMPOS/    dados tratados, gerados pelo pipeline
04_SCRIPTS_R/       9 etapas, uma por ficheiro
05_NOTEBOOKS/       notebook R Markdown para Kaggle
06_GRAFICOS/        gráficos PNG
07_TABELAS/         tabelas de resultados em CSV
09_DOCUMENTACAO/    dicionário de dados e dependências
```

## Limitações

Correlação não é causalidade, e aqui a advertência é concreta: aumentar o álcool de um vinho não
o torna melhor. É mais plausível que uvas mais maduras produzam simultaneamente mais álcool e
melhor vinho — o álcool seria então um indicador de maturação, não a causa da qualidade. A
concentração da amostra nas notas 5 e 6 limita ainda mais qualquer generalização.

## Dados

Wine Quality (vinho tinto) — Cortez, Cerdeira, Almeida, Matos e Reis, Universidade do Minho,
publicado no UCI Machine Learning Repository. Amostras de Vinho Verde do noroeste de Portugal.
O CSV original está em `01_DADOS_BRUTOS` sem alterações.

## Licença

Código sob licença MIT (ver `LICENSE`). O dataset mantém os termos da fonte original (UCI, CC BY 4.0).
