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