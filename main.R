##########################################

#Esse script recebe uma planilha anual de vazamentos de uma determinada região, incluindo vazamentos em 
#calçada, hidrometro, cavalete, ramal e rede. A planilha possui o nome da rua onde  o vazamento foi reportado e
#o período de abertura e fechamento da RA, este representando o período de vazamento em dias. 

#Através dessa planilha de vazamentos é possível contar o período de cada vazamento e a quantidade média de vazamentos
#no mês.

#A partir daí  o script calcula uma série de indicadores de vazamentos para a região  (checar a disseertação), 
#incluindo a estimativa  de perdas inerentes, visíveis e invisíveis.

#comentario de teste


#1 - ####
#Carregamento das bibliotecas e das funções


library("tidyverse")

source('lerRAS1.R')

source('tdtcd.R')

source('num_vazamentos.R')

source('vazvisi.R')

source('vaz_iner.R')

source('IVI.R')

source('inter.R')

source('INDI.R')

source('piinev.R')

#2 - ####
# Essa etapa lida com as manipulações iniciais das planilhas, transforma e cria variáveis que serão utilizadas
#no decorrer do código

lerRAS1() ## Essa funÇão le as planilhas de vazamentos
# É necessário haver outra função que calcule a média mensal com várias planilhas

#Esses dados são necessários para os cálculos de vazamento. Todos os comprimentos utilizados são em Km
cp_rede = 181 #(km) Comprimento da linha de distribuicao 
cp_adut = 2   #(km) Comprimento da linha de aducao
Hrede = 7     #(mca) Pressão na rede 
Hadut = 20    #(mca) Pressão na adutora
nlig = 17107  # Número de ligações ativas

N1iner = 1.5  # Coeficiente N1 da equação (Consultar Eq 5 literatura  texto). Valor fixo para vazamentos inerentes.
N1vis = 1     # Coeficiente N1 da equação (Consultar Eq 5 literatura  texto). Grandes sistemas com mescla de materiais apontam N1 entre 1-1.15.

cp_caval = 0.5/1000 

TMA = 24 #Dado fornecido (Tempo Médio de Abastecimento)
v_forn = 11447748   #(m3/ano)
v_fat = 7082796     #(m3/ano)
FCI = 3             #(SABESP, mas também pode ser calculado)
RLN =550000         #Valor adotado apenas para teste./ Volume anual de perdas reais em N anos anteriores.

volume_reserv = 8000000 # (litros)
Nanos = 1               # Número de anos
x = 2.5                 #


calcada<- tdtcd(calcada)      # A função recebe uma planilha como argumento,
rua <- tdtcd(rua)            # calculando o tempo total de cada vazamento.                                
cavalete <- tdtcd(cavalete)
hidrometro <- tdtcd(hidrometro)

# Aqui foram retirados os valores faltosos e criada uma nova coluna em cada data frame para classificar o tipo 
# de vazamento, se foi na calcada, rua, hidrometro ou cavalete

calcada <- calcada %>% na.omit() %>% mutate(tipo = "calcada")
rua <- rua %>% na.omit() %>%  mutate(tipo = "rua")
hidrometro <- hidrometro %>% na.omit() %>% mutate(tipo = "hidrometro")
cavalete <- cavalete %>% na.omit() %>% mutate(tipo = "cavalete")

x.n <- c('calcada','rua','cavalete','hidrometro') # Foi tudo colocado numa lista
x.list <- lapply(x.n, get) # Reune todos os dataframes separados em uma lista.
vazamentos_qtd_prz <- do.call(rbind, x.list) #Concatenou todos os dataframes.

# Aqui os dados foram agrupados por tipo de vazamento e foi calculado o prazo médio de vazamento 
# e também adicionado o número total de vazamentos de cada tipo

vazamentos_qtd_prazo  <- group_by(vazamentos_qtd_prz,tipo) %>% summarise(prazo_exec = mean(dias))

vazamentos_qtd_prazo$Numero_de_vazamentos <- c(nrow(calcada),   
                                               nrow(cavalete),
                                               nrow(hidrometro),
                                               nrow(rua))       

# Aqui a adutora é colocada de forma isolada 
adutora <- data.frame(tipo = "adutora", prazo_exec = 0.25, Numero_de_vazamentos = 0.08)
# Realizando o append por linhas
vazamentos_qtd_prazo <- rbind(vazamentos_qtd_prazo, adutora)
# data frame com a quantidade de vazamentos de cada tipo de vazamento 

qtd_vaz <- data.frame(sistema = c("rua", "cavalete", "hidrometro","calcada", "adutora"), 
                      qtd_vazamentos = c(nrow(rua),nrow(cavalete),nrow(hidrometro), 
                                         nrow(calcada),0.08)) 

# Exportação de umn csv com as informações de prazo médio e quantidade média de vazamentos por mês

write.csv(vazamentos_qtd_prazo, file = "dados_vazamentos_totais.csv",row.names=FALSE) 

#Até aqui o programa prepara os dados para exportar pra um arquivo csv os dados referentes aos sistemas
## e o numero e prazo de execução para cada sistema adaptado ao ECONOLEAK

