vazvisi <- function(dados, d_caval = 0.02*0.1, d_ramal = 0.02, d_adut = 0.025 , d_rede = 0.025, g = 9.81, C = 0.61,Hrede = 7, Hadut = 20, cp_rede = 181, cp_adut = 2, nlig = 43000, N1vis = 0.8, TMA = 24){
  
  
  ##########################################################################################################
  
  #Essa parte calcula o volume dos vazamentos de acordo com o diâmetro do orificio (o diâmetro varia, mas utilizamos um diâmetro médio)
  n <- dados$prazo_exec*dados$num_vazamentos 
  names(n) <- c("cavalete", "ramal", "adutora", "rede")
  d = data.frame(d_caval,d_ramal, d_adut, d_rede)
  S = (d^2)*pi/4
  
  caval <- n[1]
  ramal <- n[2]
  adutora <- n[3]
  rede <- n[4]
  
  
  
  
  ###########################################################################################################
  #Essa parte do código calcula o vazamento em m3 gerado em um mês em cada um dos sistemas:
  # adutora, rede, cavalete e ramal
  
  qm3_dia_caval <- caval*(C*S[1]*(2*g*Hrede)^0.5)*3600*24 #Variável modificada de qm3_mes_caval para qm3_dia_caval, o mesmo ocorre nas variáveis que tiverem o asterisco.
  qm3_dia_ramal <-ramal*(C*S[2]*(2*g*Hrede)^0.5)*3600*24 #*
  qm3_dia_adutora <-adutora*(C*S[3]*(2*g*Hadut)^0.5)*3600*24 #*
 
  qm3_dia_rede <- rede*(C*sqrt(2*g))*((S*Hrede^0.5) + ((S/Hrede)*(N1vis-0.5)/(1.5-N1vis))*Hrede^1.5)*3600*24 #DEYI et al (2014) *
  
  
  qm3_total_dia <- data.frame(qm3_dia_caval, qm3_dia_ramal, qm3_dia_adutora, qm3_dia_rede) #*

 
  
  ###########################################################################################################
  ### Esses são os cálculos realizados para adequação da data.frame qm3_mes_geral    ao padrão ECONOLEAK
  ### As variáveis calculadas abaixo são as frequências de vazamentos em volume.
  
  carga_rede <- cp_rede*Hrede*31 #Denominadores da fórmula da frequência
  carga_ramal <- nlig*Hrede*31
  carga_adut <- cp_adut*Hadut*31
  
  qL_km_dia_cavalete <- (qm3_total_dia[1]/carga_ramal)*1000 # Utiliza-se a carga utilizada no ramal. Frequencia cavalete
  qL_km_dia_ramal <- (qm3_total_dia[2]/carga_ramal)*1000    #Frequência ramal
  qL_km_dia_adutora <- (qm3_total_dia[3]/carga_adut)*1000   #Frequência adutora
  qL_km_dia_rede <- (qm3_total_dia[4]/carga_rede)*1000      #Frequência rede.
  
  #Agora calcularemos esses dados nas seguintes unidades:
  # l/s
  #m3/h
  #m3/dia
  #m3/ano
  tempo <- 3600*24
  qL_s_rede <- (qL_km_dia_rede*carga_rede/31)/tempo
  qL_s_cavalete <- ((qL_km_dia_cavalete)*carga_rede/31)/tempo
  qL_s_ramal <- ((qL_km_dia_ramal)*carga_ramal/31)/tempo
  qL_s_adutora <- ((qL_km_dia_adutora)*carga_adut/31)/tempo
  
  
  
  
  qL_s_sistemas <- data.frame(cavalete = qL_s_cavalete, 
                              ramal = qL_s_ramal, 
                              adutora = qL_s_adutora, rede = qL_s_rede)
  
  rownames(qL_s_sistemas) <- "vazao (l/s)"
  
  qm3_h_sistemas <- qL_s_sistemas*3.6
  
  rownames(qm3_h_sistemas) <- "vazao (m3/h)"
  
  qm3_d_sistemas <- qm3_h_sistemas*24
  colnames(qm3_d_sistemas) <- c("Cavalete", "Ramal", "Adutora", "Rede")
  
  rownames(qm3_d_sistemas) <- "vazao (m3/dia)"
  
  qm3_ano_sistemas <- qm3_d_sistemas*365.25
  rownames(qm3_ano_sistemas) <- "vazao (m3/ano)"
  
  ###########################################################################################################
  
  UARL <- data.frame(UARL = 365.25*(18*(cp_adut+cp_rede) + 0.8*nlig)*Hrede*(TMA/24)/1000) #[m3/ano]
  total_visi <- data.frame(sum(qL_s_sistemas),sum(qm3_h_sistemas),sum(qm3_d_sistemas),sum(qm3_ano_sistemas))
  colnames(total_visi) <-c("l/segundo","m3/hora", "m3/dia", "m3/ano")


  
  
 
  total_visiveis <- list(total_visi, UARL, qm3_d_sistemas) 
  return (total_visiveis)
  
  
}
