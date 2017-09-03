
# 1a) Make a function, f(x, n, p) that uses the Binomial 
# distribution to calculate the probability.

# The function choose(n,r),  calculates nCr(n choose r)

# Time to create the function. I will call it f.

f <- function(x, n, p) {
  output <- choose(n,x)*p^x*(1-p)^(n-x)
  output
}

# 1b) Plot the discrete probability distribution for f(x;12, .5)
# and f(x; 48, .5)

# I will create a function called binom_plot to find the distributions

binom_plot <- function(n, p) {
  Domain <- 0: n
  x <- dbinom(Domain, size = n, prob = p )
  barplot(x, xlim = c(0,n), ylim = c(0, max(x)), names.arg = Domain, xlab = "Sample Space", ylab = "Binomial Probability", axes = TRUE)
}

binom_plot(12,.5)
binom_plot(48,.5)

# 1c) Create a normal distribution plot to overlap the binomial plot
# First I will create a function that plots the normal 
# distribution for the corresponding values. 
# I will call it norm_plot

norm_plot <- function(Mean, SD) {
  x <- seq(-4,4,length = 1000)*SD + Mean
  y <- dnorm(x, Mean, SD)
  plot(x, y, type = "l")
  
}


norm_plot2 <- function(Mean, SD) {
  x <- seq(-4,4,length = 1000)*SD + Mean
  g <- c(-4*SD + Mean, 4*SD + Mean)
  y <- dnorm(x, Mean, SD)
  plot(x, y, type = "l", axes = FALSE, xlim = g, xlab = "", ylab = "")
  
}
# I will create a function that first plots the binomial 
# distribution, then superimposes the corresponding normal curve on top of it

super_plot <- function(n,p) {
  Mean = n*p
  x <- seq(0,n, length = 1000)
  SD = sqrt(n*p*(1-p))
  y <- dnorm(x, Mean, SD)
  binom_plot(n,p)
  lines(x, y)
  #par(new=TRUE)
  #plot(x, y, axes= FALSE, type = "l", xlab = "", ylab = "" )
}
super_plot(12,.5)
super_plot(48,.5)
