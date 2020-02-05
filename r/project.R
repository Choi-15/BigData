library(ROracle)
oraDrv <- dbDriver('Oracle')
oraConn <- dbConnect(oraDrv, dbname='db202001291844_high', username='admin', password='Love1998!!@@')
query <- "
SELECT *
FROM(SELECT SE_NAME,
       AVG(TS_10_AMT) AMT10,
       AVG(TS_20_AMT) AMT20,
       AVG(TS_30_AMT) AMT30,
       AVG(TS_40_AMT) AMT40,
       AVG(TS_50_AMT) AMT50,
       AVG(TS_60UP_AMT) AMT60,
       (AVG(TS_10_AMT)+AVG(TS_20_AMT)+AVG(TS_30_AMT)+AVG(TS_40_AMT)+AVG(TS_50_AMT)+AVG(TS_60UP_AMT))/6 AMTAVG
       
FROM AGE_AMT_ANALYSIS T1, 
     ASTORE T2, 
     ASERVICE T3 
WHERE (T1.S_CODE = T2.S_CODE)
      and (T1.SE_CODE = T3.SE_CODE)
      
Group By SE_NAME
Order By AMTAVG DESC) a1
WHERE ROWNUM BETWEEN 1 AND 5"
result <- dbGetQuery(oraConn,query)
result
gg = ggplot(result, aes(SE_NAME,  # 데이터 및 x축 입력                    
                      AMT10, group = 1))+geom_line(color='red') # y축 및 그래프 종류 입력
                      
gg+geom_line(aes(SE_NAME,AMT20, group = 1),color='blue')

library(reshape2)
melt_data <- melt(result, id.vars = c("SE_NAME","AMTAVG"))
ggplot(data = melt_data, aes(x = SE_NAME, y = value, fill = variable)) +geom_col(size=1) + geom_point(size=3) +ggtitle("연령대별 서비스별 판매추이")


