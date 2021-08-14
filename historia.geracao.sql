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
		CONVERT(DATE,TimeStampLocalSystem) as [DATE],round((avg([Potencia])*24)/1000,2) as [Predição],
		round((avg([Minute10Average])*24)/1000,2)  as [Real]  
     FROM  [SCADACustomerHistorical].[dbo].[BAPINANGICSMS01] as [T] 
     left JOIN (SELECT TOP (7) T.[DATE], round(T.[PREDICTION],2) as [PREDICTION_TEMPERATURA],
	  round(P.[PREDICTION],2) as [PREDICTION_PRESSAO], round(V.[PREDICTION],2) as [PREDICTION_VELOCIDADE],
	    ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) as [Densidade],
CASE WHEN V.[PREDICTION] <= 3.05 THEN 0	   
WHEN V.[PREDICTION] >= 14.5 THEN 1850
WHEN V.[PREDICTION] > 3.05 and V.[PREDICTION] <=9 THEN 
	case when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.02 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.04 then  
	0.04582 * power(V.[PREDICTION] ,6) - 1.83445* power( V.[PREDICTION],5)  + 29.69465* power( V.[PREDICTION],4) - 247.26779* power(V.[PREDICTION] ,3)  + 1133.11081* power( V.[PREDICTION],2)  - 2651.7319* power(V.[PREDICTION] ,1)  + 2440.26614
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.04 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.06 then  
	0.04238* power(V.[PREDICTION] ,6)   - 1.71997* power(V.[PREDICTION] ,5)   + 28.13286* power(V.[PREDICTION] ,4)   - 236.00657* power(V.[PREDICTION] ,3)   + 1087.82802* power(V.[PREDICTION] ,2)   - 2553.99536* power(V.[PREDICTION] ,1)  + 2351.72213
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.06 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.08 then     
	0.03688 *power(V.[PREDICTION] ,6)  - 1.51700 *power(V.[PREDICTION] ,5)   + 25.10791* power(V.[PREDICTION] ,4)   - 212.72109 *power(V.[PREDICTION] ,3)  + 990.66068 *power(V.[PREDICTION] ,2)   - 2344.73747* power(V.[PREDICTION] ,1)   + 2169.49876
    when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.08 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.10 then  
	0.03935* power(V.[PREDICTION] ,6)  - 1.61219* power(V.[PREDICTION] ,5) + 26.55421* power(V.[PREDICTION] ,4)  - 223.78369* power(V.[PREDICTION] ,3) + 1035.67512* power(V.[PREDICTION] ,2)  - 2435.64408* power(V.[PREDICTION],1)  + 2239.96359
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.10 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.12 then  
	0.03495* power(V.[PREDICTION] ,6) - 1.44222* power(V.[PREDICTION] ,5)+ 23.88447* power(V.[PREDICTION] ,4) - 202.00436* power(V.[PREDICTION] ,3) + 938.96610* power(V.[PREDICTION] ,2) - 2213.45313* power(V.[PREDICTION] ,1) + 2033.83237
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.12 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.14 then  
	0.03041* power(V.[PREDICTION] ,6) - 1.29353* power(V.[PREDICTION] ,5) + 21.91920* power(V.[PREDICTION] ,4) - 188.56855* power(V.[PREDICTION] ,3) + 889.05442* power(V.[PREDICTION] ,2) - 2116.66540* power(V.[PREDICTION] ,1) + 1956.33114
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.14 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.16 then  
	0.02862* power(V.[PREDICTION] ,6) - 1.22039* power(V.[PREDICTION] ,5) + 20.68813* power(V.[PREDICTION] ,4) - 177.73029* power(V.[PREDICTION] ,3) + 837.20934* power(V.[PREDICTION] ,2) - 1988.69713* power(V.[PREDICTION] ,1) + 1829.61682
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.16 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.18 then  
	0.02298* power(V.[PREDICTION] ,6) - 1.02724* power(V.[PREDICTION] ,5) + 18.01168* power(V.[PREDICTION] ,4) - 158.56628* power(V.[PREDICTION] ,3) + 762.91353* power(V.[PREDICTION] ,2) - 1839.95011* power(V.[PREDICTION] ,1) + 1708.67585
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.18 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.20 then  
	0.02669* power(V.[PREDICTION] ,6)  - 1.15888* power(V.[PREDICTION] ,5)  + 19.86589* power(V.[PREDICTION] ,4)   - 171.71958* power(V.[PREDICTION] ,3)  + 812.19356* power(V.[PREDICTION] ,2)   - 1930.36544* power(V.[PREDICTION] ,1)  + 1770.58433
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.20 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.22 then  
	0.02064* power(V.[PREDICTION] ,6)   - 0.94092* power(V.[PREDICTION] ,5)  + 16.66635* power(V.[PREDICTION] ,4)   - 147.24010* power(V.[PREDICTION] ,3)   + 709.72720* power(V.[PREDICTION] ,2)  - 1707.03346* power(V.[PREDICTION] ,1)   + 1572.44364
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) = 1.22  then  
	0.01637* power(V.[PREDICTION] ,6)   - 0.78706* power(V.[PREDICTION] ,5)   + 14.41281* power(V.[PREDICTION] ,4)   - 130.10066* power(V.[PREDICTION] ,3)   + 638.75844* power(V.[PREDICTION] ,2)   - 1553.94099* power(V.[PREDICTION] ,1)  + 1437.37536
end
WHEN V.[PREDICTION] > 9 and V.[PREDICTION] < 14.5 THEN 
	case when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.02 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.04 then  
	0.152157* power(V.[PREDICTION] ,6) + 10.693756* power(V.[PREDICTION] ,5)  - 310.617647* power(V.[PREDICTION] ,4)  + 4771.726125* power(V.[PREDICTION] ,3)  - 40912.951432* power(V.[PREDICTION] ,2)  + 186099.229288* power(V.[PREDICTION] ,1)  - 351221.525372 
	 when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.04 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.06 then  
	-0.124967* power(V.[PREDICTION] ,6)  + 8.633544* power(V.[PREDICTION] ,5)  - 245.986174* power(V.[PREDICTION] ,4)  + 3697.682001* power(V.[PREDICTION] ,3)  - 30946.006109* power(V.[PREDICTION] ,2)  + 137148.070514* power(V.[PREDICTION] ,1)  - 251822.697487
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.06 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.08 then     
	-0.098301* power(V.[PREDICTION] ,6)  + 6.687903* power(V.[PREDICTION] ,5)  - 187.075917* power(V.[PREDICTION] ,4)  + 2750.820812* power(V.[PREDICTION] ,3)  - 22431.658413* power(V.[PREDICTION] ,2)  + 96563.546543* power(V.[PREDICTION] ,1)  - 171734.570134
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.08 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.10 then  
	-0.074248* power(V.[PREDICTION] ,6)  + 4.925370* power(V.[PREDICTION] ,5) - 133.438411* power(V.[PREDICTION] ,4)  + 1883.750758* power(V.[PREDICTION] ,3)  - 14585.209154* power(V.[PREDICTION] ,2)  + 58902.832622* power(V.[PREDICTION] ,1)  - 96855.540806
	 when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.10 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.12 then  
	-0.019869* power(V.[PREDICTION] ,6)   + 0.999819* power(V.[PREDICTION] ,5)   - 15.867773* power(V.[PREDICTION] ,4)   + 14.355984* power(V.[PREDICTION] ,3)   + 2052.010155* power(V.[PREDICTION] ,2)   - 19653.638989* power(V.[PREDICTION] ,1)  + 56872.128962 
	 when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.12 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.14 then  
	-0.025098* power(V.[PREDICTION] ,6)   + 1.376290* power(V.[PREDICTION] ,5)   - 27.079940* power(V.[PREDICTION] ,4)   + 191.645713* power(V.[PREDICTION] ,3)   + 477.191154* power(V.[PREDICTION] ,2)   - 12181.873102* power(V.[PREDICTION] ,1)   + 42070.863315
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.14 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.16 then  
	0.028235* power(V.[PREDICTION] ,6)  - 2.484223* power(V.[PREDICTION] ,5)  + 88.843137* power(V.[PREDICTION] ,4)   - 1655.984591* power(V.[PREDICTION] ,3)  + 16956.151119* power(V.[PREDICTION] ,2)   - 90136.991435* power(V.[PREDICTION] ,1)   + 194863.838242
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.16 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.18 then  
	0.104052* power(V.[PREDICTION] ,6)  - 7.999457* power(V.[PREDICTION] ,5)   + 255.240070* power(V.[PREDICTION] ,4)   - 4320.239868* power(V.[PREDICTION] ,3)   + 40825.260416* power(V.[PREDICTION] ,2)   - 203556.079333* power(V.[PREDICTION] ,1)   + 418155.285642
	 when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.18 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.20 then  
	0.127059* power(V.[PREDICTION] ,6)   - 9.645671* power(V.[PREDICTION] ,5)   + 304.050528* power(V.[PREDICTION] ,4)   - 5087.213279* power(V.[PREDICTION] ,3)   + 47555.503896* power(V.[PREDICTION] ,2)   - 234803.599422* power(V.[PREDICTION] ,1)   + 478109.843470
	 when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.20 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.22 then  
	0.132288* power(V.[PREDICTION] ,6)   - 10.011885* power(V.[PREDICTION] ,5)   + 314.647310* power(V.[PREDICTION] ,4)   - 5248.832844* power(V.[PREDICTION] ,3)   + 48920.546676* power(V.[PREDICTION] ,2)   - 240834.122688* power(V.[PREDICTION] ,1)   + 488975.158190
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) = 1.22  then  
	0.066047* power(V.[PREDICTION] ,6)   - 5.247376* power(V.[PREDICTION] ,5)   + 172.339049* power(V.[PREDICTION] ,4)   - 2988.955128* power(V.[PREDICTION] ,3)   + 28791.781162* power(V.[PREDICTION] ,2)  - 145473.363921* power(V.[PREDICTION] ,1)   + 301262.823738
