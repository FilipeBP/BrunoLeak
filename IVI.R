IVI <- function(v_forn, v_fat, RL1, UARL){
  IPAP <- 100*((v_forn - v_fat - RL1)/12)/((v_forn - v_fat)/12)
  CARL <- (v_forn - v_fat) - (IPAP/100)*(v_forn - v_fat)
  UARL <- UARL #UARL é o total de perdas calculado pela equação
 
  
  IVI <- CARL/UARL
  
  return(IVI)
  
}