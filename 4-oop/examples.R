p1 <- c(1, 2)
class(p1) <- c("point", "numeric")

p2 <- structure(c(3, 4), class = c("point", "numeric"))

point <- function(v){
    identical(length(v), as.integer(2)) ||
        stop("v doit être de longueur 2")
    is.numeric(v) ||
        stop("v doit être numeric")

    structure(as.numeric(v), class = c("point", "numeric"))
}

print.point <- function(x) cat("x =", x[1], "& y =", x[2], "\n")

summary.point <- function(object){
    cat("Point de coordonnées ")
    print(object)
}

isAligned <- function(...) UseMethod("isAligned")

isAligned.point <- function(...){
    points <- list(...)
    isTRUE(length(points) <= 2) && return(TRUE)

    fit <- crossprod(
        solve(cbind(1, c(points[[1]][1], points[[2]][1]))),
        c(points[[1]][2], points[[2]][2]))

    for (p in points[-(1:2)]){
        pred <- crossprod(c(1, p[1]), fit)[1]

        isTRUE(all.equal(pred, p[2])) || return(FALSE)
    }

    TRUE
}

pointM <- function(v, mark = NULL){
    is.null(mark) ||
        (is.character(mark) &&
         identical(length(mark), as.integer(1))) ||
        stop("mark doit être une chaine caractères")

    p <- point(v)
    attr(p, "mark") <- mark

    structure(p, class = c("pointM", class(p)))
}

mark <- function(point) UseMethod("mark")

mark.pointM <- function(point) attr(point, "mark")

`mark<-` <- function(point, value) UseMethod("mark<-")

`mark<-.pointM` <- function(point, value){
    attr(point, "mark") <- value

    point
}

print.pointM <- function(x){
    print.point(x)
    cat(mark(x), "\n")
}
