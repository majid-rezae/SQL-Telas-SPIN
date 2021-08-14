DECLARE @AEG varchar (255)
SET @AEG = '{COMBOAEG}'
DECLARE @CheckAEG varchar(255)
SET @CheckAEG = '{checkAEG}'
IF @CheckAEG = 'TRUE'
BEGIN
 select top (7)
  case when DAY([DATE])<10 then CONCAT('0',DAY([DATE]),'/', month([DATE]))
 when DAY([DATE])>=10 then CONCAT(DAY([DATE]),'/', month([DATE]))
     when month([DATE])<10 then CONCAT(DAY([DATE]),'/','0', month([DATE])) 
	  when month([DATE])>=10 then CONCAT(DAY([DATE]),'/','0', month([DATE]))  
       end, 
  round([PREDICTION],2) as [PREDICTION]  
 
  FROM [ActionETL].[dbo].[DT_FORECAST_VELOCIDADE]
   WHERE [SystemNumber]=@AEG
 order by [DATE] desc
END

DECLARE @CGE varchar(255)
SET @CGE = '{COMBOCGE}'
DECLARE @CheckCGE varchar(255)
SET @CheckCGE = '{checkCGE}'
IF @CheckCGE= 'TRUE'
BEGIN
 
	IF @CGE  IN ('COR','INH', 'TEI', 'ANG',  'BW1','COQ','TAM', 'CAI','BW2')
 begin
select  top (7)
	case when DAY([DATE])<10 then CONCAT('0',DAY([DATE]),'/', month([DATE]))
	when DAY([DATE])>=10 then CONCAT(DAY([DATE]),'/', month([DATE]))
	when month([DATE])<10 then CONCAT(DAY([DATE]),'/','0', month([DATE])) 
	when month([DATE])>=10 then CONCAT(DAY([DATE]),'/','0', month([DATE]))  
    end, 
round(avg([PREDICTION]),2) as [PREDICTION]  
FROM [ActionETL].[dbo].[DT_FORECAST_VELOCIDADE] as [V] 
   WHERE  [SystemNumber] in (SELECT [SystemNumber] FROM [ActionNet_BW].[dbo].[Base_Comum] WHERE ([Usina]=@CGE or [Parque]=@CGE) and Equipamento like 'AEG%'  ) 
  group by [date] 
  order by [date]  desc
end
END

 
 
BEGIN
 
	IF @CGE   IN ('TODOS')
 begin
select  top (7)
	case when DAY([DATE])<10 then CONCAT('0',DAY([DATE]),'/', month([DATE]))
	when DAY([DATE])>=10 then CONCAT(DAY([DATE]),'/', month([DATE]))
	when month([DATE])<10 then CONCAT(DAY([DATE]),'/','0', month([DATE])) 
	when month([DATE])>=10 then CONCAT(DAY([DATE]),'/','0', month([DATE]))  
    end, 
round(avg([PREDICTION]),2) as [PREDICTION]  

FROM [ActionETL].[dbo].[DT_FORECAST_VELOCIDADE] as [V] 
   WHERE  [SystemNumber] in (SELECT [SystemNumber] FROM [ActionNet_BW].[dbo].[Base_Comum] WHERE ([Usina]='BW1' or [Parque]='BW1' or [Usina]='BW2' or [Parque]='BW2') and Equipamento like 'AEG%'  ) 
  group by [date] 
  order by [date]  desc
end
END