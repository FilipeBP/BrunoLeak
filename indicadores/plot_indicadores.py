#### Este script define uma função de plotagem com uso da biblioteca plotly
## Criei este código 
import plotly
import plotly.plotly as py
import plotly.graph_objs as go

import pandas as pd

df = pd.read_csv("https://raw.githubusercontent.com/plotly/datasets/master/finance-charts-apple.csv")

trace_high = go.Scatter(
                x=df.Date,
                y=df['AAPL.High'],
                name = "IPL",
                line = dict(color = '#17BECF'),
                opacity = 0.8)

trace_medium = go.Scatter(
                x=df.Date,
                y=df['AAPL.Low'],
                name = "IVI",
                line = dict(color = '#BC2525'),
                opacity = 0.8)


trace_low = go.Scatter(
                x=df.Date,
                y=df['AAPL.Low'],
                name = "IPA",
                line = dict(color = '#7F7F7F'),
                opacity = 1)

data = [trace_high,trace_medium, trace_low]

layout = dict(
    title = "Indicadores de Perdas",
   )

plotly.offline.plot(data, filename = "Indicadores_de_perdas")
