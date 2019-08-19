piinev <- function(pressoes, comprimentos, coeficientes, N1iner){
  
  qiinevm3_dia_adutora <- (coeficientes[3]*comprimentos[3]*(pressoes[3]/50)^N1iner)*(24/1000)
  qiinevm3_dia_rede <- (coeficientes[4]*comprimentos[4]*(pressoes[1]/50)^N1iner)*(24/1000)
  qiinevm3_dia_cavalete <- (coeficientes[1]*comprimentos[1]*(pressoes[2]/50)^N1iner)*(24/1000)
  qiinevm3_dia_ramal <- (coeficientes[2]*comprimentos[2]*(pressoes[4]/50)^N1iner)*(24/1000)
  
  perdas_inerentes_inevitaveis <- data.frame(qiinevm3_dia_cavalete, qiinevm3_dia_ramal , qiinevm3_dia_adutora,
                                              qiinevm3_dia_rede)
  rownames(perdas_inerentes_inevitaveis) <- c("vazao (m3/dia)")
  colnames(perdas_inerentes_inevitaveis) <- c("Cavalete", "Ramal",
                                              "Adutora", "Rede")
  
  return(perdas_inerentes_inevitaveis)
  

  
}