end
 
end	as Potencia

  FROM [ActionETL].[dbo].[DT_FORECAST_TEMPERATURA] as [T]
  join  [ActionETL].[dbo].[DT_FORECAST_PRESSAO] as [P]  on T.[DATE] = P.[DATE] 
  join  [ActionETL].[dbo].[DT_FORECAST_VELOCIDADE] as [V]  on P.[DATE] = V.[DATE] 
  where T.[SystemNumber]=@AEG and V.[SystemNumber]=@AEG and P.[SystemNumber]=@AEG
 	
order by  T.[DATE] desc) as [V]  ON	 CONVERT(DATE,[T].[TimeStampLocalSystem])  =  [v].[DATE]

WHERE [SystemNumber] =    @AEG and  [Name] = 'power' and  CONVERT(DATE,TimeStampLocalSystem) between   @datestart and  @dateend 
 
	GROUP BY  CONVERT(DATE,TimeStampLocalSystem)   
	order by  CONVERT(DATE,TimeStampLocalSystem)  ASC
end
else
begin
  SELECT  
	  CONVERT(DATE,TimeStampLocalSystem) as [DATE],round((avg([Potencia])*24)/1000,2) as [Predição] ,
	  round((avg([Minute10Average])*24)/1000,2)  as [Real]  
  FROM  [SCADACustomerHistorical].[dbo].[BAPINTEIUSMS01] as [T] 
   	left JOIN (SELECT TOP (7) T.[DATE], round(T.[PREDICTION],2) as [PREDICTION_TEMPERATURA],
	  round(P.[PREDICTION],2) as [PREDICTION_PRESSAO], round(V.[PREDICTION],2) as [PREDICTION_VELOCIDADE],
	  ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) as [Densidade],
CASE WHEN V.[PREDICTION] <= 3.05 THEN 0	   
WHEN V.[PREDICTION] >= 14.5 THEN 1850
WHEN V.[PREDICTION] > 3.05 and V.[PREDICTION] <=9 THEN 
		case when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.02 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.04 then  
		 0.04582 * power(V.[PREDICTION] ,6) - 1.83445* power( V.[PREDICTION],5)  + 29.69465* power( V.[PREDICTION],4) - 247.26779* power(V.[PREDICTION] ,3)  + 1133.11081* power( V.[PREDICTION],2)  - 2651.7319* power(V.[PREDICTION] ,1)  + 2440.26614
		  when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.04 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.06 then  
		0.04238* power(V.[PREDICTION] ,6)   - 1.71997* power(V.[PREDICTION] ,5)   + 28.13286* power(V.[PREDICTION] ,4)   - 236.00657* power(V.[PREDICTION] ,3)   + 1087.82802* power(V.[PREDICTION] ,2)   - 2553.99536* power(V.[PREDICTION] ,1)  + 2351.72213
		when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.06 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.08 then     
		0.03688 *power(V.[PREDICTION] ,6)  - 1.51700 *power(V.[PREDICTION] ,5)   + 25.10791* power(V.[PREDICTION] ,4)   - 212.72109 *power(V.[PREDICTION] ,3)  + 990.66068 *power(V.[PREDICTION] ,2)   - 2344.73747* power(V.[PREDICTION] ,1)   + 2169.49876
		 when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.08 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.10 then  
		0.03935* power(V.[PREDICTION] ,6)  - 1.61219* power(V.[PREDICTION] ,5) + 26.55421* power(V.[PREDICTION] ,4)  - 223.78369* power(V.[PREDICTION] ,3) + 1035.67512* power(V.[PREDICTION] ,2)  - 2435.64408* power(V.[PREDICTION],1)  + 2239.96359
		 when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.10 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.12 then  
		0.03495* power(V.[PREDICTION] ,6) - 1.44222* power(V.[PREDICTION] ,5)+ 23.88447* power(V.[PREDICTION] ,4) - 202.00436* power(V.[PREDICTION] ,3) + 938.96610* power(V.[PREDICTION] ,2) - 2213.45313* power(V.[PREDICTION] ,1) + 2033.83237
		when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.12 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.14 then  
		0.03041* power(V.[PREDICTION] ,6) - 1.29353* power(V.[PREDICTION] ,5) + 21.91920* power(V.[PREDICTION] ,4) - 188.56855* power(V.[PREDICTION] ,3) + 889.05442* power(V.[PREDICTION] ,2) - 2116.66540* power(V.[PREDICTION] ,1) + 1956.33114
		when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.14 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.16 then  
		0.02862* power(V.[PREDICTION] ,6) - 1.22039* power(V.[PREDICTION] ,5) + 20.68813* power(V.[PREDICTION] ,4) - 177.73029* power(V.[PREDICTION] ,3) + 837.20934* power(V.[PREDICTION] ,2) - 1988.69713* power(V.[PREDICTION] ,1) + 1829.61682
		when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.16 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.18 then  
		0.02298* power(V.[PREDICTION] ,6) - 1.02724* power(V.[PREDICTION] ,5) + 18.01168* power(V.[PREDICTION] ,4) - 158.56628* power(V.[PREDICTION] ,3) + 762.91353* power(V.[PREDICTION] ,2) - 1839.95011* power(V.[PREDICTION] ,1) + 1708.67585
		 when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.18 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.20 then  
		0.02669* power(V.[PREDICTION] ,6)  - 1.15888* power(V.[PREDICTION] ,5)  + 19.86589* power(V.[PREDICTION] ,4)   - 171.71958* power(V.[PREDICTION] ,3)  + 812.19356* power(V.[PREDICTION] ,2)   - 1930.36544* power(V.[PREDICTION] ,1)  + 1770.58433
		 when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.20 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.22 then  
		0.02064* power(V.[PREDICTION] ,6)   - 0.94092* power(V.[PREDICTION] ,5)  + 16.66635* power(V.[PREDICTION] ,4)   - 147.24010* power(V.[PREDICTION] ,3)   + 709.72720* power(V.[PREDICTION] ,2)  - 1707.03346* power(V.[PREDICTION] ,1)   + 1572.44364
		when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) = 1.22  then  
		0.01637* power(V.[PREDICTION] ,6)   - 0.78706* power(V.[PREDICTION] ,5)   + 14.41281* power(V.[PREDICTION] ,4)   - 130.10066* power(V.[PREDICTION] ,3)   + 638.75844* power(V.[PREDICTION] ,2)   - 1553.94099* power(V.[PREDICTION] ,1)  + 1437.37536
 end
