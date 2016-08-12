## 9.2 S4 클래스

## 9.2.1 S4 클래스 작성하기

setClass("employee",
         representation(
             name="character",
             salary="numeric",
             union="logical")
)

joe <- new("employee",name="Joe",salary=55000,union=T)
joe

joe@salary

slot(joe,"salary")

joe@salary <- 65000
joe

slot(joe,"salary") <- 88000
joe

joe@salry <- 48000


## 9.2.2 S4 클래스에서 제네릭 함수 구현하기

joe

show(joe)

setMethod("show", "employee",
          function(object) {
              inorout <- ifelse(object@union,"is","is not")
              cat(object@name,"has a salary of",object@salary,
                  "and",inorout, "in the union", "\n")
          }
)

joe
