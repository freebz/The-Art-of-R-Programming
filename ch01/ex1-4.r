# 스칼라
x <- 8
x



# 문자열
x <- c(5,12,13)
x
length(x)
mode(x)

y <- "abc"
y
length(y)
mode(y)

z <- c("abc","29 88")
length(z)
mode(z)



# 문자열 함수
u <- paste("abc","de","f")  # 문자열을 결합함
u
v <- strsplit(u," ")  # 문자열을 공백 기준으로 나눔



# 행렬
m <- rbind(c(1,4),c(2,2))
m
m[1,2]
m[2,2]

m[1,]
m[,2]



# 리스트
x <- list(u=2, v="abc")
x
x$u

hn <- hist(Nile)
print(hn)
str(hn)



# 데이터 프레임
d <- data.frame(list(kids=c("Jack","Jill"),ages=c(12,10)))
d
d$ages




# 클래스