WHEN V.[PREDICTION] > 9 and V.[PREDICTION] < 14.5 THEN 
		case when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.02 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.04 then  
		0.152157* power(V.[PREDICTION] ,6) + 10.693756* power(V.[PREDICTION] ,5)  - 310.617647* power(V.[PREDICTION] ,4)  + 4771.726125* power(V.[PREDICTION] ,3)  - 40912.951432* power(V.[PREDICTION] ,2)  + 186099.229288* power(V.[PREDICTION] ,1)  - 351221.525372 
		  when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.04 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.06 then  
		-0.124967* power(V.[PREDICTION] ,6)  + 8.633544* power(V.[PREDICTION] ,5)  - 245.986174* power(V.[PREDICTION] ,4)  + 3697.682001* power(V.[PREDICTION] ,3)  - 30946.006109* power(V.[PREDICTION] ,2)  + 137148.070514* power(V.[PREDICTION] ,1)  - 251822.697487
		when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.06 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.08 then     
		-0.098301* power(V.[PREDICTION] ,6)  + 6.687903* power(V.[PREDICTION] ,5)  - 187.075917* power(V.[PREDICTION] ,4)  + 2750.820812* power(V.[PREDICTION] ,3)  - 22431.658413* power(V.[PREDICTION] ,2)  + 96563.546543* power(V.[PREDICTION] ,1)  - 171734.570134
		when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.08 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.10 then  
		-0.074248* power(V.[PREDICTION] ,6)  + 4.925370* power(V.[PREDICTION] ,5) - 133.438411* power(V.[PREDICTION] ,4)  + 1883.750758* power(V.[PREDICTION] ,3)  - 14585.209154* power(V.[PREDICTION] ,2)  + 58902.832622* power(V.[PREDICTION] ,1)  - 96855.540806
		 when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.10 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.12 then  
		-0.019869* power(V.[PREDICTION] ,6)   + 0.999819* power(V.[PREDICTION] ,5)   - 15.867773* power(V.[PREDICTION] ,4)   + 14.355984* power(V.[PREDICTION] ,3)   + 2052.010155* power(V.[PREDICTION] ,2)   - 19653.638989* power(V.[PREDICTION] ,1)  + 56872.128962 
		 when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.12 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.14 then  
		-0.025098* power(V.[PREDICTION] ,6)   + 1.376290* power(V.[PREDICTION] ,5)   - 27.079940* power(V.[PREDICTION] ,4)   + 191.645713* power(V.[PREDICTION] ,3)   + 477.191154* power(V.[PREDICTION] ,2)   - 12181.873102* power(V.[PREDICTION] ,1)   + 42070.863315
		when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.14 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.16 then  
		0.028235* power(V.[PREDICTION] ,6)  - 2.484223* power(V.[PREDICTION] ,5)  + 88.843137* power(V.[PREDICTION] ,4)   - 1655.984591* power(V.[PREDICTION] ,3)  + 16956.151119* power(V.[PREDICTION] ,2)   - 90136.991435* power(V.[PREDICTION] ,1)   + 194863.838242
		when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.16 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.18 then  
		0.104052* power(V.[PREDICTION] ,6)  - 7.999457* power(V.[PREDICTION] ,5)   + 255.240070* power(V.[PREDICTION] ,4)   - 4320.239868* power(V.[PREDICTION] ,3)   + 40825.260416* power(V.[PREDICTION] ,2)   - 203556.079333* power(V.[PREDICTION] ,1)   + 418155.285642
		 when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.18 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.20 then  
		0.127059* power(V.[PREDICTION] ,6)   - 9.645671* power(V.[PREDICTION] ,5)   + 304.050528* power(V.[PREDICTION] ,4)   - 5087.213279* power(V.[PREDICTION] ,3)   + 47555.503896* power(V.[PREDICTION] ,2)   - 234803.599422* power(V.[PREDICTION] ,1)   + 478109.843470
		 when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.20 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.22 then  
		0.132288* power(V.[PREDICTION] ,6)   - 10.011885* power(V.[PREDICTION] ,5)   + 314.647310* power(V.[PREDICTION] ,4)   - 5248.832844* power(V.[PREDICTION] ,3)   + 48920.546676* power(V.[PREDICTION] ,2)   - 240834.122688* power(V.[PREDICTION] ,1)   + 488975.158190
		when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) = 1.22  then  
		0.066047* power(V.[PREDICTION] ,6)   - 5.247376* power(V.[PREDICTION] ,5)   + 172.339049* power(V.[PREDICTION] ,4)   - 2988.955128* power(V.[PREDICTION] ,3)   + 28791.781162* power(V.[PREDICTION] ,2)  - 145473.363921* power(V.[PREDICTION] ,1)   + 301262.823738
end
 
end	as Potencia

  FROM [ActionETL].[dbo].[DT_FORECAST_TEMPERATURA] as [T]
  join  [ActionETL].[dbo].[DT_FORECAST_PRESSAO] as [P] on T.[DATE] = P.[DATE] 
  join  [ActionETL].[dbo].[DT_FORECAST_VELOCIDADE] as [V] on P.[DATE] = V.[DATE] 
	  where T.[SystemNumber]=@AEG and V.[SystemNumber]=@AEG and P.[SystemNumber]=@AEG
order by  T.[DATE] desc) as [V]  ON	 CONVERT(DATE,[T].[TimeStampLocalSystem])  =  [v].[DATE]
WHERE [SystemNumber] =    @AEG and  [Name] = 'power' and  CONVERT(DATE,TimeStampLocalSystem) between   @datestart and  @dateend 
 
GROUP BY  CONVERT(DATE,TimeStampLocalSystem)   
order by  CONVERT(DATE,TimeStampLocalSystem)  ASC
end
 end




DECLARE @CGE varchar(255)
SET @CGE = '{COMBOCGE2}'
DECLARE @count varchar(255)
SET @count =  (select count(distinct(SystemNumber)) from  [ActionETL].[dbo].[DT_FORECAST_TEMPERATURA]  WHERE   [SystemNumber] in (SELECT [SystemNumber] FROM [ActionNet_BW].[dbo].[Base_Comum] WHERE ([Usina]=@CGE or [Parque]=@CGE) and Equipamento like 'AEG%')  )
 
DECLARE @CheckCGE varchar(255)
SET @CheckCGE = '{checkCGE2}'
IF @CheckCGE= 'TRUE'
BEGIN
 
	IF @CGE  IN ('COR','INH', 'TEI', 'ANG',  'BW1' )
  begin  
 
select  
     
 t.[DATE],
 round((avg([Real])),2) as [Real] ,
 round(avg([Predição]),2) as [Predição]
   
  FROM (

select  CONVERT(DATE,TimeStampLocalSystem) as [DATE],round((sum([Minute10Average])*24)/1000,2) as [Real]from[SCADACustomerHistorical].[dbo].[BAPINANGICSMS01] where  [Name] = 'power' and  [SystemNumber] in (SELECT [SystemNumber] FROM [ActionNet_BW].[dbo].[Base_Comum] WHERE ([Usina]=@CGE or [Parque]=@CGE) and Equipamento like 'AEG%')   GROUP BY  TimeStampLocalSystem   )as [T]
   	left JOIN (

select
		  [DATE],round((sum([Potencia])*24)/1000,2) as [Predição] 
	 
     FROM   (SELECT TOP (7*@count) T.[DATE], round(T.[PREDICTION],2) as [PREDICTION_TEMPERATURA],
	  round(P.[PREDICTION],2) as [PREDICTION_PRESSAO], round(V.[PREDICTION],2) as [PREDICTION_VELOCIDADE],
	    ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) as [Densidade],
CASE WHEN V.[PREDICTION] <= 3.05 THEN 0	   
WHEN V.[PREDICTION] >= 14.5 THEN 1850
WHEN V.[PREDICTION] > 3.05 and V.[PREDICTION] <=9 THEN 
	case when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.02 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.04 then  
	0.04582 * power(V.[PREDICTION] ,6) - 1.83445* power( V.[PREDICTION],5)  + 29.69465* power( V.[PREDICTION],4) - 247.26779* power(V.[PREDICTION] ,3)  + 1133.11081* power( V.[PREDICTION],2)  - 2651.7319* power(V.[PREDICTION] ,1)  + 2440.26614
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.04 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.06 then  
	0.04238* power(V.[PREDICTION] ,6)   - 1.71997* power(V.[PREDICTION] ,5)   + 28.13286* power(V.[PREDICTION] ,4)   - 236.00657* power(V.[PREDICTION] ,3)   + 1087.82802* power(V.[PREDICTION] ,2)   - 2553.99536* power(V.[PREDICTION] ,1)  + 2351.72213
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.06 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.08 then     
	0.03688 *power(V.[PREDICTION] ,6)  - 1.51700 *power(V.[PREDICTION] ,5)   + 25.10791* power(V.[PREDICTION] ,4)   - 212.72109 *power(V.[PREDICTION] ,3)  + 990.66068 *power(V.[PREDICTION] ,2)   - 2344.73747* power(V.[PREDICTION] ,1)   + 2169.49876
    when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.08 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.10 then  
	0.03935* power(V.[PREDICTION] ,6)  - 1.61219* power(V.[PREDICTION] ,5) + 26.55421* power(V.[PREDICTION] ,4)  - 223.78369* power(V.[PREDICTION] ,3) + 1035.67512* power(V.[PREDICTION] ,2)  - 2435.64408* power(V.[PREDICTION],1)  + 2239.96359
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.10 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.12 then  
	0.03495* power(V.[PREDICTION] ,6) - 1.44222* power(V.[PREDICTION] ,5)+ 23.88447* power(V.[PREDICTION] ,4) - 202.00436* power(V.[PREDICTION] ,3) + 938.96610* power(V.[PREDICTION] ,2) - 2213.45313* power(V.[PREDICTION] ,1) + 2033.83237
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.12 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.14 then  
	0.03041* power(V.[PREDICTION] ,6) - 1.29353* power(V.[PREDICTION] ,5) + 21.91920* power(V.[PREDICTION] ,4) - 188.56855* power(V.[PREDICTION] ,3) + 889.05442* power(V.[PREDICTION] ,2) - 2116.66540* power(V.[PREDICTION] ,1) + 1956.33114
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.14 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.16 then  
	0.02862* power(V.[PREDICTION] ,6) - 1.22039* power(V.[PREDICTION] ,5) + 20.68813* power(V.[PREDICTION] ,4) - 177.73029* power(V.[PREDICTION] ,3) + 837.20934* power(V.[PREDICTION] ,2) - 1988.69713* power(V.[PREDICTION] ,1) + 1829.61682
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.16 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.18 then  
	0.02298* power(V.[PREDICTION] ,6) - 1.02724* power(V.[PREDICTION] ,5) + 18.01168* power(V.[PREDICTION] ,4) - 158.56628* power(V.[PREDICTION] ,3) + 762.91353* power(V.[PREDICTION] ,2) - 1839.95011* power(V.[PREDICTION] ,1) + 1708.67585
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.18 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.20 then  
	0.02669* power(V.[PREDICTION] ,6)  - 1.15888* power(V.[PREDICTION] ,5)  + 19.86589* power(V.[PREDICTION] ,4)   - 171.71958* power(V.[PREDICTION] ,3)  + 812.19356* power(V.[PREDICTION] ,2)   - 1930.36544* power(V.[PREDICTION] ,1)  + 1770.58433
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.20 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.22 then  
	0.02064* power(V.[PREDICTION] ,6)   - 0.94092* power(V.[PREDICTION] ,5)  + 16.66635* power(V.[PREDICTION] ,4)   - 147.24010* power(V.[PREDICTION] ,3)   + 709.72720* power(V.[PREDICTION] ,2)  - 1707.03346* power(V.[PREDICTION] ,1)   + 1572.44364
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) = 1.22  then  
	0.01637* power(V.[PREDICTION] ,6)   - 0.78706* power(V.[PREDICTION] ,5)   + 14.41281* power(V.[PREDICTION] ,4)   - 130.10066* power(V.[PREDICTION] ,3)   + 638.75844* power(V.[PREDICTION] ,2)   - 1553.94099* power(V.[PREDICTION] ,1)  + 1437.37536
