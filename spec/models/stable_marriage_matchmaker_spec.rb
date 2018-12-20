require 'rails_helper'

class TestParticipant
  attr_reader :id, :preferences, :name

  def initialize(name, preferences)
    @id = name
    @name = name
    @preferences = preferences.freeze
  end

  def rank_of(other)
    @preferences.find_index(other)
  end
end

POOL_ONE = [
  TestParticipant.new('Abe', %w[Abbi Eve Cathy Ivy Jan Dee Fay Betty Hope Geraldine]),
  TestParticipant.new('Bob', %w[Cathy Hope Abbi Dee Eve Fay Betty Jan Ivy Geraldine]),
  TestParticipant.new('Col', %w[Hope Eve Abbi Dee Betty Fay Ivy Geraldine Cathy Jan]),
  TestParticipant.new('Dan', %w[Ivy Fay Dee Geraldine Hope Eve Jan Betty Cathy Abbi]),
  TestParticipant.new('Ed', %w[Jan Dee Betty Cathy Fay Eve Abbi Ivy Hope Geraldine]),
  TestParticipant.new('Fred', %w[Betty Abbi Dee Geraldine Eve Ivy Cathy Jan Hope Fay]),
  TestParticipant.new('Gavin', %w[Geraldine Eve Ivy Betty Cathy Abbi Dee Hope Jan Fay]),
  TestParticipant.new('Hal', %w[Abbi Eve Hope Fay Ivy Cathy Jan Betty Geraldine Dee]),
  TestParticipant.new('Ian', %w[Hope Cathy Dee Geraldine Betty Abbi Fay Ivy Jan Eve]),
  TestParticipant.new('Jon', %w[Abbi Fay Jan Geraldine Eve Betty Dee Cathy Ivy Hope]),
]

POOL_TWO = [
  TestParticipant.new('Abbi', %w[Bob Fred Jon Gavin Ian Abe Dan Ed Col Hal]),
  TestParticipant.new('Betty', %w[Bob Abe Col Fred Gavin Dan Ian Ed Jon Hal]),
  TestParticipant.new('Cathy', %w[Fred Bob Ed Gavin Hal Col Ian Abe Dan Jon]),
  TestParticipant.new('Dee', %w[Fred Jon Col Abe Ian Hal Gavin Dan Bob Ed]),
  TestParticipant.new('Eve', %w[Jon Hal Fred Dan Abe Gavin Col Ed Ian Bob]),
  TestParticipant.new('Fay', %w[Bob Abe Ed Ian Jon Dan Fred Gavin Col Hal]),
  TestParticipant.new('Geraldine', %w[Jon Gavin Hal Fred Bob Abe Col Ed Dan Ian]),
  TestParticipant.new('Hope', %w[Gavin Jon Bob Abe Ian Dan Hal Ed Col Fred]),
  TestParticipant.new('Ivy', %w[Ian Col Hal Gavin Fred Bob Abe Ed Jon Dan]),
  TestParticipant.new('Jan', %w[Ed Hal Gavin Abe Bob Jon Col Ian Fred Dan]),
]

describe StableMarriageMatchmaker, "#match_couples" do
  it "correctly matches up participants" do
    matchmaker = StableMarriageMatchmaker.new(POOL_ONE, POOL_TWO)
    couples = matchmaker.run.map do |coupling|
      [ coupling[:primary].name, coupling[:secondary].name ]
    end

    expect(couples).to eq(
      [
        ['Abe', 'Ivy'],
        ['Bob', 'Cathy'],
        ['Col', 'Dee'],
        ['Dan', 'Fay'],
        ['Ed', 'Jan'],
        ['Fred', 'Betty'],
        ['Gavin', 'Geraldine'],
        ['Hal', 'Eve'],
        ['Ian', 'Hope'],
        ['Jon', 'Abbi'],
      ]
    )
  end
end
