
SELECT

MAX(F.TableName) AS TableName,
/* no estoy seguro de este campo, necesito probar*/
MAX(MONTH(F.logdate)) AS logdate,
SUM(F.QryRespTime) AS QryRespTime,
SUM(F.SumCPU) AS SumCPU,
SUM(F.CPUSKW) AS CPUSKW,
SUM(F.IOSKW) AS IOSKW,
	 AS PJI, 
SUM(F.UII) AS UII,
SUM(F.rowct) AS rowct,
SUM(F.SumIO) AS SumIO

FROM

(

select

TRIM(TRAILING ';' FROM SUBSTR(QueryText,12,60))  AS TableName,

logdate, 

sum(
	EXTRACT (SECOND FROM   FirstRespTime) +  
	(EXTRACT (MINUTE FROM FirstRespTime) * 60 ) + 
	(EXTRACT (HOUR FROM  FirstRespTime) *60*60 ) + 
	( 86400 * (CAST ( FirstRespTime AS DATE) - CAST ( starttime AS DATE) ) ) -  
	(EXTRACT (SECOND FROM   starttime) +  
	(EXTRACT (MINUTE FROM   starttime) * 60 ) +  
	(EXTRACT (HOUR FROM   starttime) *60*60 ) )) 
AS QryRespTime , 


sum(a.AMPCPUTIME) AS SumCPU ,  

sum( 
	CASE   WHEN AMPCPUTime < 1 OR  (AMPCPUTime /  (HASHAMP()+1)) = 0 
	THEN 0 
	ELSE   
		MaxAMPCPUTime/(AMPCPUTime /  (HASHAMP()+1))
	END    
	(DEC(8,2))) AS CPUSKW, 
	
sum(
	CASE   WHEN AMPCPUTime < 1
	OR     (TotalIOCount /  (HASHAMP()+1)) =0 THEN 0
	ELSE   MaxAmpIO/(TotalIOCount /  (HASHAMP()+1))
	END    (DEC(8,2))) AS IOSKW, 
					
sum( 
	CASE   WHEN AMPCPUTime < 1 
	OR     TotalIOCount = 0 THEN 0 ELSE   (a.AMPCPUTime
	*1000)/a.TotalIOCount END    )  AS PJI, 
	
sum(
	CASE   WHEN AMPCPUTime < 1
	OR     AMPCPUTime = 0 THEN 0 ELSE
	a.TotalIOCount/(a.AMPCPUTime *1000)
	END    )  AS UII,
					
sum(coalesce(utilityrowcount,0)) as rowct,

sum(a.TotalIOCount) AS SumIO

from   
	PDCRINFO.DBQLogTbl a

where  
	a.logdate >= '2011-01-01'
	and    a.logdate <= '2011-12-31'
	and    trim(a.statementType)='Execute Mload'
	and querytext like '%" + table + "%'
group  
	by 1,2

	
) AS T

GROUP BY MONTH(F.logdate)

