## Overview

/*

Fact Table #1 = Health Indicator 
Dimensions = 
Time
Patient
Location




## Todo:
/*


* Possibly Make a Bridge Table for Cohorts (cohorts = groups)
*





*/











CREATE TABLE prd_dw.Health_Indicator_Fact (











)




CREATE TABLE prd_dw.Patient_Dim (




)

/* 

Notes:
I'm going to randomly make the ETL on this one a Stored Procedure Database side. 

*/

CREATE TABLE prd_dw.Encounter_Dim (
	enc_key INT(11),
	enc_id INT(11),
	patient_id INT(11),
	encounter_date DATE,
	provider_name VARCHAR(101),
	data_clerk_name VARCHAR(101),
	date_submitted DATE,
	calculated_age DOUBLE,
	maturity VARCHAR(255),
	maturity_ordinal INT(11),
	age_category VARCHAR(255),
	age_category_ordinal INT(11)
)


CREATE PROCEDURE etlEncounterDim
AS 
BEGIN
	SELECT 
		ENC.Encounter_id,
		ENC.Patient_id,
		ENC.encounter_datetime as encounterdate,
		ENCPROV.provider_id,
		ENC.encounter_datetime as encounterdate,
	--	ENC.calculated_age ,
	--	ENC.maturity, 
	--	ENC.maturity_ordinal,
	--	ENC.age_category,
	--	ENC.age_category_ordinal
		SUBQUERY1.maindoctor as primary_provider
	FROM openmrs.ENCOUNTER as ENC
	INNER JOIN openmrs.ENCOUNTER_PROVIDER as ENCPROV on ENCPROV.Encounter_id = ENC.Encounter_id
	INNER JOIN openmrs.ENCOUNTER_TYPE as ENCTYPE on ENCTYPE.encounter_type_id = ENC.encounter_type
	INNER JOIN openmrs.patient as patient on patient.patient_id = ENC.Patient_id
	LEFT JOIN (
		SELECT
			ENCROLE.ENCOUNTER_ROLE_ID as encounter_role,
			ENCROLE.NAME as maindoctor
			FROM openmrs.encounter_role as ENCROLE 
			INNER JOIN openmrs.ROLE as ROLE on ROLE.Role = ENCROLE.ENCOUNTER_ROLE_ID
			WHERE ROLE = 5 ) as SUBQUERY1 on SUBQUERY1.encounter_role = ENCTYPE.creator
END; 



/*
Notes:
This works.

Todo:
Maybe a recursive function or something based off postal codes. Idk
*/

CREATE TABLE prd_dw.Location_Dim(
	location_key INT(11),
	name VARCHAR(255),
	address1 VARCHAR(50),
	address2 VARCHAR(50),
	city_village VARCHAR(50),
	state_province VARCHAR(50),
	postal_code VARCHAR(50),
	country VARCHAR(50),
	latitude VARCHAR(50),
	longitude (VARCHAR(50),
	creator INT(11),
	date_created DATETIME,
	country_district VARCHAR(50),
	neighborhood_cell VARCHAR(50),
	region VARCHAR(50),
	subregion VARCHAR(50),
	township_division VARCHAR(50),
	retired TINYINT(1),
	retired_by INT(11),
	date_retired DATETIME,
	retire_reason VARCHAR(255),
	parent_location INT(11),
	uuid CHAR(38)
)


SELECT 
LOC.Location_id,
LOC.Name,
LOC.address1,
LOC.address2,
LOC.city_village,
LOC.state_province,
LOC.city_village,
LOC.state_province,
LOC.postal_code,
LOC.country,
LOC.latitude,
LOC.longitude,
LOC.creator,
LOC.date_created,
LOC.county_district,
LOC.retired,
LOC.retired_By,
LOC.date_retired,
LOC.retire_reason,
LOC.parent_location,
LOC.uuid,
SUBQUERY1.preferred_handler as preferred_handler,
SUBQUERY1.sum_location_occurences as sum_location_occurences 
FROM openmrs.LOCATION AS LOC
INNER JOIN openmrs.Location_attribute as LOCATT on LOCATT.location_id = LOC.location_id
LEFT JOIN (
SELECT 
	LOCATTYPE.preferred_handler as preferred_handler,
	LOCATTYPE.name as name,
	SUM(LOCATTYPE.max_occurs) as sum_location_occurences 
	FROM openmrs.location_attribute_type as LOCATTYPE
	INNER JOIN openmrs.location_attribute as locatt1 on locatt1.attribute_type_id = LOCATTYPE.location_attribute_type_id
	GROUP BY LOCATTYPE.name, LOCATTYPE.preferred_handler)
    	AS SUBQUERY1
    ON SUBQUERY1.name = LOC.name 







/* Done */ 

CREATE TABLE prd_dw.Time_Dim (


)







# Patient SQL
/* Incomplete. Figure out how to link Patient and Person tables because it is unclear right now */


SELECT
	Patient.Patient_Id,
	A.AlergyCount,
	Person.Person_id,
	Person.birthdate,
	Person.deathdate,
	Person.gender,

	CASE 
		WHEN
		Person.birthdate <= Person.deathdate 
			THEN 
				'Alive'
		Else
			'Dead'
		End as isDead,
	Person
FROM
	Patient as Patient
INNER JOIN ( 
	SELECT
		COUNT(Allergy.Allergy_ID) as AlergyCount,
		PATIENT.PATIENT_ID
	FROM
		PATIENT as Patient
		INNER JOIN Allergy as Allergy on Allergy.Patient_ID = Patient.Patient_ID
	GROUP BY PATIENT.PATIENT_ID
) as A on A.patient_id = patient.patient_id 


# Location SQL



	