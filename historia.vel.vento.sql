set dateformat ymd 
declare @datestart date
declare @dateend date
DECLARE @AEG varchar(255)
 
SET @AEG = '{COMBOAEG2}'  		 
SET @datestart = (SELECT CONVERT(DATE , '{CALENDARIO134}', 103))
SET @Dateend = (SELECT CONVERT(DATE , '{CALENDARIO136}', 103)) 

DECLARE @CheckAEG varchar(255)
SET @CheckAEG = '{check2}'
IF @CheckAEG = 'TRUE'
BEGIN
if @AEG between '18132180' and  '18132211' or  @AEG between '18132256' and  '18132271'
 begin
 SELECT    
CONVERT(DATE,TimeStampLocalSystem) as [DATE]  ,
 round(avg([Prediction]),2) as [Predição],
 round(avg([Minute10Average]),2)  as [Real]
   
FROM  [SCADACustomerHistorical].[dbo].[BAPINANGICSMS01] as [T] 
   	left JOIN (select   Prediction,[date] from [ActionETL].[dbo].[DT_FORECAST_VELOCIDADE] WHERE  [SystemNumber] =  @AEG )as [V]  
		ON	 CONVERT(DATE, [TimeStampLocalSystem])  =   v.[DATE]
 WHERE  [SystemNumber] =  @AEG and
       [Name] = 'Wind Speed' and  CONVERT(DATE,TimeStampLocalSystem) between   @datestart and  @dateend 
 
   GROUP BY  CONVERT(DATE,TimeStampLocalSystem)   
    ORDER BY CONVERT(DATE,[T].[TimeStampLocalSystem]) ASC
end
else
begin
  SELECT    
CONVERT(DATE,TimeStampLocalSystem) as [DATE], 
 round(avg([Prediction]),2) as [Predição],
 round(avg([Minute10Average]),2)  as [Real]  
	   FROM  [SCADACustomerHistorical].[dbo].[BAPINTEIUSMS01] as [T] 
   	left JOIN (select  Prediction,[date] from [ActionETL].[dbo].[DT_FORECAST_VELOCIDADE]  WHERE  [SystemNumber] =  @AEG)as [V]  
		ON	 CONVERT(DATE, [TimeStampLocalSystem])  =   v.[DATE]
 WHERE  [SystemNumber] =  @AEG and
       [Name] = 'Wind Speed' and  CONVERT(DATE,TimeStampLocalSystem) between   @datestart and  @dateend 
 
   GROUP BY  CONVERT(DATE,TimeStampLocalSystem)   
    ORDER BY CONVERT(DATE,[T].[TimeStampLocalSystem]) 
	end
End
 


DECLARE @CGE varchar(255)
SET @CGE = '{COMBOCGE2}'
DECLARE @CheckCGE varchar(255)
SET @CheckCGE = '{checkCGE2}'
IF @CheckCGE= 'TRUE'
BEGIN
 
	IF @CGE  IN ('COR','INH', 'TEI', 'ANG',  'BW1' )
 begin
select  
     
CONVERT(DATE,TimeStampLocalSystem) as [DATE]  ,
 round(avg([Prediction]),2) as [Predição],
 round(avg([Minute10Average]),2)  as [Real]
   
  FROM  [SCADACustomerHistorical].[dbo].[BAPINANGICSMS01] as [T] 
   	left JOIN (select   Prediction,[date] from [ActionETL].[dbo].[DT_FORECAST_VELOCIDADE]    WHERE  [SystemNumber] in (SELECT [SystemNumber] FROM [ActionNet_BW].[dbo].[Base_Comum] WHERE ([Usina]=@CGE or [Parque]=@CGE) and Equipamento like 'AEG%'  )  )as [V] 
		ON	 CONVERT(DATE,[T].[TimeStampLocalSystem])  =  [v].[DATE] and t.Systemnumber= SystemNumber
 WHERE  [SystemNumber] in (SELECT [SystemNumber] FROM [ActionNet_BW].[dbo].[Base_Comum] WHERE ([Usina]=@CGE or [Parque]=@CGE) and Equipamento like 'AEG%'  ) and
   [Name] = 'Wind Speed' and  CONVERT(DATE,TimeStampLocalSystem) between   @datestart and  @dateend 
 
   GROUP BY  CONVERT(DATE,TimeStampLocalSystem)   
    ORDER BY CONVERT(DATE,[T].[TimeStampLocalSystem]) ASC
