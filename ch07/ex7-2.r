## 7.2 산술 및 불리언 연산과 값

x <- c(TRUE, FALSE, TRUE)
y <- c(TRUE, TRUE, FALSE)

x
y
x & y
x[1] && y[1]
if (x[1] && y[1]) print("both TRUE")
if (x & y) print("both TRUE")

1 < 2
(1 < 2) * (3 < 4)
(1 < 2) * (3 < 4) * (5 < 1)
(1 < 2) == TRUE
(1 < 2) == 1