end
WHEN V.[PREDICTION] > 9 and V.[PREDICTION] < 14.5 THEN 
	case when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.02 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.04 then  
	0.152157* power(V.[PREDICTION] ,6) + 10.693756* power(V.[PREDICTION] ,5)  - 310.617647* power(V.[PREDICTION] ,4)  + 4771.726125* power(V.[PREDICTION] ,3)  - 40912.951432* power(V.[PREDICTION] ,2)  + 186099.229288* power(V.[PREDICTION] ,1)  - 351221.525372 
	 when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.04 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.06 then  
	-0.124967* power(V.[PREDICTION] ,6)  + 8.633544* power(V.[PREDICTION] ,5)  - 245.986174* power(V.[PREDICTION] ,4)  + 3697.682001* power(V.[PREDICTION] ,3)  - 30946.006109* power(V.[PREDICTION] ,2)  + 137148.070514* power(V.[PREDICTION] ,1)  - 251822.697487
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.06 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.08 then     
	-0.098301* power(V.[PREDICTION] ,6)  + 6.687903* power(V.[PREDICTION] ,5)  - 187.075917* power(V.[PREDICTION] ,4)  + 2750.820812* power(V.[PREDICTION] ,3)  - 22431.658413* power(V.[PREDICTION] ,2)  + 96563.546543* power(V.[PREDICTION] ,1)  - 171734.570134
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.08 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.10 then  
	-0.074248* power(V.[PREDICTION] ,6)  + 4.925370* power(V.[PREDICTION] ,5) - 133.438411* power(V.[PREDICTION] ,4)  + 1883.750758* power(V.[PREDICTION] ,3)  - 14585.209154* power(V.[PREDICTION] ,2)  + 58902.832622* power(V.[PREDICTION] ,1)  - 96855.540806
	 when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.10 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.12 then  
	-0.019869* power(V.[PREDICTION] ,6)   + 0.999819* power(V.[PREDICTION] ,5)   - 15.867773* power(V.[PREDICTION] ,4)   + 14.355984* power(V.[PREDICTION] ,3)   + 2052.010155* power(V.[PREDICTION] ,2)   - 19653.638989* power(V.[PREDICTION] ,1)  + 56872.128962 
	 when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.12 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.14 then  
	-0.025098* power(V.[PREDICTION] ,6)   + 1.376290* power(V.[PREDICTION] ,5)   - 27.079940* power(V.[PREDICTION] ,4)   + 191.645713* power(V.[PREDICTION] ,3)   + 477.191154* power(V.[PREDICTION] ,2)   - 12181.873102* power(V.[PREDICTION] ,1)   + 42070.863315
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.14 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.16 then  
	0.028235* power(V.[PREDICTION] ,6)  - 2.484223* power(V.[PREDICTION] ,5)  + 88.843137* power(V.[PREDICTION] ,4)   - 1655.984591* power(V.[PREDICTION] ,3)  + 16956.151119* power(V.[PREDICTION] ,2)   - 90136.991435* power(V.[PREDICTION] ,1)   + 194863.838242
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.16 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.18 then  
	0.104052* power(V.[PREDICTION] ,6)  - 7.999457* power(V.[PREDICTION] ,5)   + 255.240070* power(V.[PREDICTION] ,4)   - 4320.239868* power(V.[PREDICTION] ,3)   + 40825.260416* power(V.[PREDICTION] ,2)   - 203556.079333* power(V.[PREDICTION] ,1)   + 418155.285642
	 when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.18 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.20 then  
	0.127059* power(V.[PREDICTION] ,6)   - 9.645671* power(V.[PREDICTION] ,5)   + 304.050528* power(V.[PREDICTION] ,4)   - 5087.213279* power(V.[PREDICTION] ,3)   + 47555.503896* power(V.[PREDICTION] ,2)   - 234803.599422* power(V.[PREDICTION] ,1)   + 478109.843470
	 when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.20 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.22 then  
	0.132288* power(V.[PREDICTION] ,6)   - 10.011885* power(V.[PREDICTION] ,5)   + 314.647310* power(V.[PREDICTION] ,4)   - 5248.832844* power(V.[PREDICTION] ,3)   + 48920.546676* power(V.[PREDICTION] ,2)   - 240834.122688* power(V.[PREDICTION] ,1)   + 488975.158190
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) = 1.22  then  
	0.066047* power(V.[PREDICTION] ,6)   - 5.247376* power(V.[PREDICTION] ,5)   + 172.339049* power(V.[PREDICTION] ,4)   - 2988.955128* power(V.[PREDICTION] ,3)   + 28791.781162* power(V.[PREDICTION] ,2)  - 145473.363921* power(V.[PREDICTION] ,1)   + 301262.823738
end
 
end	as Potencia

FROM [ActionETL].[dbo].[DT_FORECAST_TEMPERATURA] as [T]
  join  [ActionETL].[dbo].[DT_FORECAST_PRESSAO] as [P]
    on T.[DATE] = P.[DATE] and t.[SystemNumber]=p.SystemNumber
  join  [ActionETL].[dbo].[DT_FORECAST_VELOCIDADE] as [V]
    on t.[DATE] = V.[DATE] and t.[SystemNumber]=v.SystemNumber
	WHERE   t.[SystemNumber] in (SELECT [SystemNumber] FROM [ActionNet_BW].[dbo].[Base_Comum] WHERE ([Usina]=@CGE or [Parque]=@CGE) and Equipamento like 'AEG%')  
	  
order by  T.[DATE] desc)  as  [d]  

	 group by  [date]
	 ) 	as [k]	ON	 [t].[DATE]  =  [k].[DATE]  
               where   CONVERT(DATE,t.[DATE]) between   @datestart and  @dateend
GROUP BY  t.[DATE]  
order by  [DATE]  ASC
 

end
 
	  
else if  @CGE  IN ('COQ','TAM', 'CAI','BW2')
  begin  
 
