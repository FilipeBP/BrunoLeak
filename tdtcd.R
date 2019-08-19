tdtcd<- function(x) {
  #Função para calcular a quantidade de dia(s) em que o vazamento permanece aberto. 
  
  y <- x %>% select("Dt. Solic.","Dt. Encer.") 
  m<- as.Date(x$`Dt. Solic.`)
  n <- as.Date(x$`Dt. Encer.`)
  z <- data.frame(m,n)
  colnames(z) <- c("abertura", "fechamento") 
  
  
  
  
  z$dias <-  if_else(z$abertura == z$fechamento, 1, as.numeric(abs(z$fechamento-z$abertura))+1)
  
  
  return(z)
  
  }



