require 'airport'

describe Airport do
  it 'lands a plane' do
    plane = Plane.new
    subject.land(plane)
    expect(subject.land(plane)[-1]).to eq plane
  end
end
