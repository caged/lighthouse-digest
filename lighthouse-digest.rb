$:.unshift File.dirname(__FILE__)

require 'rubygems'
require 'actionmailer'
require 'vendor/lighthouse-api/lib/lighthouse'
require 'lib/digest'

# Example script
#
# Set basic Lighthouse info
# Lighthouse.account = "activereload"
# Lighthouse.token = "YOUR PROJECT TOKEN"
# 
# 
# Lighthouse::Digest.new do |digest|
#   digest.project_id = 44
#   digest.from = "foo@email.com"
#   digest.query = "state:open updated:'three weeks ago - two weeks ago'"
#   digest.emails = "foo@email.com, bar@email.com"
# end
#
#
# launchd agent (Ran every monday):
#
# <?xml version="1.0" encoding="UTF-8"?>
# <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
# <plist version="1.0">
# <dict>
#   <key>Label</key>
#   <string>com.lighthouseapp.activereload.digest</string>
#   <key>ProgramArguments</key>
#   <array>
#     <string>ruby</string>
#     <string>/Users/Caged/myscript.rb</string>
#   </array>
#   <key>RunAtLoad</key>
#   <false/>
#   <key>StartCalendarInterval</key>
#   <dict>
#     <key>Hour</key>
#     <integer>0</integer>
#     <key>Minute</key>
#     <integer>0</integer>
#     <key>Weekday</key>
#     <integer>1</integer>
#   </dict>
# </dict>
# </plist>