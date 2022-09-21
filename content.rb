require 'rspec'

MULTIPLIER = 0.877
@terpenes = {}

def float_to_percentage(float)
  '%.2f' %  (float * 100)
end

def thc_content(content_hash)
  float_to_percentage(content_hash['THC'] + (MULTIPLIER * content_hash['THCA']))
end

def cbd_content(content_hash) 
  float_to_percentage(content_hash['CBD'] + (MULTIPLIER * content_hash['CBDA']))
end

def terp_content(content_hash)
  @terpenes = content_hash.select { |key, value| key.match(/ENE$/) || key.match(/OL$/)  }
  float_to_percentage(@terpenes.values.inject(0, :+))
end

def print_content(content_hash)
  print("THC potential: #{thc_content(content_hash)} CBD potential: #{cbd_content(content_hash)} Terp content: #{terp_content(content_hash)} Terpenes: #{@terpenes.keys.join(",")}")
end

# TEST

describe 'content calculator' do

  before do 
    CONTENT_HASH = {
      'THC' => 0.133565,
      'THCA' => 0.033905,
      'CBD' => 0.01854,
      'CBDA' => 0.055873,
      'LEMONENE' => 0.04000,
      'TERPINEOL' => 0.06600
    }
  end

  context 'thc content' do
    it 'returns the thc content' do
      expect(thc_content(CONTENT_HASH)).to eq('16.33')
    end
  end

  context 'cbd content' do
    it 'returns the cbd content' do
      expect(cbd_content(CONTENT_HASH)).to eq('6.75')
    end
  end

  context 'terp content' do
    it 'returns the terp content' do
      expect(terp_content(CONTENT_HASH)).to eq('10.60')
    end
  end

  context 'print_content' do
    it 'prints' do
      expect { print_content(CONTENT_HASH) }.to output("THC potential: 16.33 CBD potential: 6.75 Terp content: 10.60 Terpenes: LEMONENE,TERPINEOL").to_stdout
    end
  end
end