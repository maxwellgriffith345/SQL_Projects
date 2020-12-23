select person.first_name, pet.breed, pet.dead, count (dead)
from person, pet ,person_pet
where person.id = person_pet.person_id
and pet.id = person_pet.pet_id
group by pet.breed, pet.dead;
