## 15.2 파이썬에서 R 사용하기

## 15.2.1 RPy 설치하기

sudo apt-get install python-rpy

from rpy import *

## 15.2.2 RPy 문법

>>> r.hist(r.rnorm(100))

>>> r.hist(r.rnorm(100),main='',xlab='')

>>> a = [5,12,13]
>>> b = [10,28,30]
>>> lmout = r.lm('v2 ~ v1',data=r.data_frame(v1=a,v2=b))
>>> lmout

>>> lmout['coefficients']

>>> r.library('lattice')
>>> r.assign('a',a)
>>> r.assign('b',b)
>>> r('g <- expand.grid(a,b)')
>>> r('wireframe(Var3 ~ Var1+Var2,g)')
>>> r('plot(wireframe(Var3 ~ Var1+Var2,g))')

