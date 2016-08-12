# 3.8 고차원 배열

firsttest <- matrix(c(46,21,50,30,25,48),3)
firsttest

secondtest <- matrix(c(46,41,50,43,35,50),3)
secondtest

tests <- array(data=c(firsttest,secondtest),dim=c(3,2,2))
attributes(tests)

tests[3,2,1]
tests
