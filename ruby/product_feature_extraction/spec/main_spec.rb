require 'spec_helper.rb'

describe FeatureExtractor do
  subject {FeatureExtractor.new}

  describe '#extract_colour' do
    it 'should find the colour features in a product' do
      expect(subject.extract_colour[0][:colour]).to eq(['purple'])
      expect(subject.extract_colour[1][:colour]).to eq(['purple'])
      expect(subject.extract_colour[2][:colour]).to eq(['purple', 'black'])
      expect(subject.extract_colour[3][:colour]).to eq(['blue'])
    end

    it 'should only set unique colours' do
      expect(subject.extract_colour[1][:colour]).to eq(['purple'])
    end
    it 'should not set color for when no match' do
      subject.products = [{ title: "there is no match" }]
      expect(subject.extract_colour[0][:colour]).to be nil
    end
  end

  describe '#extract_size' do
    it 'should find the size feature of a product' do
      subject.products = [{ title: "LG 47-inch LED IPS Panel TV - 47LB6000 HDTV" },
                          { title: "LG 47 inch LED IPS Panel TV - 47LB6000 HDTV" },
                          { title: "LG 47\" LED IPS Panel TV - 47LB6000 HDTV" },
                          { title: "LG 47inch LED IPS Panel TV - 47LB6000 HDTV" },
                          { title: "LG 47inch 47' - 47LB6000 HDTV" },
                          { title: "LG 47in LED IPS Panel TV - 47LB6000 HDTV" },
                          { title: "LG 47 inches LED IPS Panel TV - 47LB6000 HDTV" },
      ]
      expect(subject.extract_size[0][:size]).to eq(['47 inch'])
      expect(subject.extract_size[1][:size]).to eq(['47 inch'])
      expect(subject.extract_size[2][:size]).to eq(['47 inch'])
      expect(subject.extract_size[3][:size]).to eq(['47 inch'])
      expect(subject.extract_size[4][:size]).to eq(['47 inch'])
      expect(subject.extract_size[5][:size]).to eq(['47 inch'])
    end
    describe '#extract_memory' do
      it 'should extract the memory of a prduct' do
        subject.products = [{ title: "VisionTek Radeon R7 260X 2GB GDDR5 PCI Express 3.0" },
                            { title: "VisionTek Radeon R7 260X 5 GB GDDR5 PCI Express 3.0" }]
        expect(subject.extract_memory[0][:memory]).to eq(['2 gb'])
        expect(subject.extract_memory[1][:memory]).to eq(['5 gb'])
      end
    end
  end
end
