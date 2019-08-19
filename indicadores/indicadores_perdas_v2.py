#####C�lculo indicadores do modelo EconoLeak
#Esta planilha calcula os seguintes indicadores:(IPRAd, IPRTr,IPRPr,IPRDist,IPRTot,IOPFat, I.Lig.At.Min, IH, 
#IPVaz,IPDistR,IPVaz/hab,IPVazDistR,IPLD)


#Criando fun��es para c�lculo de indicadores

#IPRAd-Indicador de Perda Real na Adu��o
 
def IPRAd(VCAP,VAD):
    IPRAd=100*(VCAP-VAD)/VCAP 
    return IPRAd
#IPRTr -Indicador de Perda Real no tratamento
    
def IPRTr(VAD,VPRO):
    IPRTr=100*(VAD-VPRO)/VAD
    return IPRTr

# IPRPr-Indicador de Perda Real at� a Produ��o

def IPRPr(VCAP,VPRO):
    IPRPr = 100*(VCAP-VPRO)/VCAP
    return IPRPr

# IPD - �ndice de Perda na Distribui��o 
    
def IPD(VD,VU,QLA):
    IPD=100*(VD-VU)/(VD*QLA)
    return IPD 
#IPF - Indicador de Perda de Faturamento

def  IPF(VD,VFAT):
    IPF=100*(VD-VFAT)/VD
    return IPF    
#IH - Indicador de Hidrometra��o ou Indicador de Micromedi��o
##utiliza-se a m�dia aritim�tica dos valores do ano de refer�ncia e do ano anterior ao mesmo    
def IH(QLAM,QLA):
    IH = QLAM/QLA
    return(IH)
        
#IPVaz - Indicador de Perdas de Vaz�o
#O tempo(t) refere-se ao tempo em que o volume � perdido. 
## Se anual(8760h), se mensal(720h)    
def IPVaz(VD,VU):
    t=8760
    IPVaz = (VD-VU)/t
    return IPVaz

#IPD/comprimento_da_rede - Indicador de Perdas Distribu�das na Rede
    
def IPD_rede(VD,VU,comprimento_rede):
    IPD_rede = (VD-VU)/comprimento_rede
    return IPD_rede
#IPVaz/hab - Indicador de Perdas de Vaz�o por habitante
#O tempo(t) refere-se ao tempo em que o volume � perdido. 
## Se anual(8760h), se mensal(720h)  
def IPVaz_por_hab(VD,VU,hab):
    t=8760
    IPVaz_por_hab = VD-VU/t*hab
    return IPVaz_por_hab
 
#ILBP - Indicador de Perdas de Vaz�o Distribu�das na Rede
#ou Indicador Linear Bruto de Perdas

def ILBP(VD,VU,t_func_red,comprimento_rede,comprimento_ramais):
    EPRede = comprimento_rede - comprimento_ramais
    ILBP = (VD-VU)/t_func_red*EPRede     
    return ILBP
#IPL - Indicador de Perdas por Liga��o 

def IPL(VD,VU,QLA,QDIA):    
    IPL = VD-VU/QLA*QDIA
    return IPL
    
#IPRE/L - Indicador de perdas reais por liga��o 

def IPRE_por_L(QLAT,QDIA,VVAZ):
    IPRE_por_L = VVAZ/(QLAT * QDIA)
    return IPRE_por_L 

#IREP - Indicador da quantidade de reparos por extensao da rede total

def IREP(QREP,comprimento_rede,QDIA):
    IREP = QREP/(comprimento_rede*QDIA)
    return IREP
#IRHI - Indicador da inefici�ncia no uso dos recursos hidricos

def IRHI(VVAZ,VCAP):
    IRHI = VVAZ*100/VCAP
    return IRHI







    

       







    




     




    
