library(magrittr)

cutVector <- function(vec, m)
    list(n = length(vec) / m) %$%
        {lapply(0:(m - 1),
                function(x) vec[seq(n * x + 1, n * (x + 1))])}

dist0_bad <- function(m, n = 1e4){
    dat <- sample(0:9, size = n * m, replace = TRUE) %>%
        cutVector(m)

    lapply(dat, function(v) sapply(v, identical, y = 0)) %>%
        sapply(mean)
}

dist0 <- function(m, n = 1e4){
    dat <- sample(0:9, size = n * m, replace = TRUE) %>%
        cutVector(m) %>%
        lapply(as.numeric)

    lapply(dat, function(v) sapply(v, identical, y = 0)) %>%
        sapply(mean)
}

lmSlow <- function(m){
    res <- list()

    for (kk in 1:m){
        random_values <- rnorm(1e6)
        X <- matrix(random_values, ncol = 20)
        y <- rnorm(5e4)
        reg <- lm(y ~ X)
        b <- coef(r)
        res %<>% append(reg)
    }
    res
}

lmFast <- function(m){
    Xs <- rnorm(1e6 * m) %>%      ## Génération des données.
        cutVector(m) %>%          ## 1 entrée = 1 simulation.
        lapply(matrix, ncol = 20) ## vecteur -> matrice.

    ys <- rnorm(5e4 * m) %>%
        cutVector(m)

    mapply(function(X, y) lm(y ~ X) %>% coef, Xs, ys)
}