select  
     
 t.[DATE],
 round((avg([Real])),2) as [Real] ,
 round(avg([Predição]),2) as [Predição]
   
  FROM (

select  CONVERT(DATE,TimeStampLocalSystem) as [DATE],round((sum([Minute10Average])*24)/1000,2) as [Real]from[SCADACustomerHistorical].[dbo].[BAPINTEIUSMS01] where  [Name] = 'power' and  [SystemNumber] in (SELECT [SystemNumber] FROM [ActionNet_BW].[dbo].[Base_Comum] WHERE ([Usina]=@CGE or [Parque]=@CGE) and Equipamento like 'AEG%')    GROUP BY    TimeStampLocalSystem   )as [T]
   	left JOIN (

select
		  [DATE],round((sum([Potencia])*24)/1000,2) as [Predição] 
	 
     FROM   (SELECT TOP (7*@count) T.[DATE], round(T.[PREDICTION],2) as [PREDICTION_TEMPERATURA],
	  round(P.[PREDICTION],2) as [PREDICTION_PRESSAO], round(V.[PREDICTION],2) as [PREDICTION_VELOCIDADE],
	    ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) as [Densidade],
CASE WHEN V.[PREDICTION] <= 3.05 THEN 0	   
WHEN V.[PREDICTION] >= 14.5 THEN 1850
WHEN V.[PREDICTION] > 3.05 and V.[PREDICTION] <=9 THEN 
	case when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.02 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.04 then  
	0.04582 * power(V.[PREDICTION] ,6) - 1.83445* power( V.[PREDICTION],5)  + 29.69465* power( V.[PREDICTION],4) - 247.26779* power(V.[PREDICTION] ,3)  + 1133.11081* power( V.[PREDICTION],2)  - 2651.7319* power(V.[PREDICTION] ,1)  + 2440.26614
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.04 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.06 then  
	0.04238* power(V.[PREDICTION] ,6)   - 1.71997* power(V.[PREDICTION] ,5)   + 28.13286* power(V.[PREDICTION] ,4)   - 236.00657* power(V.[PREDICTION] ,3)   + 1087.82802* power(V.[PREDICTION] ,2)   - 2553.99536* power(V.[PREDICTION] ,1)  + 2351.72213
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.06 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.08 then     
	0.03688 *power(V.[PREDICTION] ,6)  - 1.51700 *power(V.[PREDICTION] ,5)   + 25.10791* power(V.[PREDICTION] ,4)   - 212.72109 *power(V.[PREDICTION] ,3)  + 990.66068 *power(V.[PREDICTION] ,2)   - 2344.73747* power(V.[PREDICTION] ,1)   + 2169.49876
    when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.08 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.10 then  
	0.03935* power(V.[PREDICTION] ,6)  - 1.61219* power(V.[PREDICTION] ,5) + 26.55421* power(V.[PREDICTION] ,4)  - 223.78369* power(V.[PREDICTION] ,3) + 1035.67512* power(V.[PREDICTION] ,2)  - 2435.64408* power(V.[PREDICTION],1)  + 2239.96359
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.10 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.12 then  
	0.03495* power(V.[PREDICTION] ,6) - 1.44222* power(V.[PREDICTION] ,5)+ 23.88447* power(V.[PREDICTION] ,4) - 202.00436* power(V.[PREDICTION] ,3) + 938.96610* power(V.[PREDICTION] ,2) - 2213.45313* power(V.[PREDICTION] ,1) + 2033.83237
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.12 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.14 then  
	0.03041* power(V.[PREDICTION] ,6) - 1.29353* power(V.[PREDICTION] ,5) + 21.91920* power(V.[PREDICTION] ,4) - 188.56855* power(V.[PREDICTION] ,3) + 889.05442* power(V.[PREDICTION] ,2) - 2116.66540* power(V.[PREDICTION] ,1) + 1956.33114
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.14 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.16 then  
	0.02862* power(V.[PREDICTION] ,6) - 1.22039* power(V.[PREDICTION] ,5) + 20.68813* power(V.[PREDICTION] ,4) - 177.73029* power(V.[PREDICTION] ,3) + 837.20934* power(V.[PREDICTION] ,2) - 1988.69713* power(V.[PREDICTION] ,1) + 1829.61682
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.16 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.18 then  
	0.02298* power(V.[PREDICTION] ,6) - 1.02724* power(V.[PREDICTION] ,5) + 18.01168* power(V.[PREDICTION] ,4) - 158.56628* power(V.[PREDICTION] ,3) + 762.91353* power(V.[PREDICTION] ,2) - 1839.95011* power(V.[PREDICTION] ,1) + 1708.67585
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.18 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.20 then  
	0.02669* power(V.[PREDICTION] ,6)  - 1.15888* power(V.[PREDICTION] ,5)  + 19.86589* power(V.[PREDICTION] ,4)   - 171.71958* power(V.[PREDICTION] ,3)  + 812.19356* power(V.[PREDICTION] ,2)   - 1930.36544* power(V.[PREDICTION] ,1)  + 1770.58433
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.20 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.22 then  
	0.02064* power(V.[PREDICTION] ,6)   - 0.94092* power(V.[PREDICTION] ,5)  + 16.66635* power(V.[PREDICTION] ,4)   - 147.24010* power(V.[PREDICTION] ,3)   + 709.72720* power(V.[PREDICTION] ,2)  - 1707.03346* power(V.[PREDICTION] ,1)   + 1572.44364
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) = 1.22  then  
	0.01637* power(V.[PREDICTION] ,6)   - 0.78706* power(V.[PREDICTION] ,5)   + 14.41281* power(V.[PREDICTION] ,4)   - 130.10066* power(V.[PREDICTION] ,3)   + 638.75844* power(V.[PREDICTION] ,2)   - 1553.94099* power(V.[PREDICTION] ,1)  + 1437.37536
end
WHEN V.[PREDICTION] > 9 and V.[PREDICTION] < 14.5 THEN 
	case when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.02 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.04 then  
	0.152157* power(V.[PREDICTION] ,6) + 10.693756* power(V.[PREDICTION] ,5)  - 310.617647* power(V.[PREDICTION] ,4)  + 4771.726125* power(V.[PREDICTION] ,3)  - 40912.951432* power(V.[PREDICTION] ,2)  + 186099.229288* power(V.[PREDICTION] ,1)  - 351221.525372 
	 when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.04 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.06 then  
	-0.124967* power(V.[PREDICTION] ,6)  + 8.633544* power(V.[PREDICTION] ,5)  - 245.986174* power(V.[PREDICTION] ,4)  + 3697.682001* power(V.[PREDICTION] ,3)  - 30946.006109* power(V.[PREDICTION] ,2)  + 137148.070514* power(V.[PREDICTION] ,1)  - 251822.697487
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.06 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.08 then     
	-0.098301* power(V.[PREDICTION] ,6)  + 6.687903* power(V.[PREDICTION] ,5)  - 187.075917* power(V.[PREDICTION] ,4)  + 2750.820812* power(V.[PREDICTION] ,3)  - 22431.658413* power(V.[PREDICTION] ,2)  + 96563.546543* power(V.[PREDICTION] ,1)  - 171734.570134
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.08 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.10 then  
	-0.074248* power(V.[PREDICTION] ,6)  + 4.925370* power(V.[PREDICTION] ,5) - 133.438411* power(V.[PREDICTION] ,4)  + 1883.750758* power(V.[PREDICTION] ,3)  - 14585.209154* power(V.[PREDICTION] ,2)  + 58902.832622* power(V.[PREDICTION] ,1)  - 96855.540806
	 when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.10 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.12 then  
	-0.019869* power(V.[PREDICTION] ,6)   + 0.999819* power(V.[PREDICTION] ,5)   - 15.867773* power(V.[PREDICTION] ,4)   + 14.355984* power(V.[PREDICTION] ,3)   + 2052.010155* power(V.[PREDICTION] ,2)   - 19653.638989* power(V.[PREDICTION] ,1)  + 56872.128962 
	 when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.12 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.14 then  
	-0.025098* power(V.[PREDICTION] ,6)   + 1.376290* power(V.[PREDICTION] ,5)   - 27.079940* power(V.[PREDICTION] ,4)   + 191.645713* power(V.[PREDICTION] ,3)   + 477.191154* power(V.[PREDICTION] ,2)   - 12181.873102* power(V.[PREDICTION] ,1)   + 42070.863315
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.14 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.16 then  
	0.028235* power(V.[PREDICTION] ,6)  - 2.484223* power(V.[PREDICTION] ,5)  + 88.843137* power(V.[PREDICTION] ,4)   - 1655.984591* power(V.[PREDICTION] ,3)  + 16956.151119* power(V.[PREDICTION] ,2)   - 90136.991435* power(V.[PREDICTION] ,1)   + 194863.838242
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.16 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.18 then  
	0.104052* power(V.[PREDICTION] ,6)  - 7.999457* power(V.[PREDICTION] ,5)   + 255.240070* power(V.[PREDICTION] ,4)   - 4320.239868* power(V.[PREDICTION] ,3)   + 40825.260416* power(V.[PREDICTION] ,2)   - 203556.079333* power(V.[PREDICTION] ,1)   + 418155.285642
	 when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.18 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.20 then  
	0.127059* power(V.[PREDICTION] ,6)   - 9.645671* power(V.[PREDICTION] ,5)   + 304.050528* power(V.[PREDICTION] ,4)   - 5087.213279* power(V.[PREDICTION] ,3)   + 47555.503896* power(V.[PREDICTION] ,2)   - 234803.599422* power(V.[PREDICTION] ,1)   + 478109.843470
	 when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.20 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.22 then  
	0.132288* power(V.[PREDICTION] ,6)   - 10.011885* power(V.[PREDICTION] ,5)   + 314.647310* power(V.[PREDICTION] ,4)   - 5248.832844* power(V.[PREDICTION] ,3)   + 48920.546676* power(V.[PREDICTION] ,2)   - 240834.122688* power(V.[PREDICTION] ,1)   + 488975.158190
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) = 1.22  then  
	0.066047* power(V.[PREDICTION] ,6)   - 5.247376* power(V.[PREDICTION] ,5)   + 172.339049* power(V.[PREDICTION] ,4)   - 2988.955128* power(V.[PREDICTION] ,3)   + 28791.781162* power(V.[PREDICTION] ,2)  - 145473.363921* power(V.[PREDICTION] ,1)   + 301262.823738
