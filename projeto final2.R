#
# Análise Exploratório de Dados - Parte I
# Instrutor Walter Humberto Subiza Pina - CCAR/GIMAG
# Aluno(s):
# 

# Instalar o pacote "electionsBR" e carregar a biblioteca
# Dica: é bom carregar "tidyr" e "dplyr", mas pode fazer
# ainda na frente se precisar de alguma função específica
install.packages("electionsBR")
library(electionsBR)
library(dplyr)

# veja na ajuda no painel 4, quais as funções que permite escolher
# Baixar os dados dos candidatos a cargos federales, na eleicao
# de 2014, para o estado do Rio de Janeiro e gravar com um nome 
# a sua escolha
candidato <- candidate_fed(2014, uf = "RJ")

# conheca o arquivo: qual o tamanho e a classe, tem alguma variavel
# que acha que deve ser modificada de classe?
str(candidato)

# Quantos deputados federais, estaduais
summary(as.factor(candidato$DESCRICAO_CARGO))

# Quienes foram os candidatos a governador e de que partido. Ordenar alfabeti
# camente por nome de candidato
governadores <- candidato %>% 
  select(DESCRICAO_CARGO ,NOME_CANDIDATO, NOME_PARTIDO) %>%
  filter(DESCRICAO_CARGO == "GOVERNADOR") %>%
  arrange(NOME_CANDIDATO)
head(governadores,9)

# Qual a media de idade dos candidatos? qual a idade minima e maxima
candidato$IDADE_DATA_ELEICAO <- as.numeric(candidato$IDADE_DATA_ELEICAO)
summary(candidato$IDADE_DATA_ELEICAO)

# quienes são esses candidatos com idadades extremas, 
# a que cargo e de que partido ?
cand.idades.ext <- candidato %>%
  filter(IDADE_DATA_ELEICAO == 89.0 | IDADE_DATA_ELEICAO ==19.0) %>%
  select(NOME_CANDIDATO, 
         IDADE_DATA_ELEICAO, 
         DESCRICAO_CARGO, 
         NOME_PARTIDO)
cand.idades.ext

# qual o nível de escolaridade
cand.escol <- candidato %>%
  select(CODIGO_COR_RACA) %>%
  table()
cand.escol

cor <- colorspace::rainbow_hcl(20)
barplot(cand.escol, las=2, ylim=c(0,1500), cex.names = 0.5,
        col = cor)

# Fim do projeto final2
