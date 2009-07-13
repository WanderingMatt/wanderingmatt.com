class ColourScheme
  
  @colour_schemes = {
    'black' => {
      :name => 'Black',
      :accent => '00a2ff',
      :background => '202020',
      :h2 => '9a9ea1',
      :h3 => 'c1c6c9',
      :h4 => '4d4f50',
      :h2_link => '99daff',
      :typography => 'cdd1d4',
      :link => 'ccecff',
      :link_border => '323232',
      :header => '797979',
      :header_background => '141414',
      :header_link => 'cdd1d4',
      :border => '4d4d4d',
      :datetime => '4a4a4a',
      :tags => '797979'
    },
    'bleached' => {
      :name => 'Bleached',
      :accent => 'ff5e1d',
      :background => 'd9d5cb',
      :h2 => '2b1f23',
      :h3 => '5f5659',
      :h4 => '8f8d88',
      :h4_strong => '554c4f',
      :link => '66260c',
      :link_border => 'c5c2bb',
      :header => '554c4f',
      :header_background => 'efece6',
      :header_link => '993811',
      :border => '80797b',
      :datetime => '898680',
      :tags => '898680'
    },
    'rich' => {
      :name => 'Rich',
      :accent => 'f2e985',
      :background => '2b0d1f',
      :h2 => '776d73',
      :h2_link => 'c2ba6a',
      :h3 => 'c6c4b0',
      :h4 => '553d4c',
      :h4_strong => '806e79',
      :typography => 'c6c4b0',
      :link => 'f7f2b6',
      :link_border => '1d0b16',
      :link_hover => 'fff',
      :header => '999',
      :header_background => '1a0813',
      :header_link => 'c2ba6a',
      :border => '1a0813',
      :datetime => '523a49',
      :tags => '4a3c45'
    },
    'vintage' => {
      :name => 'Vintage',
      :accent => 'ededed',
      :background => '81a0a0',
      :h2 => 'b7cbcb',
      :h2_link => 'ededed',
      :h3 => 'dddddb',
      :h4 => '678080',
      :h4_strong => '4d6060',
      :typography => 'cfdcdc',
      :link => 'b7cbcb',
      :link_border => '678080',
      :link_hover => 'fff',
      :header => 'bbbbb7',
      :header_background => '4d6060',
      :header_link => 'd7d8d6',
      :border => '455353',
      :datetime => 'b7cbcb',
      :tags => 'cfdcdc'
    }
  }
  
  def self.all
    @colour_schemes
  end
  
  def self.list
    list = []
    @colour_schemes.each { |key, scheme| list << scheme[:name] }
    list
  end
  
end