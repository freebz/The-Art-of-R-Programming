# 3.7 행렬의 행과 열에 이름 붙이기

z <- matrix(1:4,2)
z

colnames(z)
colnames(z) <- c("a","b")
z

colnames(z)
z[,"a"]

