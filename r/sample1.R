a <- 1
a
b<-2
b
c<-3
c
d<-3.5
d

rm(d)
#변수삭제

ls()
#등록된 모든 변수 출력

rm(list=ls())
#등록된 모든 변수 삭제

var <- c(1,2,5,7,8)
var2 <- c(1:5)
var3 <- var[2:4]
#슬라이싱 가능
var2[3]
#배열요소 출력 가능

var4 <- seq(1,10,by=2)

var5 <- 1:10

#기초 통계량 함수
mean(var5)
max(var5)
max(var5)

#install.packages("",dependencies=TRUE,type='source')
#library(패키지명) 패키지로딩
#require(패키지명) library()동일(예전버전의 함수)

x <- c("a","a","b","c")
qplot(x)
qplot(data=mpg,x=hwy)
qplot(data=mpg,x=hwy,y=displ)
qplot(data=mpg,x=drv,y=hwy,geom="boxplot")
qplot(data=mpg,x=drv,y=hwy,geom="boxplot",colour=drv)
mpg

