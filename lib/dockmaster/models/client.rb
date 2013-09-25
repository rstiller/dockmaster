
require "sequel"
require "open3"

module Dockmaster
    
    module Models
        
        require "dockmaster/models/clientGroup"
        
        Sequel::Model.db.create_table? "clients" do
            
            primary_key :id
            String :address
            String :dockerVersion
            Integer :dockerPort
            
        end
        
        class Client < Sequel::Model
            
            many_to_many :clientGroup
            
            def run(command, callback)
                
                input, output, error, waiter = Open3.popen3 "docker -H #{address}:#{dockerPort} #{command}"
                
                Thread.new {
                    
                    consoleOutput = ""
                    consoleError = ""
                    
                    while !output.eof?
                        
                        consoleOutput = consoleOutput + output.gets
                        
                    end
                    
                    while !error.eof?
                        
                        consoleError = consoleError + error.gets
                        
                    end
                    
                    [input, output, error].each do |stream|
                        stream.close
                    end
                    
                    callback.call consoleOutput, consoleError, waiter.value
                    
                }
                
            end
            
        end
        
    end
    
end