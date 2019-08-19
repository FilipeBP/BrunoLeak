inter <- function (RL1, RLN, cp_rede, c_unit, CV, Nanos){
  
  #RL1 é o resultado de cálculo de volume de perdas reais no ano de interesse
  #RLN é um vetor com os valores de perdas reais anuais em N anos
  #c_unit é um valor dado pela ENOPS
  #CV é o custo variável da água e também é fornecido pela CASAL. É a composição dos valores de energia, 
  #outorga e agentes químicos por m3 de água produzida
  
  
  
  RRanual <- (RL1- (RLN))/Nanos #Esse é tipo um cálculo da taxa de crescimento dos vazamentos, para estimativas futuras
                                  #m3/ano
  
  RRpa <- RRanual/RL1 # Taxa percentual de perdas anuais
  
  RRdiario <- RRanual/365.25 #Taxa de crescimento por dia (m3/dia)
 
  RRpdiario <- RRpa/365.25
  
  CI <- c_unit*cp_rede #Custo da intervenção de pesquisa R$/ano
  
  EIF <- ceiling(sqrt((0.789*CI)/(CV*RRanual)))
  colnames(EIF) <- "meses" #Frequência de Intervenção  (meses)
  
  EP <- (100*12/EIF)*0.248 # Percentual do sistema que deve ser vistoriado anualmente (%)
  colnames(EP) <- "%"
 
  ABI <- EP*CI/100 #(R$)
  colnames(ABI) <- "R$"
  
  EURL <- ABI/CV # Economia não declarada (m3/ano)
  colnames(EURL) <- "m3/ano"
  
  nao_sei_nome <- data.frame( EIF,  EP, ABI, EURL)
  colnames(nao_sei_nome) <- c("EIF(meses)", "EP(%)", "ABI(R$)", "EURL(m3/ano)" )
  
  return(nao_sei_nome)
  
}