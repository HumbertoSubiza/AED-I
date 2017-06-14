#
# Análise Exploratório de Dados - Parte I
# Instrutor Walter Humberto Subiza Pina - CCAR/GIMAG
# Aluno(s):
# 
Sys.time()

# O projeto consiste em limpar e preparar o arquivo "clima.txt", que
# se encontra no diretório de trabalho.

# O arquivo final deve posibilitar calcular facilmente as estatísticas básicas
# de cada registro da coluna "measure", assim como conter uma variável "data"
# que inclua o "ano/mes/dia" de cada registro.
# Realizar um gráfico da variável "Max.TemperatureF" ao longo do tempo registrado
# Salvar o arquivo final como "clima_aed.csv" em formato csv2
# 

#-------------------------------------------------------------------------------
# SOLUÇÂO:

# leitura do arquivo, qual a dimensão? que tipo de variáveis e medições contém?

# primeiro vamos a acertar os nomes das variáveis

# segundo passo, criar uma variável day com valores registrados

# terceiro passo, vamos espalhar a variável "measure" 

# quarto passo, ordenar a data

# quinto passo, criar uma nova variável como "data"

# sexto passo, transformar as colunas em numéricas para eliminar NAs

# dica de transformação, verificar as colunas transformadas
clima5[,c(2,4:23)] <- apply(clima5[,c(2,4:23)], 2, function(x) as.numeric(x))

# a variável "Events" que deveria ser fator está como carater, vamos mudar...

# sétimo passo, eliminar NAs

# oitavo passo, resumo, estatísticas

# nono passo, gráfico solicitado

# décimo passo, salvando o arquivo final

# FIM DO EXERCÍCIO