vaz_iner <- function (Hrede, Hadut, volume_reserv,cp_rede, cp_adut, nlig, N1, FCI,x){
  # Valores de vazão corrigidas para alturas de 7m (rede) e 20m (adutora)
  

  x = x
  FCI = FCI
  
  vazamento_iner_rede<- (20*24/1000)*cp_rede*(Hrede/50)^N1 #A correção estava ocorrendo duas vezes para a mesma variável, o mesmo ocorre nas variáveis que tiverem o asterisco.
  
  vazamento_iner_adutora <- (20*24/1000)*cp_adut*(Hadut/50)^N1 #*

  vazamento_iner_ramal <- (1.25*24/1000)*nlig*(Hrede/50)^N1 #*
  
  vazamento_iner_cavalete <- (1.25*24/1000)*nlig*(Hrede/50)^N1 #* 
    
  vazamento_iner_reservacao <- x*volume_reserv/100000
  
  #m3/dia
  #qiner_m3_dia_total <- ((20*24/1000)*(cp_rede)*(Hrede/50)^N1 + (1.25*24/1000)*nlig*(Hrede/50)^N1) + vazamento_iner_reservacao
  
  qiner_m3_dia_total <- sum(vazamento_iner_rede,vazamento_iner_adutora, vazamento_iner_ramal,vazamento_iner_cavalete,  vazamento_iner_reservacao)
  qiner_m3_ano_total <- qiner_m3_dia_total*365.25
  qiner_m3_hora_total <- qiner_m3_dia_total/24
  qiner_L_segundo_total <- (qiner_m3_dia_total/1000)/(24*3600)
  
  vazamento_iner_total <- data.frame(qiner_L_segundo_total,qiner_m3_hora_total,qiner_m3_dia_total, qiner_m3_ano_total)
  colnames(vazamento_iner_total) <-c("l/segundo","m3/hora", "m3/dia", "m3/ano")
  vazamento_iner_total <- vazamento_iner_total*FCI
  
  qiner_m3_dia_sistemas <- data.frame(vazamento_iner_rede,vazamento_iner_adutora, vazamento_iner_ramal,vazamento_iner_cavalete,  vazamento_iner_reservacao) # *FCI
  qiner_m3_dia_sistemas <- qiner_m3_dia_sistemas*FCI
  
  colnames(qiner_m3_dia_sistemas) <- c("Rede", "Adutora","Ramal", "Cavalete", "Reservacao")
  
  
  vazamento_iner <- list(vazamento_iner_total, as.data.frame(qiner_m3_dia_sistemas))
  
  return(vazamento_iner)
  
}