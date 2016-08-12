x <- 1:10
y <- ifelse(x %%2 == 0,5,12) # %% is the mod operator
y


x <- c(5,2,9,12)
ifelse(x > 6,2*x,3*x)


# 2.9.1 확장 예제: 연관성 측정

# findud()는 v를 1과 -1로 바꾼다.
# 앞의 값에 대해 증가하는 경우 1
# 그렇지 않은 경우 -1
findud <- function(v) {
    vud <- v[-1] - v[-length(v)]
    return(ifelse(vud > 0,1,-1))
}

udcorr <- function(x,y) {
    ud <- lapply(list(x,y),findud)
    return(mean(ud[[1]] == ud[[2]]))
}

x <- c(5,12,13,3,6,0,1,15,16,8,88)
y <- c(4,2,3,23,6,10,11,12,6,3,2)
udcorr(x,y)


u <- c(1,6,7,2,3,5)
diff(u)
sign(diff(u))


udcorr <- function(x,y) mean(sign(diff(x)) == sign(diff(y)))


# 2.9.2 확장 예제: Abalone 데이터 세트 기록하기

g <- c("M","F","F","I","M","M","F")
ifelse(g == "M",1,ifelse(g == "F",2,3))

args(ifelse)

ab <- cbind(g,g)
ab[,1] <- ifelse(ab[,1] == "M",1,ifelse(ab[,1] == "F",2,3))

m <- which(g == "M")
f <- which(g == "F")
i <- which(g == "I")
m
f
i


grps <- list()
for (gen in c("M","F","I")) grps[[gen]] <- which(g==gen)
grps


aba <- read.csv("abalone.data",header=T,as.is=T)
grps <- list()
for (gen in c("M","F")) grps[[gen]] <- which(aba==gen)
abam <- aba[grps$M,]
abaf <- aba[grps$F,]
plot(abam$Length,abam$Diameter)
plot(abaf$Length,abaf$Diameter,pch="x",new=FALSE)



pchvec <- ifelse(aba$Gender == "M","o","x")
plot(aba$Length,aba$Diameter,pch=pchvec)
