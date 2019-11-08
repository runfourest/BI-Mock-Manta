SELECT
	Patient.Patient_Id,
	A.AlergyCount,
	Person.Person_id,
	Person.birthdate,
	Person.death_date,
	Person.gender,

	CASE 
		WHEN
		Person.birthdate >= Person.death_date 
		THEN 
				'Alive'
		ELSE
				'Dead'
		End as isDead
	
FROM
	openmrs.Patient as Patient
INNER JOIN openmrs.patient_identifier as pid on pid.patient_id = patient.patient_id
INNER JOIN openmrs.person as person on person.person_id = pid.uuid
INNER JOIN ( 
	SELECT
		COUNT(Allergy.Allergy_ID) as AlergyCount,
		PATIENT.PATIENT_ID
	FROM
		openmrs.PATIENT as Patient
		INNER JOIN openmrs.Allergy as Allergy on Allergy.Patient_ID = Patient.Patient_ID
	GROUP BY PATIENT.PATIENT_ID
) as A on A.patient_id = patient.patient_id