#Part 2 Simple Selects and Counts
#What are all the types of pokemon that a pokemon can have?
select name from pokemon.types;

#What is the name of the pokemon with id 45?
select * from pokemon.pokemons where id =45;

#How many pokemon are there?
select count(*) from pokemon.pokemons;

#How many types are there?
select count(*) from pokemon.types;

#How many pokemon have a secondary type?
select count(*) from pokemon.pokemons where pokemons.secondary_type IS NOT NULL;

#Part 3: Joins and Groups
#What is each pokemon's primary type?
select t.id,t.name,p.primary_type
from pokemon.types t
join pokemon.pokemons p
on p.primary_type = t.id;

#What is Rufflet's secondary type?
select name
from pokemon.types
where id =
(select secondary_type
from pokemon.pokemons
where name like '%Rufflet%');

#What are the names of the pokemon that belong to the trainer with trainerID 303?
select p.name
from pokemon.pokemons p
inner join pokemon.pokemon_trainer pkt on pkt.pokemon_id = p.id
inner join pokemon.trainers t on t.trainerID = pkt.trainerID
where t.trainerID = 303;

#How many pokemon have a secondary type Poison
select count(*) from pokemon.pokemons where secondary_type =
(select id from pokemon.types where name like '%poison%');

#What are all the primary types and how many pokemon have that type?
select t.name,count(p.primary_type) as CountPokemon
from pokemon.types t
join pokemon.pokemons p
on p.primary_type = t.id group by p.primary_type;


#How many pokemon at level 100 does each trainer with at least
# one level 100 pokemone have? (Hint: your query should not display a trainer
select pkt.pokelevel,count(pkt.trainerID)
from pokemon.pokemon_trainer pkt
left join pokemon.pokemons p on pkt.pokemon_id = p.id
group by pkt.pokelevel having pkt.pokelevel=100;


#How many pokemon only belong to one trainer and no other?
select count(*) as PokemonCount from
(select p.name,count(pkt.trainerID)
from pokemon.pokemons p
inner join pokemon.pokemon_trainer pkt on pkt.pokemon_id = p.id
inner join pokemon.trainers t on t.trainerID = pkt.trainerID
group by p.name having count(*) = 1)src;


#963 is the result of the query above
#Part 4: Final Report
# I am considering to sort by poke level field in the pokemon_trainer table

select p.name as 'Pokemon Name',
t.trainername as 'TrainerName',
pt.pokelevel as 'Level',
ty.name as 'Primary Type',
tys.name as 'Secondary Type'

From pokemon_trainer as pt
left outer join trainers as t on t.trainerID=pt.trainerID
left outer join pokemons AS p on p.id=pt.pokemon_id
left outer join types as ty on p.primary_type= ty.id
left outer join types as tys on p.secondary_type=tys.id
order by pt.pokelevel desc




