require './lib/duck_by_contract.rb'

describe DuckByContract do
  subject { extending_class }

  before(:each) { allow(Object).to receive(:ok?).and_return(true) }

  describe 'a class that extends it' do
    let(:extending_class) { Class.new { extend DuckByContract } }

    it { is_expected.to respond_to(:duck_type) }

    context 'and uses it to duck type a method with one param' do

      let(:extending_class) do
        Class.new do
          extend DuckByContract

          def absolute_value(number)
            number.abs
          end

          duck_type absolute_value: [:abs]
        end
      end

      it { is_expected.to be_ok }
    end

  end

end
