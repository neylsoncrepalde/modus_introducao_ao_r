########################
## Introdução ao R
## MODUS
## Aula 4
## Neylson Crepalde
########################

library(readr)
library(dplyr)
library(descr)
library(ggplot2)
library(magrittr)

## Lê os dados
pnad <- read_csv("https://raw.githubusercontent.com/neylsoncrepalde/introducao_ao_r/master/dados/pes_2012.csv")

# Transforma a variável RENDA em numeric
pnad$V4720 = as.numeric(pnad$V4720)

# Tranformando a variável anos de escolaridade
# em uma variável numérica
pnad$ESC = pnad$V4803
pnad$ESC = gsub(" anos", "", pnad$ESC)
pnad$ESC = gsub(" ano", "", pnad$ESC)
pnad$ESC = gsub(" ou mais", "", pnad$ESC)
pnad$ESC[pnad$ESC == "Sem instrução e menos de 1"] = "0"
pnad$ESC[pnad$ESC == "Não determinados"] = NA
pnad$ESC = as.integer(pnad$ESC)
summary(pnad$ESC)

###########################
# Cria uma variável binária brancos e Negros
# Negros = Pretos e Pardos
pnad = pnad %>% 
  mutate(Branco = case_when(
    V0404 == "Branca" ~ "Branco",
    V0404 == "Preta" ~ "Negro",
    V0404 == "Parda" ~ "Negro"
  ))

##############################
## Visualizando alguns dados
# Estrutura geral da sintaxe do ggplot
# ggplot(BANCODEDADOS, aes(x = VARIAVEL, y = VARIAVEL)) +
# geom_TIPODEGRAFICO() + CUSTOMIZACOES
# install.packages("ggthemes")
library(ggthemes)
help("ggplot2")

ggplot(pnad, aes(x = V8005)) +
  geom_histogram(color = "white", fill = "orange") +
  labs(x = "Age", y = "Frequency", title = "Age distribution") +
  theme_bw()

ggplot(pnad, aes(x = V0404)) +
  geom_bar() +
  coord_flip()

pnad %>% filter(V0404 != "Sem declaração") %>% 
  ggplot(aes(x = V0404)) +
  geom_bar() +
  coord_flip()


pnad %>% filter(V4720 <= 2000) %>% 
  ggplot(aes(x = V0302, y = V4720, fill = V0302)) +
  geom_violin()


ggplot(pnad, aes(x = V8005, y = V4720)) +
  geom_point()

ggplot(pnad, aes(x = V8005, y = ESC)) +
  geom_point()

cor(pnad$V4720, pnad$V8005, use = "complete.obs")

# Gerando dados aleatórios para mostrar correlação forte
x = rnorm(1000)
y = x*2 + rnorm(1000)
ggplot(NULL, aes(x, y)) + 
  geom_point() +
  stat_smooth(method = "lm")
cor(x, y)

##########################

# Correlacionando Idade e renda
cor(pnad$V8005, pnad$V4720, use = "complete.obs")
cor.test(pnad$V8005, pnad$V4720, use = "complete.obs")
options(scipen = 999)

# Cruzar uma variável categórica e uma numérica
# Sexo e Renda
#t.test(pnad$V4720, pnad$V0302) # Corrigir









