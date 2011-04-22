xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "#{@user.name}'s Jots"
    xml.description "My Followed Jots"
    xml.link jots_url

    for jot in @jots
      xml.item do
        xml.title jot.title
        xml.description jot.content
        xml.pubDate jot.updated_at.to_s(:rfc822)
        xml.link course_jot_url(jot.course_id, jot)
        xml.guid course_jot_url(jot.course_id, jot)
      end
    end
  end
end