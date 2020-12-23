/*
SELECT * FROM person_pet
WHERE purchased_on > date('1990-01-01')
AND purchased_on < date ('2000-01-01')
ORDER BY purchased_on;
*/

SELECT pet.name, pet.breed, person_pet.purchased_on, pet.age
FROM person_pet, pet
WHERE pet.id = person_pet.pet_id
AND person_pet.purchased_on > date('1990-01-01')
AND person_pet.purchased_on < date('2000-01-01')
ORDER BY person_pet.purchased_on, pet.age;