dados <- num_vazamentos(vazamentos_qtd_prazo) #

#Calculo da frequencia de vazamentos visiveis por RA.
frequencia_vaz_vis <- dados[[1]]$num_vazamentos*12/data.frame(valores = c(nlig,nlig,cp_adut,cp_rede)) #Conforme a tabela 29.
frequencia_vaz_vis[2] <- c("RA/lig.ano", "RA/lig.ano", "RA/km.ano", "RA/km.ano")
rownames(frequencia_vaz_vis) <- c("cavalete", "ramal", "adutora", "rede")
colnames(frequencia_vaz_vis) <- c("Frequencia de Ocorrencia", "Unidade")


# O calculo da frequencia de vazamentos não-visiveis considera-se 50% dos vazamentos vísiveis.
frequencia_vaz_invi <- data.frame("Frequencia de Ocorrencia" = frequencia_vaz_vis$`Frequencia de Ocorrencia`*0.5, "Unidade" = frequencia_vaz_vis$Unidade)
rownames(frequencia_vaz_invi) <- c("cavalete", "ramal", "adutora", "rede")


area_estudo_vazamentos <- as.data.frame(dados[1])
total_vazamentos <-as.data.frame(dados[2])

# A data frame area_estudo_vazmentos é mandada como argumento para a função de cálculo de vazamentos visíveis

#3 - ####
#Cálculo de vazamentos visíveis, invisíveis e inerentes

# Cálculo dos vazamentos visiveis
vazvisivi <- vazvisi(area_estudo_vazamentos, N1vis = N1vis) ##### corrigir para a pressao (pag 26 do user's guide)
                                                            #Adotar Power Expoent de 0,5 para vazamentos visiveis
                                                            #Adotar Power Expoent de 1 para vazamentos não-visiveis
volume_vazamentos_visiveis <- as.data.frame(vazvisivi[1])
volume_vazamentos_visiveis_sistemas <-as.data.frame(vazvisivi[3])


# Cálculo dos vazamentos inerentes
vaziner<- vaz_iner(Hrede, Hadut,volume_reserv, cp_rede, cp_adut, nlig, N1iner, FCI,x)
volume_vazamentos_inerentes <- as.data.frame(vaziner[1])
volume_vazamentos_inerentes_sistemas <- as.data.frame(vaziner[2]) 
rownames(volume_vazamentos_inerentes_sistemas) <- c(" vazao (m3/dia)")


# Cálculo dos vazamentos não-visiveis
volume_vazamentos_invisiveis <- volume_vazamentos_visiveis*0.5 # 50% dos vazamentos visiveis como recomenda o ECONOLEAK
volume_vazamentos_invisiveis_sistemas <- volume_vazamentos_visiveis_sistemas*0.5


UARL <- vazvisivi[2] 

#4 - ####

#Cálculo do total de vazamentos (visíveis, invisíveis e inerentes)

PTtotal <- volume_vazamentos_invisiveis+volume_vazamentos_visiveis +volume_vazamentos_inerentes

#5 - ####

# Cálculo do IVI

Indice_vazamento_infraestrutura <- IVI(v_forn, v_fat, PTtotal[4], UARL)

#6 - ####

#Cálculos intermediários para o NeV
c_unit = 301.55 # R$/km Custo unitário de pesquisa

#Custo marginal da água
custo_energia = 0.35 #R$
custo_prodquim = 0.02 #R$
CVariavel = custo_energia + custo_prodquim 


inter <- inter(PTtotal[4], RLN, cp_rede, c_unit, CVariavel, Nanos)


#7 - ####
#Dados de custos
# Aqui teremos que entrar em contato com a ENOPS para podermos verificar os valores
pesquisa_correlacao = 301.55
cobertura_correlacao = inter$`EIF(meses)`/100

# Tabela 38 da dissertação
medicao_vazao_noturna_minima = 3500 #Custo para a medição da vazão mínima noturna
repo_pav = 395.68
repo_cal = 361.65
repo_lig = 167.83
repo_vazvis = 1453.57
custo_sondagem =0
custo_adm = 0

#Custo mao de obra de inspeção
custo_mao_de_obra_inspecao = (custo_sondagem + (cobertura_correlacao)*pesquisa_correlacao)*cp_rede
custo_moi <- custo_mao_de_obra_inspecao*c(0.5,1,2) %>% t() %>% as.data.frame()
colnames(custo_moi) <- c("A cada 2 anos", "A cada 1 ano", "A cada 6 meses")
rownames(custo_moi) <- "Custo(R$)"
#Custo de reparo na rede e adutora
custo_radt <- (area_estudo_vazamentos[3,2]/2 + area_estudo_vazamentos[4,2]/2)*(repo_vazvis) # Aqui dividi por 2, pois
# Na planilha ele realizava esse cálculo com o número de vazamentos não-visíveis. Uma vez sendo este número 50% do de
# vazamentos visíveis, dividimos por 2. De forma análoga foi realizado o cálculo abaixo.
#Custo de reparo em ligações (ramais + cavaletes)
custo_ramcaval <- (area_estudo_vazamentos[2,2]/2 + area_estudo_vazamentos[1,2]/2)*(repo_lig)
custo_radt <- rep(custo_radt,3)
custo_ramcaval <- rep(custo_radt,3)

