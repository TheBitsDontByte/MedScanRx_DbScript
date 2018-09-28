ALTER PROCEDURE [dbo].[sp_deactivate_past_alerts]
AS 
  BEGIN 
      UPDATE prescriptionalert 
      SET    isactive = 0 
      FROM   prescriptionalert 
      WHERE  alertdatetime < GETUTCDATE()

	  update PrescriptionAlert
	  set IsActive = 0 
	  from prescription p
	  left join PrescriptionAlert pa on p.PrescriptionId = pa.PrescriptionId
	  where p.IsActive = 0;

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

	  update Prescription set CurrentNumberOfDoses = 0, CurrentNumberOfRefills = 0
	  where IsActive = 0;
  END 
