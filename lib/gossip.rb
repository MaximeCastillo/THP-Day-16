require 'csv'

class Gossip
  attr_accessor :author, :content

  def initialize (author, content)
    @content = content
    @author = author
  end

  def save
    CSV.open("./db/gossip.csv", "ab") do |csv|
      csv << [author, content]
    end
  end

  def self.all
    all_gossips = []
    CSV.read("./db/gossip.csv").each do |csv_line|
      all_gossips << Gossip.new(csv_line[0], csv_line[1])
    end
    return all_gossips
  end

  def self.find (id)
    return Gossip.all[id]
  end

  def self.update (id, editor, edited_content)
    all_gossips = CSV.read("./db/gossip.csv")
      gossip = all_gossips[id]
      gossip[0] = editor
      gossip[1] = edited_content
      CSV.open("./db/gossip.csv", "wb") {|csv| all_gossips.each {|elem| csv << elem} }
    end
end
