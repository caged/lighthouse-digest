require '/Users/Caged/dev/git/lighthouse-api/lib/lighthouse'
require 'actionmailer'

# Use sendmail
ActionMailer::Base.delivery_method = :sendmail

module Lighthouse
  class Digest
    attr_accessor :project_id, :query
    attr_accessor :emails, :from
    
    def initialize(&block)
      yield self
      process_and_deliver!
    end
    
    def process_and_deliver!
      @project = Project.find(@project_id)
      @tickets = Ticket.find(:all, :params => {:project_id => @project.id, :q => @query})
      
      Notifier.deliver_ticket_digest(html_template, {
        :emails => @emails,
        :from => @from,
        :subject => "[#{@project.name} Digest] #{@tickets.size} tickets: #{@query}",
      })
    end
    
    def html_template
      ticket_url = "#{Lighthouse.domain_format + '/projects/%s/tickets'}" % [Lighthouse.account, @project.id]
      html = [] << "<ul>"
      @tickets.each do |ticket|
        html << %(<li>
          <a href="http://#{ticket_url}/#{ticket.id}">#{ticket.title}</a><br />
          <span style="color:#aaa">#{ticket.updated_at.strftime("%B, %d %I:%M %p")}</span>
        </li>)
      end
      html << "</ul>"      
      
      return %(
        <html>
          <head>
            <title>Lightouse Digest</title>
          </head>
          <body>
            <b>#{@tickets.size}</b> tickets <b>#{@query}</b>
            #{html}
          </body>
        </html>
      )
    end
  end
  
  class Notifier < ActionMailer::Base
    def ticket_digest(body_html, options)
      content_type "text/html"
      recipients options[:emails]
      from options[:from] unless options[:from].nil?
      subject options[:subject]
      body body_html
    end
  end
end

# Set basic Lighthouse info
Lighthouse.account = "activereload"
Lighthouse.token = "3cbb916a2ab680a6f07bcc3aff7a6a5bc22e5b4b"


Lighthouse::Digest.new do |digest|
  digest.project_id = 44
  digest.from = "justin@encytemedia.com"
  digest.query = "state:open updated:'three weeks ago - two weeks ago'"
  digest.emails = "encytemedia@gmail.com, justin@activereload.net"
end