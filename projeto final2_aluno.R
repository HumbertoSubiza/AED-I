#
# Análise Exploratório de Dados - Parte I
# Instrutor Walter Humberto Subiza Pina - CCAR/GIMAG
# Aluno(s):
# 

# Instalar o pacote "electionsBR" e carregar a biblioteca
# Dica: é bom carregar "tidyr" e "dplyr", mas pode fazer
# ainda na frente se precisar de alguma função específica
library(electionsBR)
library(tidyverse)


# veja na ajuda no painel 4, quais as funções que permitem escolher
# Baixar os dados dos candidatos a cargos federales, na eleicao
# de 2014, para o estado do Rio de Janeiro e gravar com um nome 
# a sua escolha
candidato <- candidate_fed(2014, uf = "RJ")

# conheca o arquivo: qual o tamanho e a classe, tem alguma variavel
# que acha que deve ser modificada de classe?



# Quantos deputados federais, estaduais
summary(as.factor(candidato$DESCRICAO_CARGO))


# Quienes foram os candidatos a governador e de que partido. Ordenar alfabeti
# camente por nome de candidato
governadores <- candidato %>% 
  select(DESCRICAO_CARGO , NOME_CANDIDATO, NOME_PARTIDO, NUM_TURNO) %>%
  filter(DESCRICAO_CARGO == "GOVERNADOR") %>%
  arrange(desc(NOME_CANDIDATO))

head(governadores,9)


# Qual a media de idade dos candidatos? qual a idade minima e maxima
summary(as.integer(candidato$IDADE_DATA_ELEICAO))

# quienes são esses candidatos com idadades extremas, 
# a que cargo e de que partido ?
cand.idades.ext <- candidato %>%
  filter(IDADE_DATA_ELEICAO == 89.0 | IDADE_DATA_ELEICAO == 19.0) %>%
  select(NOME_CANDIDATO, 
         IDADE_DATA_ELEICAO, 
         DESCRICAO_CARGO, 
         NOME_PARTIDO)

cand.idades.ext



# qual o nível de escolaridade dos candidatos?
(cand.nivel.instr <- summary(as.factor(candidato$CODIGO_COR_RACA)))

library(lubridate)

candidato$DATA_NASCIMENTO <- ymd(candidato$DATA_NASCIMENTO)
class(candidato$DATA_NASCIMENTO)
# Fim do projeto final2
