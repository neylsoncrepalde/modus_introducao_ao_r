5 + 6   # adição
5 - 8   #subtração
4 / 2   # divisão
10 * 3  # multiplicação
5^2     # Elevo ao quadrado
5^3     # Elevo ao cubo

sqrt(25) # Raiz quadrada
exp(10)  # exponencial
log(22026.47)  #log natural

#####################
x <- 5  # x recebe 5
x       # exibe o x
y <- 7  # y recebe 7
y       # exibe o y

x + y   
x / y

sqrt(x) + log(y*4)
ls()    # lista os objetos no ambiente
rm(y)   # remove o y
ls()    #lista os objetos no ambiente


y <- 12

x + y
x <- 2

#######################
x <- c(5, 7, 3, 14)
y <- c(4, 9, 13, 56)
x
y

x + y

class(x)

idades <- c(31L, 21L, 25L, 32L)
idades
class(idades)

###################
nome <- "Neylson"
nome
class(nome)
sobrenome <- "Crepalde"
sobrenome
nome_completo <- c(nome, sobrenome)
nome_completo
length(nome_completo)

novo <- paste(nome, sobrenome, sep = "")
novo
paste0(nome, sobrenome)

help(paste)
###############
# Matrizes
A <- matrix(data = 1:16, ncol = 4, nrow = 4)
A
B <- matrix(data = 1:16, ncol = 4, nrow = 4, byrow = T)
B

class(A)

A + B
A * B  #Multiplicação
A %*% B   #Produto interno

C <- A
########
logicos <- c(TRUE, T, FALSE, F)
logicos

5 > 2  #Maior que
5 < 2  #menor que
a <- 1 #atribuição
a
a = 2  #atribuição
a

5 == 5 #testa igualdade
5 == 6 #
x == 6
5 != 7 # é diferente de

nome
is.character(nome)
is.numeric(nome)
###########################

# Data frames

nomes = c("Neylson", "Gabi", "Jonatas","Marina")
nomes
idades = c(31, 23, 57, 22)
idades
idades = as.integer(idades)
class(idades)

curso = c("Sociologia", "Economia", "GP", "Ciências Sociais")
curso

dados = data.frame(nomes, idades, curso)
dados
class(dados)
######################
dados
dados$idades
class(dados$idades)
class(dados$curso)

dados$sexo = c("M", "F", "M", "F")
dados
dados$sexo
dados$sexo = as.factor(dados$sexo)
dados$sexo

dados
dados[[4]]
dados[4]
class(dados[4])
class(dados[[4]])

mean(dados[[2]])
mean(dados$idades)

nomes
length(nomes)

nomes[2:4]
nomes[c(2,4)]

dados[3,2]
dados[4,2]

dados[2, ]
dados[ ,2]

dados[2]
