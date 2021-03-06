require 'spec_helper'

RSpec.describe Dry::Struct::Setters do
  let(:struct) do
    Class.new(Dry::Struct) do
      attribute :before, Dry::Struct::Setters::Types::String
      include Dry::Struct::Setters
      attribute :after, Dry::Struct::Setters::Types::String
    end
  end

  subject { struct.new(before: 'before', after: 'after') }

  describe 'including Dry::Struct::Setters' do
    it 'defines setters for existing attributes' do
      expect { subject.before = 'new-before' }.to change(subject, :before).from('before').to('new-before')
    end

    it 'dynamically defines setters for attributes defined after the inclusion' do
      expect { subject.after = 'new-after' }.to change(subject, :after).from('after').to('new-after')
    end
  end
end
