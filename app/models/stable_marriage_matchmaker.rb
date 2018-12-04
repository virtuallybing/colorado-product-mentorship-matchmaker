class StableMarriageMatchmaker
  def initialize mentees, mentors
    @mentees = mentees
    @mentors = mentors
  end

  def match_couples
    mentee_participations = @mentees.map { |mentee| Participation.new mentee }
    mentor_participations = @mentors.map{ |mentor| Participation.new mentor }

    while mentee_participation = mentee_participations.find {|mentee_participation| mentee_participation.unmatched?} do
      mentor_participation = mentee_participation.next_participation(mentor_participations)
      mentee_participation.propose_to(mentor_participation)
    end

    mentee_participations.map { |mentee_participation| [mentee_participation.person.name, mentee_participation.match.person.name] }
  end
 
  class Participation
    attr_accessor :match
    attr_reader :person

    def initialize person
      @person = person
      @match = nil
      @proposals = []
    end

    def free
      @match = nil
    end
   
    def unmatched?
      @match == nil
    end
   
    def engage participation
      @match = participation
      participation.match = self
    end
   
    def better_choice? participation
      rank(participation) < rank(@match)
    end
   
    def propose_to participation
      @proposals << participation
      participation.respond_to_proposal_from(self)
    end
   
    def respond_to_proposal_from participation
      if unmatched?
        engage participation
      elsif better_choice?(participation)
        @match.free
        engage(participation)
      end
    end

    def rank participation
      @person.preferences.find_by(preferred_person_id: participation.person.id).rank
    end

    def next_participation participations
      preference = @person.preferences.order(rank: :asc).find do |preference|
        participation = participations.find { |participation| participation.person.id == preference.preferred_person_id }
        not @proposals.include?(participation)
      end

      participations.find { |participation| participation.person.id == preference.preferred_person_id }     
    end
  end
end