end
 
end	as Potencia

FROM [ActionETL].[dbo].[DT_FORECAST_TEMPERATURA] as [T]
  join  [ActionETL].[dbo].[DT_FORECAST_PRESSAO] as [P]
    on T.[DATE] = P.[DATE] and t.[SystemNumber]=p.SystemNumber
  join  [ActionETL].[dbo].[DT_FORECAST_VELOCIDADE] as [V]
    on t.[DATE] = V.[DATE] and t.[SystemNumber]=v.SystemNumber
	WHERE   t.[SystemNumber] in (SELECT [SystemNumber] FROM [ActionNet_BW].[dbo].[Base_Comum] WHERE ([Usina]=@CGE or [Parque]=@CGE) and Equipamento like 'AEG%')  
	  
order by  T.[DATE] desc)  as  [d]  

	 group by  [date]
	 ) 	as [k]	ON	 [t].[DATE]  =  [k].[DATE]  
               where   CONVERT(DATE,t.[DATE]) between   @datestart and  @dateend
GROUP BY  t.[DATE]  
order by  [DATE]  ASC
 

end


else if @CGE  IN ('TODOS')
 begin
  

   
 DECLARE @count1 varchar(255)
 DECLARE @count2 varchar(255)
SET @count1 =  (select count(distinct(SystemNumber)) from  [ActionETL].[dbo].[DT_FORECAST_TEMPERATURA]  WHERE   [SystemNumber] in (SELECT [SystemNumber] FROM [ActionNet_BW].[dbo].[Base_Comum] WHERE ([Usina]='BW1' or [Parque]='BW1'or [Usina]='BW2' or [Parque]='BW2') and Equipamento like 'AEG%')  )
 
SET @count2 =  (select count(distinct(SystemNumber)) from  [ActionETL].[dbo].[DT_FORECAST_TEMPERATURA]  WHERE   [SystemNumber] in (SELECT [SystemNumber] FROM [ActionNet_BW].[dbo].[Base_Comum] WHERE ([Usina]='BW2' or [Parque]='BW2') and Equipamento like 'AEG%')  )
 


 select  
     
  [DATE],
 round(sum([Real]),2)  as [Real] ,
 round(sum([Predição]),2) as [Predição]
   
  FROM (  select  
     
 t.[DATE],
 round((avg([Real])),2) as [Real] ,
 round(avg([Predição]),2) as [Predição]
   
  FROM (

select  CONVERT(DATE,TimeStampLocalSystem) as [DATE],round((sum([Minute10Average])*24)/1000,2) as [Real]from[SCADACustomerHistorical].[dbo].[BAPINANGICSMS01]where  [Name] = 'power' and  [SystemNumber] in (SELECT [SystemNumber] FROM [ActionNet_BW].[dbo].[Base_Comum] WHERE ([Usina]='bw1' or [Parque]='bw1') and Equipamento like 'AEG%')    GROUP BY    TimeStampLocalSystem   )as [T]
   	left JOIN (

select
		  [DATE],round((sum([Potencia])*24)/1000,2) as [Predição] 
	 
     FROM   (SELECT TOP (7*@count1 ) T.[DATE], round(T.[PREDICTION],2) as [PREDICTION_TEMPERATURA],
	  round(P.[PREDICTION],2) as [PREDICTION_PRESSAO], round(V.[PREDICTION],2) as [PREDICTION_VELOCIDADE],
	    ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) as [Densidade],
CASE WHEN V.[PREDICTION] <= 3.05 THEN 0	   
WHEN V.[PREDICTION] >= 14.5 THEN 1850
WHEN V.[PREDICTION] > 3.05 and V.[PREDICTION] <=9 THEN 
	case when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.02 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.04 then  
	0.04582 * power(V.[PREDICTION] ,6) - 1.83445* power( V.[PREDICTION],5)  + 29.69465* power( V.[PREDICTION],4) - 247.26779* power(V.[PREDICTION] ,3)  + 1133.11081* power( V.[PREDICTION],2)  - 2651.7319* power(V.[PREDICTION] ,1)  + 2440.26614
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.04 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.06 then  
	0.04238* power(V.[PREDICTION] ,6)   - 1.71997* power(V.[PREDICTION] ,5)   + 28.13286* power(V.[PREDICTION] ,4)   - 236.00657* power(V.[PREDICTION] ,3)   + 1087.82802* power(V.[PREDICTION] ,2)   - 2553.99536* power(V.[PREDICTION] ,1)  + 2351.72213
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.06 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.08 then     
	0.03688 *power(V.[PREDICTION] ,6)  - 1.51700 *power(V.[PREDICTION] ,5)   + 25.10791* power(V.[PREDICTION] ,4)   - 212.72109 *power(V.[PREDICTION] ,3)  + 990.66068 *power(V.[PREDICTION] ,2)   - 2344.73747* power(V.[PREDICTION] ,1)   + 2169.49876
    when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.08 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.10 then  
	0.03935* power(V.[PREDICTION] ,6)  - 1.61219* power(V.[PREDICTION] ,5) + 26.55421* power(V.[PREDICTION] ,4)  - 223.78369* power(V.[PREDICTION] ,3) + 1035.67512* power(V.[PREDICTION] ,2)  - 2435.64408* power(V.[PREDICTION],1)  + 2239.96359
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.10 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.12 then  
	0.03495* power(V.[PREDICTION] ,6) - 1.44222* power(V.[PREDICTION] ,5)+ 23.88447* power(V.[PREDICTION] ,4) - 202.00436* power(V.[PREDICTION] ,3) + 938.96610* power(V.[PREDICTION] ,2) - 2213.45313* power(V.[PREDICTION] ,1) + 2033.83237
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.12 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.14 then  
	0.03041* power(V.[PREDICTION] ,6) - 1.29353* power(V.[PREDICTION] ,5) + 21.91920* power(V.[PREDICTION] ,4) - 188.56855* power(V.[PREDICTION] ,3) + 889.05442* power(V.[PREDICTION] ,2) - 2116.66540* power(V.[PREDICTION] ,1) + 1956.33114
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.14 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.16 then  
	0.02862* power(V.[PREDICTION] ,6) - 1.22039* power(V.[PREDICTION] ,5) + 20.68813* power(V.[PREDICTION] ,4) - 177.73029* power(V.[PREDICTION] ,3) + 837.20934* power(V.[PREDICTION] ,2) - 1988.69713* power(V.[PREDICTION] ,1) + 1829.61682
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.16 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.18 then  
	0.02298* power(V.[PREDICTION] ,6) - 1.02724* power(V.[PREDICTION] ,5) + 18.01168* power(V.[PREDICTION] ,4) - 158.56628* power(V.[PREDICTION] ,3) + 762.91353* power(V.[PREDICTION] ,2) - 1839.95011* power(V.[PREDICTION] ,1) + 1708.67585
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.18 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.20 then  
	0.02669* power(V.[PREDICTION] ,6)  - 1.15888* power(V.[PREDICTION] ,5)  + 19.86589* power(V.[PREDICTION] ,4)   - 171.71958* power(V.[PREDICTION] ,3)  + 812.19356* power(V.[PREDICTION] ,2)   - 1930.36544* power(V.[PREDICTION] ,1)  + 1770.58433
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.20 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.22 then  
	0.02064* power(V.[PREDICTION] ,6)   - 0.94092* power(V.[PREDICTION] ,5)  + 16.66635* power(V.[PREDICTION] ,4)   - 147.24010* power(V.[PREDICTION] ,3)   + 709.72720* power(V.[PREDICTION] ,2)  - 1707.03346* power(V.[PREDICTION] ,1)   + 1572.44364
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) = 1.22  then  
	0.01637* power(V.[PREDICTION] ,6)   - 0.78706* power(V.[PREDICTION] ,5)   + 14.41281* power(V.[PREDICTION] ,4)   - 130.10066* power(V.[PREDICTION] ,3)   + 638.75844* power(V.[PREDICTION] ,2)   - 1553.94099* power(V.[PREDICTION] ,1)  + 1437.37536
end
WHEN V.[PREDICTION] > 9 and V.[PREDICTION] < 14.5 THEN 
	case when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.02 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.04 then  
	0.152157* power(V.[PREDICTION] ,6) + 10.693756* power(V.[PREDICTION] ,5)  - 310.617647* power(V.[PREDICTION] ,4)  + 4771.726125* power(V.[PREDICTION] ,3)  - 40912.951432* power(V.[PREDICTION] ,2)  + 186099.229288* power(V.[PREDICTION] ,1)  - 351221.525372 
	 when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.04 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.06 then  
	-0.124967* power(V.[PREDICTION] ,6)  + 8.633544* power(V.[PREDICTION] ,5)  - 245.986174* power(V.[PREDICTION] ,4)  + 3697.682001* power(V.[PREDICTION] ,3)  - 30946.006109* power(V.[PREDICTION] ,2)  + 137148.070514* power(V.[PREDICTION] ,1)  - 251822.697487
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.06 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.08 then     
	-0.098301* power(V.[PREDICTION] ,6)  + 6.687903* power(V.[PREDICTION] ,5)  - 187.075917* power(V.[PREDICTION] ,4)  + 2750.820812* power(V.[PREDICTION] ,3)  - 22431.658413* power(V.[PREDICTION] ,2)  + 96563.546543* power(V.[PREDICTION] ,1)  - 171734.570134
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.08 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.10 then  
	-0.074248* power(V.[PREDICTION] ,6)  + 4.925370* power(V.[PREDICTION] ,5) - 133.438411* power(V.[PREDICTION] ,4)  + 1883.750758* power(V.[PREDICTION] ,3)  - 14585.209154* power(V.[PREDICTION] ,2)  + 58902.832622* power(V.[PREDICTION] ,1)  - 96855.540806
	 when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.10 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.12 then  
	-0.019869* power(V.[PREDICTION] ,6)   + 0.999819* power(V.[PREDICTION] ,5)   - 15.867773* power(V.[PREDICTION] ,4)   + 14.355984* power(V.[PREDICTION] ,3)   + 2052.010155* power(V.[PREDICTION] ,2)   - 19653.638989* power(V.[PREDICTION] ,1)  + 56872.128962 
	 when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.12 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.14 then  
	-0.025098* power(V.[PREDICTION] ,6)   + 1.376290* power(V.[PREDICTION] ,5)   - 27.079940* power(V.[PREDICTION] ,4)   + 191.645713* power(V.[PREDICTION] ,3)   + 477.191154* power(V.[PREDICTION] ,2)   - 12181.873102* power(V.[PREDICTION] ,1)   + 42070.863315
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.14 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.16 then  
	0.028235* power(V.[PREDICTION] ,6)  - 2.484223* power(V.[PREDICTION] ,5)  + 88.843137* power(V.[PREDICTION] ,4)   - 1655.984591* power(V.[PREDICTION] ,3)  + 16956.151119* power(V.[PREDICTION] ,2)   - 90136.991435* power(V.[PREDICTION] ,1)   + 194863.838242
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.16 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.18 then  
	0.104052* power(V.[PREDICTION] ,6)  - 7.999457* power(V.[PREDICTION] ,5)   + 255.240070* power(V.[PREDICTION] ,4)   - 4320.239868* power(V.[PREDICTION] ,3)   + 40825.260416* power(V.[PREDICTION] ,2)   - 203556.079333* power(V.[PREDICTION] ,1)   + 418155.285642
	 when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.18 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.20 then  
	0.127059* power(V.[PREDICTION] ,6)   - 9.645671* power(V.[PREDICTION] ,5)   + 304.050528* power(V.[PREDICTION] ,4)   - 5087.213279* power(V.[PREDICTION] ,3)   + 47555.503896* power(V.[PREDICTION] ,2)   - 234803.599422* power(V.[PREDICTION] ,1)   + 478109.843470
	 when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.20 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.22 then  
	0.132288* power(V.[PREDICTION] ,6)   - 10.011885* power(V.[PREDICTION] ,5)   + 314.647310* power(V.[PREDICTION] ,4)   - 5248.832844* power(V.[PREDICTION] ,3)   + 48920.546676* power(V.[PREDICTION] ,2)   - 240834.122688* power(V.[PREDICTION] ,1)   + 488975.158190
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) = 1.22  then  
	0.066047* power(V.[PREDICTION] ,6)   - 5.247376* power(V.[PREDICTION] ,5)   + 172.339049* power(V.[PREDICTION] ,4)   - 2988.955128* power(V.[PREDICTION] ,3)   + 28791.781162* power(V.[PREDICTION] ,2)  - 145473.363921* power(V.[PREDICTION] ,1)   + 301262.823738
