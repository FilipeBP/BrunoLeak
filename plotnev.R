# define 3 data sets
xvolume_total_perda
y1 <- ycusto_total_perda
y2 <- custo_interv
y3 <- custo_total_tudo

# plot the first curve by calling plot() function
# First curve is plotted
plot(c(0:250000), YY, type="l", col="blue", pch="o", lty=1, xlim = c(0,350000),ylim=c(0,350000)) +
  abline(v = 306000, col= "purple", lty = 1, lwd = 2)

# Add second curve to the same plot by calling points() and lines()
# Use symbol '*' for points.
points(xvolume_total_perda, y2, col="red", pch="*")
lines(xvolume_total_perda, y2, col="red",lty=2)

# Add Third curve to the same plot by calling points() and lines()
# Use symbol '+' for points.
points(xvolume_total_perda, y3, col="dark red",pch="+")
lines(xvolume_total_perda, y3, col="dark red", lty=3) 