end
else if  @CGE  IN ('COQ','TAM', 'CAI','BW2')
begin
  SELECT    
CONVERT(DATE,TimeStampLocalSystem) as [DATE]  ,
 round(avg([Prediction]),2) as [Predição],
 round(avg([Minute10Average]),2)  as [Real]
   
  FROM  [SCADACustomerHistorical].[dbo].[BAPINTEIUSMS01] as [T] 
   	left JOIN (select   Prediction,[date] from [ActionETL].[dbo].[DT_FORECAST_VELOCIDADE]   WHERE  [SystemNumber] in (SELECT [SystemNumber] FROM [ActionNet_BW].[dbo].[Base_Comum] WHERE ([Usina]=@CGE or [Parque]=@CGE) and Equipamento like 'AEG%'  )   )as [V] 
		ON	 CONVERT(DATE,[T].[TimeStampLocalSystem])  =  [v].[DATE]
     WHERE  [SystemNumber] in (SELECT [SystemNumber] FROM [ActionNet_BW].[dbo].[Base_Comum] WHERE ([Usina]=@CGE or [Parque]=@CGE) and Equipamento like 'AEG%'  ) and
 
       [Name] = 'Wind Speed' and  CONVERT(DATE,TimeStampLocalSystem) between   @datestart and  @dateend 
 
   GROUP BY  CONVERT(DATE,TimeStampLocalSystem)   
    ORDER BY CONVERT(DATE,[T].[TimeStampLocalSystem]) 
	end
 
else
	IF @CGE  IN ('TODOS' )
 begin
 select  [DATE]  ,
 round(avg([Predição]),2) as [Predição],
 round(avg([Real]),2) as [Real]  
   
from(
select  
     
CONVERT(DATE,TimeStampLocalSystem) as [DATE],
 round( ([Prediction]),2) as [Predição],
 round( ([Minute10Average]),2)  as [Real]  
   
  FROM  [SCADACustomerHistorical].[dbo].[BAPINANGICSMS01] as [T] 
   	left JOIN (select   Prediction,[date] from [ActionETL].[dbo].[DT_FORECAST_VELOCIDADE] WHERE  [SystemNumber] in (SELECT [SystemNumber] FROM [ActionNet_BW].[dbo].[Base_Comum] WHERE ([Usina]='BW1' or [Parque]='BW1' or [Usina]='BW2' or [Parque]='BW2') and Equipamento like 'AEG%'  )  
  )as [V]  
		ON	 CONVERT(DATE,[T].[TimeStampLocalSystem])  =  [v].[DATE] and t.Systemnumber= SystemNumber
 WHERE  [SystemNumber] in (SELECT [SystemNumber] FROM [ActionNet_BW].[dbo].[Base_Comum] WHERE ([Usina]='BW1' or [Parque]='BW1') and Equipamento like 'AEG%'  ) and
   [Name] = 'Wind Speed'  and  CONVERT(DATE,TimeStampLocalSystem) between   @datestart and  @dateend 
   
    
 union all 
  SELECT    
CONVERT(DATE,TimeStampLocalSystem) as [DATE]  ,
 round( ([Prediction]),2) as [Predição] ,
 round( ([Minute10Average]),2)  as [Real]
   
  FROM  [SCADACustomerHistorical].[dbo].[BAPINTEIUSMS01] as [T] 
   	left JOIN (select   Prediction,[date] from [ActionETL].[dbo].[DT_FORECAST_VELOCIDADE]  WHERE  [SystemNumber] in (SELECT [SystemNumber] FROM [ActionNet_BW].[dbo].[Base_Comum] WHERE ([Usina]='BW1' or [Parque]='BW1' or [Usina]='BW2' or [Parque]='BW2') and Equipamento like 'AEG%'  ) 
 )as [V] 
		ON	 CONVERT(DATE,[T].[TimeStampLocalSystem])  =  [v].[DATE]
     WHERE   [SystemNumber] in (SELECT [SystemNumber] FROM [ActionNet_BW].[dbo].[Base_Comum] WHERE ([Usina]='BW2' or [Parque]='BW2') and Equipamento like 'AEG%' )  and
 
       [Name] = 'Wind Speed'   and  CONVERT(DATE,TimeStampLocalSystem) between   @datestart and  @dateend 
  )a
   group by [DATE]
   ORDER BY [DATE] ASC
end
end