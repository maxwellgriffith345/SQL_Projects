/* Normal Join with Equality */

SELECT pet.id, pet.name, pet.age, pet.dead
    FROM pet, person_pet, person
    WHERE
    pet.id =  person_pet.pet_id
    AND person_pet.person_id = person.id
    AND person.first_name = 'Zed';

/* using a sub-select */

SELECT pet.id, pet.name, pet.age, pet.dead
    FROM pet
    WHERE pet.id IN
    (
          SELECT pet.id FROM person_pet, person
          WHERE person_pet.person_id = person.id
          AND person.first_name = 'Zed'
    );
