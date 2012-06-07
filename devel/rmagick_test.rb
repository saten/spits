require 'RMagick'

# TEST SPITS
frame = Magick::ImageList.new

5.times { frame.read("template.jpg") }

puts "   Format: #{frame.format}"
puts "   Geometry: #{frame.columns}x#{frame.rows}"
puts "   Class: " + case frame.class_type
                        when Magick::DirectClass
                            "DirectClass"
                        when Magick::PseudoClass
                            "PseudoClass"
                    end
puts "   Depth: #{frame.depth} bits-per-pixel"
puts "   Colors: #{frame.number_colors}"
puts "   Filesize: #{frame.filesize}"
puts "   Resolution: #{frame.x_resolution.to_i}x#{frame.y_resolution.to_i} "+
    "pixels/#{frame.units == Magick::PixelsPerInchResolution ?
    "inch" : "centimeter"}"

puts "Montage images..."

mymontage = frame.montage {
  self.geometry = "#{frame.columns}x#{frame.rows}+4+2"
  self.tile = "5x1"
}

mymontage.write("output.jpg")

puts "   MONTAGE"
puts "   Format: #{mymontage.format}"
puts "   Geometry: #{mymontage.columns}x#{mymontage.rows}"
puts "   Class: " + case mymontage.class_type
                        when Magick::DirectClass
                            "DirectClass"
                        when Magick::PseudoClass
                            "PseudoClass"
                    end
puts "   Depth: #{mymontage.depth} bits-per-pixel"
puts "   Colors: #{mymontage.number_colors}"
puts "   Filesize: #{mymontage.filesize}"
puts "   Resolution: #{mymontage.x_resolution.to_i}x#{mymontage.y_resolution.to_i} "+
    "pixels/#{mymontage.units == Magick::PixelsPerInchResolution ?
    "inch" : "centimeter"}"