require './lib/duck_by_contract.rb'

describe DuckByContract do

  describe 'a class that includes it' do
    let(:simple_including_class) { Class.new { include described_class } }

    it { is_expected.to respond_to(:duck_type) }
  end

end
