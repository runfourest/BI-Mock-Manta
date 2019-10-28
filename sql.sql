CREATE TABLE prd_dw.Health_Indicator_Fact (










)




CREATE TABLE prd_dw.Patient_Dim (




)


CREATE TABLE prd_dw.Encounter_Dim (


)







CREATE TABLE prd_dw.Location_Dim(


)





CREATE TABLE prd_dw.Time_Dim (


)







# Patient SQL


SELECT
	Patient.PatientId,
	A.AlergyCount,




FROM
		



(
	SELECT
		COUNT(Allergy.AllergyID) as AlergyCount,
		PATIENT.PATIENTID
	FROM
		PATIENT as Patient
		INNER JOIN Allergy as Allergy on Allergy.PatientID = Patient.PatientID
	GROUP BY PATIENT.PATIENTID
) as A on A.patientid = patient.patientid 