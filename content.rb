require 'rspec'

MULTIPLIER = 0.877

def print_content(content_hash)
  print("THC potential: #{thc_content(content_hash)} CBD potential: #{cbd_content(content_hash)} Terp content: #{terp_content(content_hash)} Terpenes: #{@terpenes.keys.join(",")}")
end

private

def cannabinoid_content(content_hash, cannabinoid)
  float_to_percentage(content_hash["#{cannabinoid}"] + (MULTIPLIER * content_hash["#{cannabinoid}A"]))
end

def float_to_percentage(float)
  '%.2f' %  (float * 100)
end

def thc_content(content_hash)
  cannabinoid_content(content_hash, 'THC')
end

def cbd_content(content_hash) 
  cannabinoid_content(content_hash, 'CBD')
end

def terp_content(content_hash)
  @terpenes = content_hash.select { |key, value| key.match(/ENE$/) || key.match(/OL$/)  }
  float_to_percentage(@terpenes.values.inject(0, :+))
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

  context 'print_content' do
    it 'prints' do
      expect { print_content(CONTENT_HASH) }.to output("THC potential: 16.33 CBD potential: 6.75 Terp content: 10.60 Terpenes: LEMONENE,TERPINEOL").to_stdout
    end
  end
end