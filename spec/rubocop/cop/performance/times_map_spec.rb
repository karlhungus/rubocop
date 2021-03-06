# encoding: utf-8

require 'spec_helper'

describe RuboCop::Cop::Performance::TimesMap do
  subject(:cop) { described_class.new }

  before do
    inspect_source(cop, source)
  end

  context '.times.map' do
    context 'with a block' do
      let(:source) { '4.times.map { |i| i.to_s }' }

      it 'registers an offense' do
        expect(cop.offenses.size).to eq(1)
        expect(cop.offenses.first.message).to eq(
          'Use `Array.new` with a block instead of `.times.map`.'
        )
        expect(cop.highlights).to eq(['4.times.map { |i| i.to_s }'])
      end
    end

    context 'with an explicitly passed block' do
      let(:source) { '4.times.map(&method(:foo))' }

      it 'registers an offense' do
        expect(cop.offenses.size).to eq(1)
        expect(cop.offenses.first.message).to eq(
          'Use `Array.new` with a block instead of `.times.map`.'
        )
        expect(cop.highlights).to eq(['4.times.map(&method(:foo))'])
      end
    end

    context 'without a block' do
      let(:source) { '4.times.map' }

      it "doesn't register an offense" do
        expect(cop.offenses).to be_empty
      end
    end
  end

  context '.times.collect' do
    context 'with a block' do
      let(:source) { '4.times.collect { |i| i.to_s }' }

      it 'registers an offense' do
        expect(cop.offenses.size).to eq(1)
        expect(cop.offenses.first.message).to eq(
          'Use `Array.new` with a block instead of `.times.collect`.'
        )
        expect(cop.highlights).to eq(['4.times.collect { |i| i.to_s }'])
      end
    end

    context 'with an explicitly passed block' do
      let(:source) { '4.times.collect(&method(:foo))' }

      it 'registers an offense' do
        expect(cop.offenses.size).to eq(1)
        expect(cop.offenses.first.message).to eq(
          'Use `Array.new` with a block instead of `.times.collect`.'
        )
        expect(cop.highlights).to eq(['4.times.collect(&method(:foo))'])
      end
    end

    context 'without a block' do
      let(:source) { '4.times.collect' }

      it "doesn't register an offense" do
        expect(cop.offenses).to be_empty
      end
    end
  end
end
