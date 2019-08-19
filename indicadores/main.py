## Importando o pandas
import pandas as pd

###lendo uma planilha formato excel
entrada = pd.read_excel('Entrada.xlsx',sheet_name='Sheet1')

### selecionando coluna
entrada['Tempo']
## Selecionando linha
entrada.loc[0]
## Selecionando um subconjunto
entrada.loc[0,'Tempo']
entrada.loc[[0,4],['Tempo','VCAP(m3)']]
# Coletando quantidade de linhas
entrada.shape


###Importando o script de indicadores
import indicadores_perdas_v2 as ind

## Crio lista para intervalo do for
lista = [0, 1, 3, 4, 5, 6, 7, 8, 9] 

#####CRIAÇÃO DE DATAFRAMES COM INDICADORES CALCULADOS#######


#IPRAd
lista_aux=[]  
for i  in lista:
    
    x=entrada.loc[i,'VCAP(m3)'] 
    y=entrada.loc[i,'VAD(m3)'] 
    lista_aux.append(ind.IPRAd(x,y))
IPRAd = pd.DataFrame(lista_aux, columns=['IPRAd'])

#IPRTr
lista_aux=[]  
for i  in lista:
    
    x=entrada.loc[i,'VAD(m3)'] 
    y=entrada.loc[i,'VPRO(m3)'] 
    lista_aux.append(ind.IPRTr(x,y))
IPRTr = pd.DataFrame(lista_aux, columns=['IPRTr'])

#IPRPr
lista_aux=[]  
for i  in lista:
    
    x=entrada.loc[i,'VCAP(m3)'] 
    y=entrada.loc[i,'VPRO(m3)'] 
    lista_aux.append(ind.IPRPr(x,y))
IPRPr = pd.DataFrame(lista_aux, columns=['IPRPr'])

#IPD 
lista_aux=[]  
for i  in lista:
    
    x=entrada.loc[i,'VD(m3)'] 
    y=entrada.loc[i,'VU(m3)']
    z=entrada.loc[i,'QLA']
    lista_aux.append(ind.IPD(x,y,z))
IPD = pd.DataFrame(lista_aux, columns=['IPD'])

#IPF
lista_aux=[]  
for i  in lista:
    
    x=entrada.loc[i,'VD(m3)'] 
    y=entrada.loc[i,'VFAT(m3)']
    lista_aux.append(ind.IPF(x,y))
IPF = pd.DataFrame(lista_aux, columns=['IPF'])

#IH
lista_aux=[]  
for i  in lista:
    
    x=entrada.loc[i,'QLAM'] 
    y=entrada.loc[i,'QLA']
    lista_aux.append(ind.IH(x,y))
IH = pd.DataFrame(lista_aux, columns=['IH'])

#IPVaz
lista_aux=[]  
for i  in lista:
    
    x=entrada.loc[i,'VD(m3)'] 
    y=entrada.loc[i,'VU(m3)']
    lista_aux.append(ind.IPVaz(x,y))
IPVaz = pd.DataFrame(lista_aux, columns=['IPVaz'])

#IPD/comprimento_da_rede
lista_aux=[]  
for i  in lista:
    
    x=entrada.loc[i,'VD(m3)'] 
    y=entrada.loc[i,'VU(m3)']
    z=entrada.loc[i,'comprimento_rede(km)']
    lista_aux.append(ind.IPD_rede(x,y,z))
IPD_red = pd.DataFrame(lista_aux, columns=['IPD_rede'])

#IPVaz/hab
lista_aux=[]  
for i  in lista:
    
    x=entrada.loc[i,'VD(m3)'] 
    y=entrada.loc[i,'VU(m3)']
    z=entrada.loc[i,'hab']
    lista_aux.append(ind.IPVaz_por_hab(x,y,z))
IPVaz_por_hab = pd.DataFrame(lista_aux, columns=['IPVaz_por_hab'])

#ILBP
lista_aux=[]  
for i  in lista:
    
    x=entrada.loc[i,'VD(m3)'] 
    y=entrada.loc[i,'VU(m3)']
    t=entrada.loc[i,'t_func_red']
    a=entrada.loc[i,'comprimento_rede(km)']
    b=entrada.loc[i,'comprimento_ramais(km)']
    lista_aux.append(ind.ILBP(x,y,t,a,b))
ILBP = pd.DataFrame(lista_aux, columns=['ILBP'])

#IPL
lista_aux=[]  
for i  in lista:
    
    x=entrada.loc[i,'VD(m3)'] 
    y=entrada.loc[i,'VU(m3)']
    z=entrada.loc[i,'QLA']
    a=entrada.loc[i,'QDIA']
    lista_aux.append(ind.IPL(x,y,z,a))
IPL = pd.DataFrame(lista_aux, columns=['IPL'])

#IPRE/L
lista_aux=[]  
for i  in lista:
    
    x=entrada.loc[i,'QLA'] 
    y=entrada.loc[i,'QDIA']
    z=entrada.loc[i,'VVAZ(m3)']
    lista_aux.append(ind.IPRE_por_L(x,y,z))
IPRE_por_L = pd.DataFrame(lista_aux, columns=['IPRE_por_L'])

#IREP
lista_aux=[]  
for i  in lista:
    
    x=entrada.loc[i,'QREP'] 
    y=entrada.loc[i,'comprimento_rede(km)']
    z=entrada.loc[i,'QDIA']
    lista_aux.append(ind.IREP(x,y,z))
IREP= pd.DataFrame(lista_aux, columns=['IREP'])

#IRHI
lista_aux=[] 
for i  in lista:
    
    x=entrada.loc[i,'VVAZ(m3)'] 
    y=entrada.loc[i,'VCAP(m3)']
    lista_aux.append(ind.IRHI(x,y))
IRHI= pd.DataFrame(lista_aux, columns=['IRHI'])

frame = [IPRAd, IPRTr, IPRPr, IPD, IPF, IH,IPVaz, IPD_red, IPVaz_por_hab, ILBP, IPL, IPRE_por_L,
         IREP, IRHI]

saida = pd.concat(frame, axis=1, join='outer', join_axes=None, 
                               ignore_index=False, keys=None, levels=None, names=None, 
                               verify_integrity=False, sort=False)


######Realizando a plotagem dos dados 
import plot_ind
plot_ind.plot_ind(entrada,saida)


