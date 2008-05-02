## Lighthouse Digest

Use this with launchd to create digest emails for Lighthouse tickets.
Example uses:

* Send a summary of stale tickets to members on your team every week.
* Get daily summaries of tickets created that day
* Get daily summaries of tickets closed that day

<pre><code>
# Set basic Lighthouse info
# Your lighthouse account name
Lighthouse.account = "activereload"

# Your API Key for this particular project
Lighthouse.token = "YOUR TOKEN"


Lighthouse::Digest.new do |digest|
  digest.project_id = 44 # Lighthouse project id
  digest.from = "you@someemail.com" # optional
  digest.query = "state:open updated:'three weeks ago - two weeks ago'" # Any valid Lighthouse search
  digest.emails = "foo@email.com, bar@email.com" # Who to send this digest too
end
</code></pre>

Here is a typical launchd script to email you once a week. Place this in ~/Library/LaunchAgents/com.lighthouseapp.project.digest.


<pre><code>
&lt;?xml version=&quot;1.0&quot; encoding=&quot;UTF-8&quot;?&gt;
&lt;!DOCTYPE plist PUBLIC &quot;-//Apple//DTD PLIST 1.0//EN&quot; &quot;http://www.apple.com/DTDs/PropertyList-1.0.dtd&quot;&gt;
&lt;plist version=&quot;1.0&quot;&gt;
&lt;dict&gt;
	&lt;key&gt;Label&lt;/key&gt;
	&lt;string&gt;com.lighthouseapp.activereload.digest&lt;/string&gt;
	&lt;key&gt;ProgramArguments&lt;/key&gt;
	&lt;array&gt;
		&lt;string&gt;ruby&lt;/string&gt;
		&lt;string&gt;/Users/Caged/myscript.rb&lt;/string&gt;
	&lt;/array&gt;
	&lt;key&gt;RunAtLoad&lt;/key&gt;
	&lt;false/&gt;
	&lt;key&gt;StartCalendarInterval&lt;/key&gt;
	&lt;dict&gt;
		&lt;key&gt;Hour&lt;/key&gt;
		&lt;integer&gt;0&lt;/integer&gt;
		&lt;key&gt;Minute&lt;/key&gt;
		&lt;integer&gt;0&lt;/integer&gt;
		&lt;key&gt;Weekday&lt;/key&gt;
		&lt;integer&gt;1&lt;/integer&gt;
	&lt;/dict&gt;
&lt;/dict&gt;
&lt;/plist&gt;
</code></pre>

### Load it
<pre><code>launchctl load ~/Library/LaunchAgents/com.lighthouseapp.PROJECT.digest</code></pre>

### Test it using the label you give it in the plist
<pre><code>launchctl start com.lighthouseapp.PROJECT.digest</code></pre>

### Stopping it
If you want to stop this script for good, unload it:
<pre><code>launchctl unload ~/Library/LaunchAgents/com.lighthouseapp.PROJECT.digest</code></pre>

