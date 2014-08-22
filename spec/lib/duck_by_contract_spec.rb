require './lib/duck_by_contract.rb'

describe DuckByContract do
  subject { extending_class }

  describe 'a class that extends it' do
    let(:extending_class) { Class.new { extend DuckByContract } }

    it { is_expected.to respond_to(:duck_type) }

    context 'and uses it to duck type a method with one param' do
    end

  end

end
