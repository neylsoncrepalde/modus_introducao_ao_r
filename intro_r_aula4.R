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
#options(scipen = 999)

# Cruzar uma variável categórica e uma numérica
# Sexo e Renda
# Tem que tirar os NA's primeiro senão não funciona!

# No comando t.test, usamos o ~ para indicar as médias pelos grupos da variável à direita
t.test(pnad$V4720 ~ pnad$V0302)

# Só que esse resultado é viesado pois estamos calculando as médias sem levar em conta
# os pesos amostrais. Para isso, vamos utilizar o pacote survey

#install.packages("survey") # para instalar, descomente esta linha ;)
library(survey)
pnad_com_peso = svydesign(ids = ~0, weights = ~V4729, data = pnad)
svyttest(V4720 ~ V0302, pnad_com_peso)       # calcula a diferença e testa
svyby(~V4720, ~V0302, pnad_com_peso, svymean, na.rm = T)  # Verifica as médias por grupo


##### Fazendo a mesmíssima coisa com o pacote srvyr que possui integração com dplyr e tidyverse
#install.packages("srvyr")
library(srvyr)
pnad_srvyr = pnad %>% as_survey_design(ids = 1, weights = V4729)
pnad_srvyr %>% group_by(V0302) %>% 
  summarise(media = survey_mean(V4720, na.rm = T)) # Calcula a média por grupos
# usando survey pra calcular a diferença e testar em cima de um objeto srvyr
svyttest(V4720 ~ V0302, pnad_srvyr)  # ;)



### Agora vamos testar a associação entre duas variáveis categóricas
# Fazemos uma tabela cruzada e rodamos um teste qui-quadrado (chi square)
tabela = table(pnad$V0404, pnad$V0302)
chisq.test(tabela)


## Agora levando em conta os pesos amostrais
svytable(~V0404+V0302, pnad_srvyr)
svychisq(~V0404+V0302, pnad_srvyr)

# Tabela de proporções levando em conta o peso
prop.table(svytable(~V0404+V0302, pnad_srvyr), 2) * 100