end
 
end	as Potencia

FROM [ActionETL].[dbo].[DT_FORECAST_TEMPERATURA] as [T]
  join  [ActionETL].[dbo].[DT_FORECAST_PRESSAO] as [P]
    on T.[DATE] = P.[DATE] and t.[SystemNumber]=p.SystemNumber
  join  [ActionETL].[dbo].[DT_FORECAST_VELOCIDADE] as [V]
    on t.[DATE] = V.[DATE] and t.[SystemNumber]=v.SystemNumber
	WHERE   t.[SystemNumber] in (SELECT [SystemNumber] FROM [ActionNet_BW].[dbo].[Base_Comum] WHERE ([Usina]='bw1' or [Parque]='bw1') and Equipamento like 'AEG%')  
	  
order by  T.[DATE] desc)  as  [d]  

	 group by  [date]
	 ) 	as [k]	ON	 [t].[DATE]  =  [k].[DATE]  
            
GROUP BY  t.[DATE]  
 
         
 
 
union all
  select  
     
 t.[DATE],
 round((avg([Real])),2) as [Real] ,
 round(avg([Predição]),2) as [Predição]
   
  FROM (

select  CONVERT(DATE,TimeStampLocalSystem) as [DATE],round((sum([Minute10Average])*24)/1000,2) as [Real]from[SCADACustomerHistorical].[dbo].[BAPINTEIUSMS01]where  [Name] = 'power' and  [SystemNumber] in (SELECT [SystemNumber] FROM [ActionNet_BW].[dbo].[Base_Comum] WHERE ([Usina]='bw2' or [Parque]='bw2') and Equipamento like 'AEG%')    GROUP BY   TimeStampLocalSystem   )as [T]
   	left JOIN (

select
		  [DATE],round((sum([Potencia])*24)/1000,2) as [Predição] 
	 
     FROM   (SELECT TOP (7*@count1 ) T.[DATE], round(T.[PREDICTION],2) as [PREDICTION_TEMPERATURA],
	  round(P.[PREDICTION],2) as [PREDICTION_PRESSAO], round(V.[PREDICTION],2) as [PREDICTION_VELOCIDADE],
	    ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) as [Densidade],
CASE WHEN V.[PREDICTION] <= 3.05 THEN 0	   
WHEN V.[PREDICTION] >= 14.5 THEN 1850
WHEN V.[PREDICTION] > 3.05 and V.[PREDICTION] <=9 THEN 
	case when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.02 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.04 then  
	0.04582 * power(V.[PREDICTION] ,6) - 1.83445* power( V.[PREDICTION],5)  + 29.69465* power( V.[PREDICTION],4) - 247.26779* power(V.[PREDICTION] ,3)  + 1133.11081* power( V.[PREDICTION],2)  - 2651.7319* power(V.[PREDICTION] ,1)  + 2440.26614
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.04 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.06 then  
	0.04238* power(V.[PREDICTION] ,6)   - 1.71997* power(V.[PREDICTION] ,5)   + 28.13286* power(V.[PREDICTION] ,4)   - 236.00657* power(V.[PREDICTION] ,3)   + 1087.82802* power(V.[PREDICTION] ,2)   - 2553.99536* power(V.[PREDICTION] ,1)  + 2351.72213
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.06 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.08 then     
	0.03688 *power(V.[PREDICTION] ,6)  - 1.51700 *power(V.[PREDICTION] ,5)   + 25.10791* power(V.[PREDICTION] ,4)   - 212.72109 *power(V.[PREDICTION] ,3)  + 990.66068 *power(V.[PREDICTION] ,2)   - 2344.73747* power(V.[PREDICTION] ,1)   + 2169.49876
    when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.08 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.10 then  
	0.03935* power(V.[PREDICTION] ,6)  - 1.61219* power(V.[PREDICTION] ,5) + 26.55421* power(V.[PREDICTION] ,4)  - 223.78369* power(V.[PREDICTION] ,3) + 1035.67512* power(V.[PREDICTION] ,2)  - 2435.64408* power(V.[PREDICTION],1)  + 2239.96359
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.10 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.12 then  
	0.03495* power(V.[PREDICTION] ,6) - 1.44222* power(V.[PREDICTION] ,5)+ 23.88447* power(V.[PREDICTION] ,4) - 202.00436* power(V.[PREDICTION] ,3) + 938.96610* power(V.[PREDICTION] ,2) - 2213.45313* power(V.[PREDICTION] ,1) + 2033.83237
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.12 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.14 then  
	0.03041* power(V.[PREDICTION] ,6) - 1.29353* power(V.[PREDICTION] ,5) + 21.91920* power(V.[PREDICTION] ,4) - 188.56855* power(V.[PREDICTION] ,3) + 889.05442* power(V.[PREDICTION] ,2) - 2116.66540* power(V.[PREDICTION] ,1) + 1956.33114
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.14 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.16 then  
	0.02862* power(V.[PREDICTION] ,6) - 1.22039* power(V.[PREDICTION] ,5) + 20.68813* power(V.[PREDICTION] ,4) - 177.73029* power(V.[PREDICTION] ,3) + 837.20934* power(V.[PREDICTION] ,2) - 1988.69713* power(V.[PREDICTION] ,1) + 1829.61682
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.16 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.18 then  
	0.02298* power(V.[PREDICTION] ,6) - 1.02724* power(V.[PREDICTION] ,5) + 18.01168* power(V.[PREDICTION] ,4) - 158.56628* power(V.[PREDICTION] ,3) + 762.91353* power(V.[PREDICTION] ,2) - 1839.95011* power(V.[PREDICTION] ,1) + 1708.67585
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.18 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.20 then  
	0.02669* power(V.[PREDICTION] ,6)  - 1.15888* power(V.[PREDICTION] ,5)  + 19.86589* power(V.[PREDICTION] ,4)   - 171.71958* power(V.[PREDICTION] ,3)  + 812.19356* power(V.[PREDICTION] ,2)   - 1930.36544* power(V.[PREDICTION] ,1)  + 1770.58433
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.20 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.22 then  
	0.02064* power(V.[PREDICTION] ,6)   - 0.94092* power(V.[PREDICTION] ,5)  + 16.66635* power(V.[PREDICTION] ,4)   - 147.24010* power(V.[PREDICTION] ,3)   + 709.72720* power(V.[PREDICTION] ,2)  - 1707.03346* power(V.[PREDICTION] ,1)   + 1572.44364
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) = 1.22  then  
	0.01637* power(V.[PREDICTION] ,6)   - 0.78706* power(V.[PREDICTION] ,5)   + 14.41281* power(V.[PREDICTION] ,4)   - 130.10066* power(V.[PREDICTION] ,3)   + 638.75844* power(V.[PREDICTION] ,2)   - 1553.94099* power(V.[PREDICTION] ,1)  + 1437.37536