tabela5c <- rbind(custo_moi, custo_radt, custo_ramcaval)
custo_total<- apply(tabela5c, 2, sum)
tabela5c <- rbind(tabela5c, custo_total)
#perdas_financeiras_anuais <- CVariavel*PTtotal[4]
colnames(tabela5c) <-c("A cada 2 anos", "A cada 1 ano", "A cada 6 meses")
rownames(tabela5c) <-c("Custo Mao Obra", "Custo reparo Adut e rede", "Custo reparo ramal e caval", "Custo total")


#8 - #####
#Cálculo dos indicadores de perdas 

indicadores_perdas <- INDI(v_forn, v_fat, PTtotal, nlig, cp_rede, cp_adut)

#9 - ####
#Cálculo da tabela 4e, intermediária para construção das demais tabelas

tempo_reparo_invisiveis <- dados[[1]][3]
qtd_vazamentos_invisiveis <- dados[[1]][2]/2
pressoes_razao <- c(Hrede, Hrede, Hadut, Hrede)/50
coefs <- c(1.6,1.6,6,12) # tabela 4e

# o Array de pressoes é simplesmente a razão da pressão do sistema por 50 (fórmula)
volumes_invi_4e <-coefs*qtd_vazamentos_invisiveis*(24/365)*pressoes_razao 


every2 <- volumes_invi_4e[1]*(365 + tempo_reparo_invisiveis)

every1 <-volumes_invi_4e[1]*(365/2 + tempo_reparo_invisiveis)

every6m <- volumes_invi_4e[1]*(365/4 + tempo_reparo_invisiveis)


volumes_tabela4e <- data.frame(volumes_invi_4e, every2, every1, every6m)
colnames(volumes_tabela4e) <- c("m3/dia", "A cada 2 anos", "A cada 1 ano", "A cada 6 meses")
rownames(volumes_tabela4e) <- c("cavalete", "ramal", "adutora", "rede")

#10- ####
# Cálculos para as perdas inerentes inevitáveis

pressoes <- (pressoes_razao)*50 
comprimentos <- c(nlig, nlig, cp_adut, cp_rede)
coeficientes <- (volume_vazamentos_visiveis_sistemas*1000)/(24*comprimentos)
rownames(coeficientes) <- "vazao (l/hr*km)"

volume_inerente_inevitavel_sistemas <- piinev(pressoes, comprimentos, coeficientes, N1iner)


# Referente ao Base Level of Real Losses da tabela 6b. 
volumes_totais_inerentes_visiveis <- volume_vazamentos_visiveis_sistemas + volume_inerente_inevitavel_sistemas

volumes_tabela4e2 <- volumes_tabela4e[,-1]

cavalete7 <- volumes_tabela4e2["cavalete", ]
ramal7 <- volumes_tabela4e2["ramal", ]
adutora7 <- volumes_tabela4e2["adutora",]
rede7 <- volumes_tabela4e2["rede",]
reservacao7 <- data.frame(rep(volume_vazamentos_inerentes_sistemas$Reservacao, 3))
reservacao7 <- as.data.frame(t(reservacao7))
colnames(reservacao7) <- c("A cada 2 anos", "A cada 1 ano", "A cada 6 meses")
rownames(reservacao7) <- "reservacao"
volumes_tabela7 <- rbind(cavalete7, ramal7, adutora7, rede7,reservacao7 )
total_m3dia <- apply(volumes_tabela7,2,sum)
total_m3ano <- total_m3dia*365.25
custo_total_ano <- total_m3ano*CVariavel
tabela7 <- rbind(volumes_tabela7, total_m3dia, total_m3ano, custo_total_ano)
colnames(tabela7) <- c("A cada 2 anos", "A cada 1 ano", "A cada 6 meses")
rownames(tabela7) <- c("cavalete", "ramal", "adutora", "rede","reservacao","total(m3/dia)", "total(m3/ano)", "Custo total (R$)")


tabela8 <- data.frame(as.vector(t(tabela5c["Custo total",])), as.vector(t(tabela7["Custo total (R$)",])))
aux <- apply(tabela8, 1, sum)
tabela8 <- cbind(tabela8, apply(tabela8,1,sum))
colnames(tabela8)  <- c("Custo interv", "Custo da perda", "Total")
rownames(tabela8) <- c("2a", "1a", "6m")


tabela8 <-t(tabela8) %>% as.data.frame() %>%  select("6m", "1a", "2a")


custo_interv <- c(tabela8[1,3],tabela8[1,2], tabela8[1,1])
custo_total_tudo <- c(tabela8[3,3], tabela8[3,2], tabela8[3,1])

xvolume_total_perda<- c(tabela7["total(m3/ano)",3],tabela7["total(m3/ano)",2], tabela7["total(m3/ano)",1]) 
ycusto_total_perda<- c(tabela7["Custo total (R$)",3],tabela7["Custo total (R$)",2], tabela7["Custo total (R$)",1])
