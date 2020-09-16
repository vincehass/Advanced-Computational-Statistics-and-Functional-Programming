marques <- c("toyota", "honda")
marques_alist <- pairlist(prius = "toyota")

isCar <- function(x) marques_alist[x] %in% marques
isHuman <- function(x) !isCar(x)

isCar("prius")

isCar("patrick")

isHuman("patrick")

library(magrittr)

autoCor1 <- function(v)
    v %>%
        scale %>%
        {t(.) %*% c(.[-1], .[1]) / (t(.) %*% .)}

set.seed(42)
autoCor1(runif(1e4))

v <- runif(1e4)

v %>% summary
summary(v)

v %>% quantile(seq(0, 1, 0.25))

cars %>% cbind(., .)

cars %>% {lm(speed ~ dist, data = .)}

mean(v)
sd(v)

v %<>% scale

mean(v)
sd(v)

cars %$% lm(speed ~ dist)
