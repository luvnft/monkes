###
#  to run use:
#    $ ruby sandbox/sketch.rb


require 'monkes21'


specs = read_csv( "./monkes21.csv" )
puts "   #{specs.size} record(s)"



## note: 57px = 28px*2+1 
composite = ImageComposite.new( 10, 10, width: 57, height: 57 )

specs[0,1000].each_with_index do |rec, i|
    base        = rec['type']
    accessories = (rec['accessories'] || '' ).split( '/').map { |acc| acc.strip }
    background  = rec['background']
    
    ## note: skip background
    spec = [base] + accessories

    img = Monke21::Image.generate( *spec ).sketch( 1, line: 1)
     
    num = "%05d" % i
    puts "==> monke #{num}"
    img.save( "./tmp/sketch/monke#{num}.png" )
    img.zoom(8).save( "./tmp/sketch/i@4x/monke#{num}@4x.png" )
    
    composite << img    if i < 100
end

composite.save( "./tmp/sketches.png" )



puts "bye"