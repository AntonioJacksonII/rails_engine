require 'fileutils'

task :seed do
  sh %{ rails db:{drop,create,migrate,seed}}
end
