###### Este script é para realizar plotagem com uso do plotly
import pandas as pd
df = pd.DataFrame({'Categoria':['A','B', 'C'], 'Valores':[32,43,50]})

import plotly
import plotly.graph_objs as go

plotly.offline.plot({
    "data": [go.Scatter(x=df['Categoria'], y=df['Valores'])],
    "layout": go.Layout(title="hello world")
}, auto_open=True)