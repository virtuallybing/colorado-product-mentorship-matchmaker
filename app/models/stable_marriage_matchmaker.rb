class StableMarriageMatchmaker
  def initialize(pool_one, pool_two)
    @primary_participations = pool_one.map { |participant| Participation.new(participant) }.freeze
    @secondary_participations = pool_two.map { |participant| Participation.new(participant) }.freeze
  end

  def run
    while primary_participation = @primary_participations.find(&:unmatched?) do
      secondary_participation = primary_participation.next_participation(@secondary_participations)
      primary_participation.propose_to(secondary_participation)
    end

    @primary_participations.map do |primary_participation|
      {
        primary: primary_participation.participant,
        secondary: primary_participation.current_match.participant,
      }
    end
  end
 
  class Participation
    attr_accessor :current_match
    attr_reader :participant

    def initialize participant
      @participant = participant
      @current_match = nil
      @proposals = []
    end

    def unmatch
      @current_match = nil
    end

    def unmatched?
      @current_match == nil
    end

    def match_to participation
      @current_match = participation
      participation.current_match = self
    end

    def better_choice? potential_match 
      rank(potential_match) < rank(@current_match)
    end

    def propose_to participation
      @proposals << participation
      participation.respond_to_proposal_from(self)
    end

    def respond_to_proposal_from participation
      if unmatched?
        match_to participation
      elsif better_choice?(participation)
        @current_match.unmatch
        match_to(participation)
      end
    end

    def rank participation
      @participant.rank_of(participation.participant.id)
    end

    def next_participation participations
      potential_participations = participations.reject { |participantion| @proposals.include?(participantion) }
      potential_participations.sort_by { |participation| rank(participation) }.first
    end
  end
end
