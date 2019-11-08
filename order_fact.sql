
/*

Select * from openmrs.concept;
Select * from openmrs.orders;
select * from openmrs.order_frequency;
select * from openmrs.order_type;
select * from openmrs.encounter;
select * from openmrs.person;
select * from openmrs.patient


*/

CREATE TABLE Order_History_Fact_Stg(
OrderID int,
OrderDate DateTime,
PatientId int,
EncounterID int, 
LocationId Int,
ConceptShortName Varchar(100)
)

CREATE TABLE Order_History_Fact(
Orderkey int,
DateKey int, 
Patientkey int,
Encounterkey int,
Locationkey int,
urgencyfact int,
fulfillmentfact int,
conceptshortname VARCHAR(200));







Select
	orders.ORDER_ID as orderid,
	CONCEPT.SHORT_NAME as shortname,
	patient.patient_id as patientid,
	CASE 

	

FROM openmrs.orders as Orders 
Inner Join openmrs.concept as concept on orders.concept_id = concept.concept_id
Inner Join openmrs.encounter as enc on enc.encounter_id = orders.encounter_id
Inner Join openmrs.order_frequency as ordfreq on concept.concept_id = ordfreq.concept_id
Inner Join openmrs.patient as pat on pat.patient_id on orders.order_id;


































Select
	orders.ORDER_ID as orderid,
	CONCEPT.SHORT_NAME as shortname,
	patient.patient_id as patientid,


	

FROM openmrs.orders as Orders 
Inner Join openmrs.concept as concept on orders.concept_id = concept.concept_id
Inner Join openmrs.encounter as enc on enc.encounter_id = orders.encounter_id
Inner Join openmrs.order_frequency as ordfreq on concept.concept_id = ordfreq.concept_id
Inner Join openmrs.patient as pat on pat.patient_id on orders.order_id;
Inner Join openmrs.order_type as otype on otype.uuid = orders.uuid 
Inner Join openmrs.






Select * from openmrs.concept;
Select * from openmrs.orders;
select * from openmrs.order_frequency;
select * from openmrs.order_type;
select * from openmrs.encounter;
select * from openmrs.person;
select * from openmrs.patient;
select * from openmrs.order_set;




