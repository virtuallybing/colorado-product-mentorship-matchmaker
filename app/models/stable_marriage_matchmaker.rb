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

    def id
      @person.id
    end

    def name
      @person.name
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
      @proposals << participation.id
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
      @person.rank_of(participation.person.id)
    end

    def next_participation participations
      potential_participations = participations.reject { |participantion| @proposals.include?(participantion.id) }
      potential_participations.sort_by { |participation| rank(participation) }.first
    end
  end
end
