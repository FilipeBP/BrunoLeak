#####C�lculo indicadores do modelo EconoLeak
#Esta planilha calcula os seguintes indicadores:(IPRAd, IPRTr,IPRPr,IPRDist,IPRTot,IOPFat, I.Lig.At.Min, IH, 
#IPVaz,IPDistR,IPVaz/hab,IPVazDistR,IPLD)


#Criando fun��es para c�lculo de indicadores

#IPRAd-Indicador de Perda Real na Adu��o

 
def IPRAd(VCAP,VAD):
    IPRAd=100*(VCAP-VAD)/VCAP
    print('IPRAd: {:.2f}% '.format(IPRAd))
    
#IPRTr -Indicador de Perda Real no tratamento
    
def IPRTr(VAD,VPRO):
    IPRTr=100*(VAD-VPRO)/VAD
    print('IPRTr: {:.2f}% '.format(IPRTr))
    
# IPRPr-Indicador de Perda Real at� a Produ��o

def IPRPr(VCAP,VPROD):
    IPRPr = 100*(VCAP-VPRO)/VCAP
    print('IPRPr: {:.2f}%'.format(IPRPr))
    
#IPRDist-Indicador de Perda Real na Distribui��o
##### �ndice de Perda na Distribui��o (IPD)
    
def IPD(VDIS,VU,QLAT):
    IPD=100*(VDIS-VU)/(VDIS*QLAT)
    print('IPD: {:.2f}%'.format(IPD))
    
#IPF - Indicador de Perda de Faturamento

def  IPF(VDIS,VFat):
    IPF=100*(VDIS-VFat)/VDIS
    print('IPF: {:.2f}%'.format(IPF))     
        
#I.Lig.At.Min - Indicador de liga��es ativas com volume estimado pelo m�nimo

def Ind_Lig_At_Min(QLACM,QLA):
    Ind_Lig_At_Min = QLACM/QLA
    print('Ind_Lig_At_Min: {:.2f}%'.format(Ind_Lig_At_Min))    

#IH - Indicador de Hidrometra��o ou Indicador de Micromedi��o
    
def IH(QLAM,QLA):
    IH = QLAM/QLA
    print('IH: {:.2f}'.format(IH))
        
#IPVaz - Indicador de Perdas de Vaz�o

def IPVaz(VDIS,VU,t):
    IPVaz = (VDIS-VU)/t
    print('IPVaz: {:.2f}'.format(IPVaz))

#IPDistRede - Indicador de Perdas Distribu�das na Rede
    
def IPDistrRede(VDIS,VU,comprimento_rede):
    IPDistRede = (VDIS-VU)/comprimento_rede
    print('IP_Distr_Rede: {:.2f}'.format(IPDistRede))
    
#IPVaz/hab - Indicador de Perdas de Vaz�o por habitante

def IPVaz_por_hab(VDIS,VU,t,hab):
    IPVaz_por_hab = VDIS-VU/t*hab
    print('IPVaz/hab: {:.2f}'.format(IPVaz_por_hab))
    
 
#ILBP - Indicador de Perdas de Vaz�o Distribu�das na Rede
#ou Indicador Linear Bruto de Perdas

def ILBP(VDIS,VU,t_func_red,comprimento_rede,comprimento_total_ramais):
    EPRede = comprimento_rede - comprimento_total_ramais 
    ILBP = (VDIS-VU)/t_func_red*EPRede     
    print('ILBP: {:.2f}'.format(ILBP))

#IPL - Indicador de Perdas por Liga��o 

def IPL(VDIS,VU,QLA,dias):    
    IPL = VDIS-VU/QLA*dias
    print('IPL: {:.2f}'.format(IPL))

#IPAG - Indicador de perdas totais de �gua

def IPAG(VDIS,VTEX,VCON,VOPE,VREC,VESP):
    VCNF=VOPE+VREC+VESP
    VCAU=VTEX+VCON+VCNF
    VPAG=VDIS-VCAU
    IPAG=VPAG/VDIS*100
    print('IPAG: {:.2f}'.format(IPAG))

#IPAG/L - Indicador de perdas totais de �gua por liga��o

def IPAG_por_L(VDIS,VTEX,VCON,VOPE,VREC,VESP,QLAT,QDIA):
    VCNF=VOPE+VREC+VESP
    VCAU=VTEX+VCON+VCNF
    IPAG_por_L = (VDIS - VCAU)/(QLAT*QDIA)
    print('IPAG/l: {:.2f}'.format(IPAG_por_L))
         
    
#IPRE/L - Indicador de perdas reais por liga��o 

def IPRE_por_L(QLAT,QDIA,VVAZ,VOEX):
    VPRE = VVAZ + VOEX
    IPRE_por_L = VPRE/(QLAT * QDIA)
    print('IPRE/l: {:.2f}'.format(IPRE_por_L))
    

#IMAC - Indicador da efici�ncia da macromedi��o
 
def IMAC(VPRO,VTIM,VDIS):
    IMAC = (VPRO + VTIM)*100/VDIS
    print('IMAC: {:.2f}'.format(IMAC))

#IHID - Indicador do n�vel de hidrometra��o

def IHID(QLAM,QLAT):
    IHID = QLAM*100/QLAT
    print('IHID: {:.2f}'.format(IHID))

#IMIC - Indicador da efici�ncia da micromedi��o 

def IMIC(VCONm,VCON):
    IMIC = (VCONm/VCON)*100
    print('IMIC: {:.2f}'.format(IMIC))
    
#ILIN - Indicador de n�vel da liga��o inativa

def  ILIN(QLIN,QLAT):
    ILIN = QLIN*100/(QLAT+QLIN)
    print('ILIN: {:.2f}'.format(ILIN))

#IOER - Indicador de oferta bruta de agua por economia residencial
    
def IOER(VDIS,QERE,QDIA):
    IOER = VDIS/(QERE*QDIA)
    print('IOER: {:.2f}'.format(IOER))

#ICER - Indicador de consumo de agua por economia residencial 

def ICER(VCON,QERE,QDIA):
    ICER = VCON/(QERE*QDIA)
    print('ICER: {:.2f}'.format(ICER))

#IREP - Indicador da quantidade de reparos por extensao da rede total

def IREP(QREP,QETR,QDIA):
    IREP = QREP/(QETR*QDIA)
    print('IREP: {:.2f}'.format(IREP))

#IRHI - Indicador da inefici�ncia no uso dos recursos hidricos

def IRHI(VPRE,VCAP,VTIM):
    IRHI = VPRE*100/(VCAP+VTIM)
    print('IRHI: {:.2f}'.format(IRHI))








    

       







    




     




    
