
num_vazamentos <- function (dados) {
  
  library(dplyr)
  
 
  
  #Adapta??o da quantidade de vazamentos da planilha de RA's
  
  
  
  ntcavalete <- dados$Numero_de_vazamentos[2]+ dados$Numero_de_vazamentos[3] # Total de cavaletes + Total de Hidr?metros
  
  ntramal = ceiling(0.9*dados$Numero_de_vazamentos[4]) + dados$Numero_de_vazamentos[1] # 90% das RA's de Rua s?o de ramais
  
  ntrede = dados$Numero_de_vazamentos[4] - ntramal + dados$Numero_de_vazamentos[1]  #0.1*ntrua % 10% das RA's de Rua s?o na rede
  
  ntadut = dados$Numero_de_vazamentos[5] # É relatado que a adutora geralmente vaza de 1 a 2 vezes ao ano
  
  nthidro <- dados$Numero_de_vazamentos[3]
  ntcal <- dados$Numero_de_vazamentos[1]
  # Os dados inicialmente s?o coletados para toda macei?. 
  #Admitimos que uma determinada porcentagem p% ? referente ? ?rea de estudo
  
  p = 1# percentual de RA na zona
  
  vetor_vaz_totais <-c(ntcavalete, ntramal, ntadut, ntrede)
  prazo_exec = c(mean(c(dados$prazo_exec[2],dados$prazo_exec[3])),mean(c(dados$prazo_exec[1],dados$prazo_exec[4])),dados$prazo_exec[5], dados$prazo_exec[4])
  
  vaz_totais <-data.frame(tipo = c("cavalete", "ramal", "adutora", "rede"), 
                                num_vazamentos = vetor_vaz_totais, prazo_exec)
  
  vetor_vaz_ZBI <- p*vetor_vaz_totais
  
  vaz_ZBI <- data.frame(tipo = c("cavalete", "ramal", "adutora", "rede"), num_vazamentos = vetor_vaz_ZBI, prazo_exec)
  
  
  x <- list(vaz_ZBI, vaz_totais)
  
  return (x)
  
  
}






