#############################
## Introdução ao R
## MODUS
## Aula 3
## Neylson Crepalde
#############################

library(readr)
library(dplyr)
library(descr)
#install.packages("ggplot2")
library(ggplot2)
library(magrittr)

rm(list=ls())

## Lê os dados
pnad <- read_csv("https://raw.githubusercontent.com/neylsoncrepalde/introducao_ao_r/master/dados/pes_2012.csv")

dim(pnad)
names(pnad)
head(pnad)

# names(pnad) <- c("ANO", "UF", "SEXO", "IDADE", "COR", "ESC", "RENDA",
#                  "RENDAT", "PESO")
# head(pnad)
#####################################
# Calculando uma média ou qualquer outra estatística
# descritiva num banco de dados que foi gerado
# a partir de uma pesquisa que possui amostragem complexa, 
# incorremos em erro se não considerarmos o plano amostral/peso
# amostral nas análises

mean(pnad$V8005, na.rm = T)   ## Errado
weighted.mean(pnad$V8005, pnad$V4729, na.rm = T)  # CERTO!!! ;)

pnad$V4720 = as.numeric(pnad$V4720)
summary(pnad$V4720)

mean(pnad$V4720, na.rm = T)  #Errado
weighted.mean(pnad$V4720, pnad$V4729, na.rm = T) #Correto!!! ;)

### Calculando a média de salário de brancos e negros
# Nativo
mean(pnad$V4720[pnad$V0404 == "Branca"], na.rm = T)
mean(pnad$V4720[pnad$V0404 == "Preta"], na.rm = T)

weighted.mean(pnad$V4720[pnad$V0404 == "Branca"], 
              pnad$V4729[pnad$V0404 == "Branca"],
              na.rm = T)

weighted.mean(pnad$V4720[pnad$V0404 == "Preta"], 
              pnad$V4729[pnad$V0404 == "Preta"],
              na.rm = T)


##### Tidy
pnad %>% 
  filter(V0404 == "Branca" | V0404 == "Preta") %>% 
  group_by(V0404) %>% 
  summarise(media = mean(V4720, na.rm = T),
            mediap = weighted.mean(V4720, V4729, na.rm = T))


##############
# Tidy
# Cria uma variável binária brancos e Negros
# Negros = Pretos e Pardos
pnad %>% 
  mutate(Branco = case_when(
    V0404 == "Branca" ~ "Branco",
    V0404 == "Preta" ~ "Negro",
    V0404 == "Parda" ~ "Negro"
  )) %>%
  group_by(Branco) %>% 
  summarise(media = mean(V4720, na.rm = T),
            mediap = weighted.mean(V4720, V4729, na.rm = T))

### Diferença de renda por sexo
pnad %>% 
  group_by(V0302) %>% 
  summarise(mediap = weighted.mean(V4720, V4729, na.rm = T))

######
# Tabela Cruzada
t1 = table(pnad$V0404, pnad$V0302)
t1

# Tabela com proporções (percentuais)
round(prop.table(t1, 1) * 100, 2) #porcentagem na linha
round(prop.table(t1, 2) * 100, 2) #porcentagem na coluna

###
# Observando uma correlação entre duas variáveis numéricas
cor(pnad$V8005, pnad$V4720, use = "complete.obs")

plot(pnad$V8005, pnad$V4720)

####
# Estudar anos de esc e renda
class(pnad$V4803)
head(pnad$V4803)
table(pnad$V4803)

pnad$ESC = pnad$V4803
pnad$ESC = gsub(" anos", "", pnad$ESC)
pnad$ESC = gsub(" ano", "", pnad$ESC)
pnad$ESC = gsub(" ou mais", "", pnad$ESC)
pnad$ESC[pnad$ESC == "Sem instrução e menos de 1"] = "0"
pnad$ESC[pnad$ESC == "Não determinados"] = NA

pnad$ESC = as.integer(pnad$ESC)

summary(pnad$ESC)

plot(pnad$ESC, pnad$V4720)

cor(pnad$ESC, pnad$V4720, use = "complete.obs")

#######
head(pnad)
pnad = pnad %>% select(-ESC)
head(pnad)

pnad %>% select(UF:V4803)

pnad %>% select(UF:V4720, -V8005)

