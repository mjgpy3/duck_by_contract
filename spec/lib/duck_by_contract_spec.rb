require './lib/duck_by_contract.rb'

describe DuckByContract do
  subject { extending_class }

  before(:all) do
    class Object
      def ok?; true; end
    end
  end

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

      describe 'an instance of that class' do
        let(:an_instance) { extending_class.new }

        context 'when the duck-typed method is called with an object matching the specified duck type' do
          subject { an_instance.absolute_value(42) }

          it { is_expected.to be_ok }
        end
      end
    end

  end

end
