$:.unshift '.' 
require 'launcher'

def help
  print "\nYou must pass in the path to the file to launch.\nUsage: #{__FILE__} target_file\n"
end

unless ARGV.size > 0
  help
  exit
end

app_map = {
  html: '/usr/bin/google-chrome-stable',
  rb: '/opt/sublime_text/sublime_text',
  jpg: 'eog',
  yml: '/opt/sublime_text/sublime_text'
}

Launcher.new(app_map).run(*ARGV)
