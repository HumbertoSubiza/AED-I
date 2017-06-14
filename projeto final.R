#
# Análise Exploratório de Dados - Parte I
# Instrutor Walter Humberto Subiza Pina - CCAR/GIMAG
Sys.time()

# Uma solução para o projeto final

# O projeto consiste em limpar e preparar o arquivo "clima.txt", que
# se encontra no diretório de trabalho.

# O arquivo final dever posibilitar encontrar facilmente as estatísticas básicas
# de cada registro da coluna "measure", assim como conter uma variável "data"
# que inclua o "ano/mes/dia" de cada registro.
# Realizar um gráfico da variável "Max.TemperatureF" ao longo do tempo registrado
# Salvar o arquivo final como "clima_aed.csv" em formato csv2
# 

#-------------------------------------------------------------------------------
# SOLUÇÂO:

# leitura do arquivo com read.csv do Base, indicando separador espaço em branco
# eliminando a primeira coluna. 
clima <- read.csv("clima.txt", sep = "", stringsAsFactors = F)[,-1]
str(clima)

# primeiro vamos a acertar os nomes das variáveis, eliminando o "X"
# para não mexer no arquivo salvamos os nomes numa variável e trabalhamos com
# # ele. Para a eliminação vamos usar stringr::str_replace
#library(stringr)
# Passo a passo
library(stringr)                      # carrego a biblioteca
nomes <- names(clima)                 # salvo os nomes
nomes <- str_replace(nomes, "X", "")  # eliminando as "X"
names(clima) <- nomes                 # retornando

# num passo só
# names(clima) <-stringr::str_replace(names(clima), "X", "")

# segundo passo, vamos passar as variáveis que representam os dias para uma
# única coluna "day"
clima2 <- tidyr::gather(clima, day, value, 4:34)

# terceiro passo, vamos espalhar a variável "measure" e colocar em colunas
# é a operação inversa ao passo 2
clima3 <- tidyr::spread(clima2, measure, value)

# quarto passo, arrumamos em ordem por ano, mes e dia, para que possa ordenar
# corretamente é necessário transformar as variáveis "month" e "day"
# em numéricas
clima4 <- dplyr::arrange(clima3, year, as.numeric(month), as.numeric(day))

# quinto passo: criar uma nova variável como "data", juntando ano, mes e dia

clima5 <- tidyr::unite(clima4, year, month, day, col = "data", sep ="/")

# e definir ela como variável data
clima5$data <- lubridate::as_date(clima5$data)

summary(clima5)

# sexto passo
# podemos trabalhar apenas com as observações completas, porém para eliminar
#  os valores "NAs" devemos transformar primeiro as variáveis de character para
#  numeric. Para isso aplicamos uma função que transforma as colunas desejadas
#  en numericas. Lembrar que se perdem todos os registros de tipo carater
#  que serão transformados em NAs

clima5[,c(2,4:23)] <- apply(clima5[,c(2,4:23)], 2, function(x) as.numeric(x))

# a variável "Events" que deveria ser fator está como carater, vamos mudar
clima5$Events <- as.factor(clima5$Events)

# verificação
str(clima5)

# sétimo passo,
# separamos apenas o conjunto de dados que não apresenta NAs...
# lembrando que apenas funciona para variáveis quantitativas
clima_aed <- clima5[complete.cases(clima5),]

# oitavo passo, resumo, estatísticas
summary(clima_aed)
table(clima_aed$Events)

# nono passo, gráfico solicitado
plot(clima5$data, clima5$Max.TemperatureF)

# décimo passo, salvando o arquivo final
write.csv2(clima_aed, file = "clima_aed.csv")
