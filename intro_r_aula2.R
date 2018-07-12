data("iris")

##### Trabalhando com o banco de dados IRIS
help(iris)

#tidy

# Banco de dados IRIS
iris

head(iris) #primeiros casos
tail(iris) #últimos casos

names(iris) #nomes das variáveis
dim(iris)   #dimensões
nrow(iris)  #qtd de linhas
ncol(iris)  #qtd de colunas

str(iris)   #estrutura

sapply(iris, class)

#####################
min(iris$Sepal.Length)
max(iris$Sepal.Length)
mean(iris$Sepal.Length)
median(iris$Sepal.Length)
var(iris$Sepal.Length)
sd(iris$Sepal.Length)
quantile(iris$Sepal.Length)

summary(iris$Sepal.Length)

# usando sapply para executar
# uma função em várias variáveis
# de uma só vez

medias = sapply(iris[1:4], mean)
round(medias, 2)

sapply(iris[1:4], sd)

tabela = table(iris$Species)
prop.table(tabela) * 100

###################
# descr
#install.packages("descr")

library(descr)
freq(iris$Species)

#install.packages("stargazer")
library(stargazer)

citation("descr")

t1 = freq(iris$Species)
stargazer(t1, type = "html", out = "tabela.html")
########################
# Nativo

mean(iris$Sepal.Length[iris$Species == "setosa"])
mean(iris$Sepal.Length[iris$Species == "versicolor"])
mean(iris$Sepal.Length[iris$Species == "virginica"])

# Calculando a diferença entre as médias de tamanho
# de sépala para setosa e virginica
media_setosa = mean(iris$Sepal.Length[iris$Species == "setosa"])
media_setosa
media_virginica <- mean(iris$Sepal.Length[iris$Species == "virginica"])
media_virginica

media_setosa - media_virginica

#############################
# Tidyverse
#install.packages("dplyr")
library(dplyr)

iris %>% select(Sepal.Length) %>% summarise(media = mean(Sepal.Length))

iris %>% filter(Species == "setosa") %>% summarise(mean(Sepal.Length))

iris %>% filter(Species == "setosa") %>% 
  summarise(m = mean(Sepal.Length),
            desv = sd(Sepal.Length),
            variancia = var(Sepal.Length),
            mediana = median(Sepal.Length))

descritivas = iris %>% filter(Species == "virginica") %>% 
  summarise(m = mean(Sepal.Length),
            desv = sd(Sepal.Length),
            variancia = var(Sepal.Length),
            mediana = median(Sepal.Length))


############
#####
mean((iris$Sepal.Length+3)/2) * 10

library(magrittr)
iris$Sepal.Length %>% add(3) %>% divide_by(2) %>% mean %>% 
  multiply_by(10)

# Media, mediana, desvpad e var para as 3 especies
mean(iris$Sepal.Length[iris$Species == "setosa"])
mean(iris$Sepal.Length[iris$Species == "versicolor"])
mean(iris$Sepal.Length[iris$Species == "virginica"])

sd(iris$Sepal.Length[iris$Species == "setosa"])
sd(iris$Sepal.Length[iris$Species == "versicolor"])
sd(iris$Sepal.Length[iris$Species == "virginica"])

median(iris$Sepal.Length[iris$Species == "setosa"])
median(iris$Sepal.Length[iris$Species == "versicolor"])
median(iris$Sepal.Length[iris$Species == "virginica"])

var(iris$Sepal.Length[iris$Species == "setosa"])
var(iris$Sepal.Length[iris$Species == "versicolor"])
var(iris$Sepal.Length[iris$Species == "virginica"])

descritivas = iris %>% group_by(Species) %>% 
  summarise(m = mean(Sepal.Length),
            mediana = median(Sepal.Length),
            desv = sd(Sepal.Length),
            var = var(Sepal.Length))
descritivas


#######################
###
#install.packages("readr")
library(readr)
pnad = read_csv("https://raw.githubusercontent.com/neylsoncrepalde/introducao_ao_r/master/dados/pes_2012.csv")

dim(pnad)
head(pnad)

freq(pnad$V0302)
freq(pnad$V0404) %>% round(., 2)

length(pnad$UF[pnad$UF == "Minas Gerais" & 
                 pnad$V0404 == "Branca"])

pnad %>% filter(UF == "Minas Gerais", V0404 == "Branca") %>% 
  summarise(n = n())

#### QUanto ganham pessoas brancas e pretas em MG
# Nativo
pnad$V4720 = as.numeric(pnad$V4720)
mean(pnad$V4720[pnad$UF == "Minas Gerais" &
                  pnad$V0404 == "Branca"], na.rm = T)

mean(pnad$V4720[pnad$UF == "Minas Gerais" &
                  pnad$V0404 == "Preta"], na.rm = T)

renda = pnad %>% filter(UF == "Minas Gerais") %>% 
  filter(V0404 == "Branca" | V0404 == "Preta") %>% 
  group_by(V0404) %>% summarise(media = mean(V4720, na.rm = T))
renda$media %>% round(., 2)












