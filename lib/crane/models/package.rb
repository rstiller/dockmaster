
require "sequel"

module Crane
    
    module Models
        
        Sequel::Model.db.create_table? "packages" do
            
            primary_key :id
            foreign_key :base_image_id, :on_delete => :cascade
            String :name
            String :version
            
        end
        
        class Package < Sequel::Model
            
            many_to_one :baseImage
            
            def to_hash
                
                Crane::objectToHash self
                
            end
            
            def self.from_hash(hash)
                
                Package.new :name => hash["name"],
                    :version => hash["version"]
                
            end
            
        end
        
    end
    
end