end
WHEN V.[PREDICTION] > 9 and V.[PREDICTION] < 14.5 THEN 
	case when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.02 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.04 then  
	0.152157* power(V.[PREDICTION] ,6) + 10.693756* power(V.[PREDICTION] ,5)  - 310.617647* power(V.[PREDICTION] ,4)  + 4771.726125* power(V.[PREDICTION] ,3)  - 40912.951432* power(V.[PREDICTION] ,2)  + 186099.229288* power(V.[PREDICTION] ,1)  - 351221.525372 
	 when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.04 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.06 then  
	-0.124967* power(V.[PREDICTION] ,6)  + 8.633544* power(V.[PREDICTION] ,5)  - 245.986174* power(V.[PREDICTION] ,4)  + 3697.682001* power(V.[PREDICTION] ,3)  - 30946.006109* power(V.[PREDICTION] ,2)  + 137148.070514* power(V.[PREDICTION] ,1)  - 251822.697487
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.06 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.08 then     
	-0.098301* power(V.[PREDICTION] ,6)  + 6.687903* power(V.[PREDICTION] ,5)  - 187.075917* power(V.[PREDICTION] ,4)  + 2750.820812* power(V.[PREDICTION] ,3)  - 22431.658413* power(V.[PREDICTION] ,2)  + 96563.546543* power(V.[PREDICTION] ,1)  - 171734.570134
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.08 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.10 then  
	-0.074248* power(V.[PREDICTION] ,6)  + 4.925370* power(V.[PREDICTION] ,5) - 133.438411* power(V.[PREDICTION] ,4)  + 1883.750758* power(V.[PREDICTION] ,3)  - 14585.209154* power(V.[PREDICTION] ,2)  + 58902.832622* power(V.[PREDICTION] ,1)  - 96855.540806
	 when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.10 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.12 then  
	-0.019869* power(V.[PREDICTION] ,6)   + 0.999819* power(V.[PREDICTION] ,5)   - 15.867773* power(V.[PREDICTION] ,4)   + 14.355984* power(V.[PREDICTION] ,3)   + 2052.010155* power(V.[PREDICTION] ,2)   - 19653.638989* power(V.[PREDICTION] ,1)  + 56872.128962 
	 when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.12 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.14 then  
	-0.025098* power(V.[PREDICTION] ,6)   + 1.376290* power(V.[PREDICTION] ,5)   - 27.079940* power(V.[PREDICTION] ,4)   + 191.645713* power(V.[PREDICTION] ,3)   + 477.191154* power(V.[PREDICTION] ,2)   - 12181.873102* power(V.[PREDICTION] ,1)   + 42070.863315
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.14 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.16 then  
	0.028235* power(V.[PREDICTION] ,6)  - 2.484223* power(V.[PREDICTION] ,5)  + 88.843137* power(V.[PREDICTION] ,4)   - 1655.984591* power(V.[PREDICTION] ,3)  + 16956.151119* power(V.[PREDICTION] ,2)   - 90136.991435* power(V.[PREDICTION] ,1)   + 194863.838242
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.16 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.18 then  
	0.104052* power(V.[PREDICTION] ,6)  - 7.999457* power(V.[PREDICTION] ,5)   + 255.240070* power(V.[PREDICTION] ,4)   - 4320.239868* power(V.[PREDICTION] ,3)   + 40825.260416* power(V.[PREDICTION] ,2)   - 203556.079333* power(V.[PREDICTION] ,1)   + 418155.285642
	 when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.18 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.20 then  
	0.127059* power(V.[PREDICTION] ,6)   - 9.645671* power(V.[PREDICTION] ,5)   + 304.050528* power(V.[PREDICTION] ,4)   - 5087.213279* power(V.[PREDICTION] ,3)   + 47555.503896* power(V.[PREDICTION] ,2)   - 234803.599422* power(V.[PREDICTION] ,1)   + 478109.843470
	 when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) >= 1.20 and ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) < 1.22 then  
	0.132288* power(V.[PREDICTION] ,6)   - 10.011885* power(V.[PREDICTION] ,5)   + 314.647310* power(V.[PREDICTION] ,4)   - 5248.832844* power(V.[PREDICTION] ,3)   + 48920.546676* power(V.[PREDICTION] ,2)   - 240834.122688* power(V.[PREDICTION] ,1)   + 488975.158190
	when ((P.[PREDICTION] *100)/ ((T.[PREDICTION]+273.15)*287.058)) = 1.22  then  
	0.066047* power(V.[PREDICTION] ,6)   - 5.247376* power(V.[PREDICTION] ,5)   + 172.339049* power(V.[PREDICTION] ,4)   - 2988.955128* power(V.[PREDICTION] ,3)   + 28791.781162* power(V.[PREDICTION] ,2)  - 145473.363921* power(V.[PREDICTION] ,1)   + 301262.823738
end
 
end	as Potencia

FROM [ActionETL].[dbo].[DT_FORECAST_TEMPERATURA] as [T]
  join  [ActionETL].[dbo].[DT_FORECAST_PRESSAO] as [P]
    on T.[DATE] = P.[DATE] and t.[SystemNumber]=p.SystemNumber
  join  [ActionETL].[dbo].[DT_FORECAST_VELOCIDADE] as [V]
    on t.[DATE] = V.[DATE] and t.[SystemNumber]=v.SystemNumber
	WHERE   t.[SystemNumber] in (SELECT [SystemNumber] FROM [ActionNet_BW].[dbo].[Base_Comum] WHERE ([Usina]='bw2' or [Parque]='bw2') and Equipamento like 'AEG%')  
	  
order by  T.[DATE] desc)  as  [d]  

	 group by  [date]
	 ) 	as [k]	ON	 [t].[DATE]  =  [k].[DATE]  
            
GROUP BY  t.[DATE]  
 )as k where   CONVERT(DATE,k.[DATE]) between   @datestart and  @dateend 
         
 
  GROUP BY  k.[DATE] 
 

end

end 