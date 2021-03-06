require 'airport'

describe Airport do
  let(:plane) { Plane.new }
  describe '#land' do

    it 'does not allow landing if airport is full' do
      allow(subject).to receive(:stormy?) { false }
      subject.capacity.times { subject.land(Plane.new) }
      expect { subject.land(plane) }.to raise_error 'no space in airport'
    end
    it 'cannot land a landed plane' do
      allow(subject).to receive(:stormy?) { false }
      subject.land(plane)
      expect { subject.land(plane) }.to raise_error 'plane is already landed'
    end
    it 'does not allow planes to land when stormy' do
      allow(subject).to receive(:stormy?) { true }
      expect { subject.land(plane) }.to raise_error(RuntimeError, 'plane cannot land in a storm')
    end
  end

  describe '#takeoff' do
    it 'has planes flying after takeoff' do
      allow(subject).to receive(:stormy?) { false }
      subject.land(plane)
      expect(subject.takeoff(plane).flying).to eq true
    end
    it 'does not allow planes to takeoff in stormy weather' do
      # subject.land(plane)
      allow(subject).to receive(:stormy?) { true }
      expect { subject.takeoff(plane) }.to raise_error 'plane cannot takeoff in a storm'
    end
    it 'cannot takeoff a flying plane' do
      expect { subject.takeoff(plane) }.to raise_error 'plane is already flying'
    end
  end

  describe '#at_airport?' do
    it 'says if plane is in airport' do
      allow(subject).to receive(:stormy?) { false }
      subject.land(plane)
      expect(subject.at_airport?(plane)).to eq true
    end
  end

  describe '#stormy' do
    it 'can randomly generate weather conditions' do
      srand(123)
      expect(subject.stormy?).to eq true
    end
  end

end
