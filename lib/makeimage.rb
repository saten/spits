module Spit
  def makeimage(mtext)
    
    if (mtext.nil? || mtext == "") then return end
    
    # TEST IMAGE MAGICK with RMAGICK
    @clown = Magick::ImageList.new("public/images/framed_clown.jpg")
  	face = @clown.crop(50, 15, 150, 165)
  	white_bg = Magick::Image.new(@clown.columns, @clown.rows)
  	@clown = white_bg.composite(face, 50, 15, Magick::OverCompositeOp)
  	text = Magick::Draw.new
    text.annotate(@clown, 0, 0, 0, 60, mtext) {
        self.gravity = Magick::SouthGravity
        self.pointsize = 48
        self.stroke = 'transparent'
        self.fill = '#0000A9'
        self.font_weight = Magick::BoldWeight
        }

    # LOCAL GREZZO TEST
  	# @clown.write('public/images/example.jpg')
    @clown.format = 'jpeg'
    
    # FIXME : BUT SEEMS TO WORK (WHICH LIB I AM USING? MAH)
    # If you want to upload a StringIO, you’ll need to use an adapter that supports uploading IOs. Typhoeus currently does not. 
    # Pre-1.2, Koala would automatically switch to the Net::HTTP service for you; 
    # with 1.2 and above, you’ll need to set the adapter yourself:
    # Faraday.default_adapter = :net_http 
    
    @clown_id = StringIO.open(@clown.to_blob) do |strio|
      response = @graph.put_picture(strio, "image/jpeg" )
      response['id']
    end
    @picture_url = @graph.get_picture(@clown_id)
    return @picture_url
  end
end