
require 'sketchup.rb'
require 'extensions.rb'

module Anna
  module Lego_Brick
      ex = SketchupExtension.new('Lego Brick', 'su_myplugin/main')

      ex.description = 'SketchUp Ruby API creating Lego brick'
      ex.version     = '1.0.0'
      ex.copyright   = 'Anna Dabrowska © 2018'
      ex.creator     = 'SketchUp'

      Sketchup.register_extension(ex, true)


  end 
end
