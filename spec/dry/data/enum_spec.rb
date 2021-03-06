RSpec.describe Dry::Data::Enum do
  subject(:type) { Dry::Data['string'].enum(*values) }

  let(:values) { %w(draft published archived) }
  let(:string) { Dry::Data['strict.string'] }

  it_behaves_like Dry::Data::Type

  it 'allows defining an enum from a specific type' do
    expect(type['draft']).to eql(values[0])
    expect(type['published']).to eql(values[1])
    expect(type['archived']).to eql(values[2])

    expect(type[0]).to be(values[0])
    expect(type[1]).to be(values[1])
    expect(type[2]).to eql(values[2])

    expect(type.values).to eql(values)

    expect { type['oops'] }.to raise_error(Dry::Data::ConstraintError, /oops/)

    expect(type.values).to be_frozen
  end

  it 'aliases #[] as #call' do
    expect(type.call('draft')).to eql(values[0])
    expect(type.call(0)).to eql(values[0])
  end
end
