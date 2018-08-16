
CREATE PROCEDURE sp_deactivate_past_alerts
AS 
  BEGIN 
      UPDATE prescriptionalert 
      SET    isactive = 0 
      FROM   prescriptionalert 
      WHERE  alertdatetime < Getdate() 

      --run this at 35 after, keeps alarms active 35mins past due, then sunsets them 
      UPDATE prescription 
      SET    currentnumberofdoses = ISNULL(pa.activeprescriptions, 0) 
      FROM   prescription p 
             left JOIN (SELECT Count(*) activePrescriptions, 
                          prescriptionid 
                   FROM   prescriptionalert 
                   WHERE  TakenDateTime is null and IsActive = 1
                   GROUP  BY prescriptionid) pa 
               ON pa.prescriptionid = p.prescriptionid 

      UPDATE prescription 
      SET    isactive = 0 
      WHERE  currentnumberofdoses = 0; 
  END 
