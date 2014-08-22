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

      context 'that has multiple duck methods' do
        let(:extending_class) do
          Class.new do
            extend DuckByContract

            def absolute_value(number)
              number + number.abs
            end

            duck_type absolute_value: [:abs, :+]
          end
        end

        it { is_expected.to be_ok }

        describe 'an instance of that class' do
          let(:an_instance) { extending_class.new }

          context 'when the duck-typed method is called' do
            subject { an_instance.absolute_value(value) }

            context 'and the passed object meets neither of the duck typed methods' do
              let(:value) { Object.new }

              specify { expect { subject }.to raise_error(DuckByContract::NotADuck) }
            end

            context 'and the passed object meets only one of the duck typed methods' do
              let(:value) { Class.new { def abs; end }.new }

              specify { expect { subject }.to raise_error(DuckByContract::NotADuck) }
            end

            context 'and the passed object meets all of the duck typed methods' do
              let(:value) { 42 }

              it { is_expected.to be_ok }
              it 'returns the calculated result' do
                expect(subject).to be(84)
              end
            end
          end
        end
      end

      context 'that has one duck method' do
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

          context 'when the duck-typed method is called' do
            subject { an_instance.absolute_value(value) }

            context 'and the passed object meets the specified duck type' do
              let(:value) { -42 }

              it { is_expected.to be_ok }

              it 'returns the calculated result' do
                expect(subject).to be(42)
              end
            end

            context 'and the passed object does not meed the specified duck type' do
              let(:value) { "foobar" }

              specify { expect { subject }.to raise_error(DuckByContract::NotADuck) }
            end
          end
        end
      end
    end
  end
end
