#!/usr/bin/env ruby
#API hooks
require 'sketchup.rb'
#Ruby consol for errors
SKETCHUP_CONSOLE.show


#Menu
module Anna
    module Lego_Brick
        menu = UI.menu("Plugins").add_item("Lego brick creator"){
            # Create the input box
            prompts = ["Rows", "Columns"]
            defaults = ["2", "1"]
            results = UI.inputbox prompts, defaults, "Lego plugin"

            #calling methods
            self.draw_brick(results[0],results[1])
        }

        # Command object
        basic_cmd = UI::Command.new("Lego") {
                # Create the input box
                prompts = ["Rows", "Columns"]
                defaults = ["2", "1"]
                results = UI.inputbox prompts, defaults, "Lego plugin"
            
                #calling methods
                self.draw_brick(results[0],results[1])
        }
            basic_cmd.small_icon = "Lego-icon.png"
            basic_cmd.large_icon = "Lego-icon.png"   
            basic_cmd.tooltip = "Basic Toolbar Entry"
        #Toolbar
        basic_toolbar = UI::Toolbar.new "Lego"
        basic_toolbar.add_item basic_cmd
        basic_toolbar.show

        def self.draw_brick(s1,s2)
            row = s1.to_i
            col = s2.to_i
            width = 20.cm
            height = 24.cm
            segments = 32
            model = Sketchup.active_model
            entities = model.active_entities

            #segments on top
            for i in 0..(col-1)
                for j in 0..(row-1)
                    center_point = Geom::Point3d.new(10.cm + (i*width),10.cm + (j*width),height)
                    normal_vector = Geom::Vector3d.new(0,0,1.cm)
                    radius = 6.cm
                    
                    edges=entities.add_circle(center_point, normal_vector, radius, segments)
                    face = entities.add_face(edges) 
                    face.pushpull(4.cm)
                end
            end

            #outside rectangle
            new_face1 = entities.add_face([0,0,0],
                                          [width*col,0,0],
                                          [width*col,width*row,0],
                                           [0,width*row,0])
            new_face1.reverse!
            new_face1.pushpull(24.cm)
            #inside rectangle
            new_face2 = entities.add_face([4.cm,4.cm,20.cm],
                                            [width*col-4.cm,4.cm,20.cm],
                                            [width*col-4.cm,width*row-4.cm,20.cm],
                                            [4.cm,width*row-4.cm,20.cm])
            new_face2.pushpull(-20.cm)
            #reverse face on top
            new_face3 = entities.add_face([0,0,24.cm],
                                        [width*col,0,24.cm],
                                        [width*col,width*row,24.cm],
                                        [0,width*row,24.cm])
            new_face3.reverse!
        end
    end
end