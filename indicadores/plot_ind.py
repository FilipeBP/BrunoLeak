#### Este código define função para plotagem com uso da biblioteca plotly

def plot_ind(entrada,saida):
    import plotly
    import plotly.graph_objs as go
    import random
    
    passo = 0
    trace = []
    
    for i in saida.columns:
            
        Trace = go.Scatter(
                         x= entrada.Tempo,
                         y= saida[saida.columns[passo]],
                         name = i,
                         line = dict(color = "#%06x" % random.randint(0, 0xFFFFFF)),
                         opacity = 0.8)
        
        trace.append(Trace)                     
        passo = passo + 1                     
    layout = dict(title = "Indicadores de Perdas")
    fig = dict(data=trace, layout=layout)
    plotly.offline.plot(fig, filename = "Indicadores_de_perdas")
   