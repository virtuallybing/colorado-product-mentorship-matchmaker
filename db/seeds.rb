mentors = [
  { name: 'abe', preferences: %w[abi eve cath ivy jan dee fay bea hope gay] },
  { name: 'bob', preferences: %w[cath hope abi dee eve fay bea jan ivy gay] },
  { name: 'col', preferences: %w[hope eve abi dee bea fay ivy gay cath jan] },
  { name: 'dan', preferences: %w[ivy fay dee gay hope eve jan bea cath abi] },
  { name: 'ed', preferences: %w[jan dee bea cath fay eve abi ivy hope gay] },
  { name: 'fred',preferences: %w[bea abi dee gay eve ivy cath jan hope fay] },
  { name: 'gav', preferences: %w[gay eve ivy bea cath abi dee hope jan fay] },
  { name: 'hal', preferences: %w[abi eve hope fay ivy cath jan bea gay dee] },
  { name: 'ian', preferences: %w[hope cath dee gay bea abi fay ivy jan eve] },
  { name: 'jon', preferences: %w[abi fay jan gay eve bea dee cath ivy hope] }
]

mentees = [
  { name: 'abi', preferences: %w[bob fred jon gav ian abe dan ed col hal] },
  { name: 'bea', preferences: %w[bob abe col fred gav dan ian ed jon hal] },
  { name: 'cath', preferences: %w[fred bob ed gav hal col ian abe dan jon] },
  { name: 'dee', preferences: %w[fred jon col abe ian hal gav dan bob ed] },
  { name: 'eve', preferences: %w[jon hal fred dan abe gav col ed ian bob] },
  { name: 'fay', preferences: %w[bob abe ed ian jon dan fred gav col hal] },
  { name: 'gay', preferences: %w[jon gav hal fred bob abe col ed dan ian] },
  { name: 'hope', preferences: %w[gav jon bob abe ian dan hal ed col fred] },
  { name: 'ivy', preferences: %w[ian col hal gav fred bob abe ed jon dan] },
  { name: 'jan', preferences: %w[ed hal gav abe bob jon col ian fred dan] }
]

mentors.each do |mentor|
  Person.create! name: mentor[:name], is_mentor: true
end

mentees.each do |mentee|
  Person.create! name: mentee[:name], is_mentee: true
end

(mentors + mentees).each do |person|
  person_id = Person.find_by(name: person[:name]).id

  person[:preferences].each_with_index do |preferred_person_name, index|
    preferred_person_id = Person.find_by(name: preferred_person_name).id

    Preference.create! person_id: person_id, preferred_person_id: preferred_person_id, rank: index + 1
  end
end
