INDI <- function (v_forn, v_fat, VPR, nlig, cp_rede, cp_adut){
  
  #v_forn é o volune fornecido pra região
  #v_fat é o volume faturado pela companhia
  #VPR é o volume de perdas reais por dia
  
  VPA = v_forn - VPR[4] - v_fat
  IPR = 100*VPR[4]/v_forn
  IPRP = 100*(VPR[4]/(VPR[4] + VPA))
  IPA = 100*VPA/v_forn
  IPL = (VPR[3]*31)/(nlig*31)
  IPe = (VPR[3]*31)/((cp_rede + cp_adut)*31)
  
  indicadores <-  data.frame(VPA,IPR, IPRP, IPA, IPL,IPe)
  colnames(indicadores) <- c("VPA (m3/ano)", "IPR (%)", "IPRP (%)", "IPA (%)", "IPL (m3/dia.ligacao)", "IPe (m3/dia.km)")
  return (indicadores)
}