library(magrittr)

lmSlow <- function(m){
    res <- matrix(nrow = m, ncol = 21)

    for (kk in 1:m){
        random_values <- rnorm(1e6)
        X <- matrix(random_values, ncol = 20)
        y <- rnorm(5e4)
        reg <- lm(y ~ X)
        res[kk,] <- coef(reg)
    }

    res
}

library(doParallel)
registerDoParallel(cores = detectCores())
lmPar <- function(m){
    foreach(kk = 1:m, .inorder = FALSE,
            .combine = rbind, .multicombine = TRUE) %dopar%{
        random_values <- rnorm(1e6)
        X <- matrix(random_values, ncol = 20)
        y <- rnorm(5e4)
        reg <- lm(y ~ X)
        coef(reg)
    }
}



