## 10장 입력과 출력

## 10.1 키보드와 모니터에 접근하기

## 10.1.1 scan() 함수 사용하기

scan("z1.txt")
scan("z2.txt")
scan("z3.txt")
scan("z3.txt",what="")
scan("z4.txt",what="")

v <- scan("z1.txt")

x1 <- scan("z3.txt",what="")
x2 <- scan("z3.txt",what="",sep="\n")
x1
x2
x1[2]
x2[2]

v <- scan("")
v


## 12.1.2 readline() 함수 사용하기

w <- readline()
w

inits <- readline("type your initials:  ")
inits


## 12.1.3 화면에 출력하기

x <- 1:3
print(x^2)

print("abc")
cat("abc\n")

x
cat(x,"abc","de\n")

cat(x,"abc","de\n",sep="")

cat(x,"abc","de\n",sep="\n")

x <- c(5,12,13,8,88)
cat(x,sep=c(".",".",".","\n","\n"))
