## 상호 링크 문제의 snow 버전

mtl <- function(ichunk,m) {
    n <- ncol(m)
    matches <- 0
    for (i in ichunk) {
        if (i < n) {
            rowi <- m[i,]
            matches <- matches +
                sum(m[(i+1):n,] %*% rowi)
        }
    }
    matches
}

mutlinks <- function(cls,m) {
    n <- nrow(m)
    nc <- length(cls)
    ## 어떤 일꾼이 i의 어떤 청크를 다룰지 결정함
    options(warn=-1)
    ichunks <- split(1:n,1:nc)
    options(warn=0)
    counts <- clusterApply(cls,ichunks,mtl,m)
    do.call(sum,counts) / (n*(n-1)/2)
}
