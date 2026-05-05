function suspend-now --wraps='systemctl suspend' --description 'alias suspend-now systemctl suspend'
  systemctl suspend $argv
        
end
