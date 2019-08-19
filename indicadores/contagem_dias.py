# -*- coding: utf-8 -*-
"""
Created on Fri Dec 28 08:58:07 2018

@author: Birovsky
"""
#####Este código tem função de ler datas de um dataframe
## realizar a diferença entre as datas


### Criando uma datetime.data
import datetime
data_atual=datetime.date.today()
data1=datetime.date(1996,4,1)
data2=datetime.date(1996,4,10)


### Para imprimir no formato desejado, converte-se para string
##e formata conforme desejado
data_texto = datetime.date.strftime(data_atual,'%d/%m/%Y')
print(data_texto)
type(data_texto)

###Para converter de string para data 
from datetime import datetime
data_em_texto = '01/03/2018'
data = datetime.strptime(data_em_texto, '%d/%m/%Y')
type(data)
print(data)

import pandas as pd
plan=pd.read_csv('calcada_01_2017.csv', sep  = ';')
s=plan['Dt. Solic.']

for i in s:
    s[i] = datetime.strptime(s[i], '%d/%m/%Y')
    print(s)
t=plan['Dt. Encerr']