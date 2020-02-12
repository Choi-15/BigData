# ROracle 라이브러리 로딩(임포트)
library(ROracle)
# ggplot2()
library(ggplot2)
library(gganimate)
# dbDriver(): OraDriver 또는 ExtDriver 클래스가 확장되는 객체 DBI Driver. DBI(데이터베이스 인터페이스)
# 특정 DBMS와 통신하는 기능에서 S Language Evaluator에서 자동으로 호출하는 "장치 드라이버"에 의해 제공
oraDrv <- dbDriver('Oracle')

# dbConnect(클래스 OraDriver, dbname, username, password)
oraConn <- dbConnect(oraDrv, dbname='db202001291844_high', username='admin', password='Love1998!!@@')

# query 변수에 쿼리문 저장
query <- "
SELECT *
FROM (SELECT s.S_TYPE, s.S_LOCATION, TS_QUARTER, avg(TS_MONTH_AMT) TS_MONTH_AMT, avg(TS_MONTH_NUM) TS_MONTH_NUM, sum(TS_MONTH_AMT) TS_MONTH_AMT_SUM
      FROM TOTALSELL t INNER JOIN ASTORE s
            ON t.S_CODE = s.S_CODE
            INNER JOIN ASERVICE sv
            ON t.SE_CODE = sv.SE_CODE
      WHERE s.S_TYPE = :1 OR
            s.S_TYPE = :2 OR
            s.S_TYPE = :3 OR
            s.S_TYPE = :4
      GROUP BY s.S_TYPE, s.S_LOCATION, TS_QUARTER
      )
ORDER BY S_LOCATION ASC
"

library(stringi)
library(stringr)
strlist <- list(str_conv('발달상권', 'KSC5601'), str_conv('관광특구', 'KSC5601'), str_conv('전통시장', 'KSC5601'), str_conv('골목상권', 'KSC5601'))

# dbGetQuery: 쿼리 문을 실행하고 DB에서 결과 데이터를 가져오는 함수
# dbGetQuery(OraConnection 객체, statement SQL문들어있는 문자형벡터)
result <- dbGetQuery(oraConn, query, strlist)


result





# Make a ggplot, but add frame=year: one image per ye


ggplot(result, aes(TS_MONTH_AMT, TS_MONTH_NUM, size = TS_MONTH_AMT_SUM, colour=S_LOCATION)) +
  geom_point(alpha = 0.7, show.legend = FALSE) +
  scale_fill_brewer(palette="Greens") +
  scale_size(range = c(2, 12)) +
  scale_x_log10() +
  facet_wrap(~S_TYPE) +
  # Here comes the gganimate specific bits
  labs(title = 'Quarter: {frame_time}', x = 'Num by Quarter', y = 'Amount by Quarter') +
  transition_time(TS_QUARTER) +
  ease_aes('linear')

# Save at gif:
anim_save("Amount by num ggplot2 - 1.gif")