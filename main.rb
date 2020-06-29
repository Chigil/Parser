require 'open-uri'
require 'nokogiri'
require 'csv'
#require 'curb'
url = "https://www.petsonic.com/croquettes-pour-chats-hills-sp-feline-mature-7-poulet.html"
output_file = "newfile"
html = open( url )
doc = Nokogiri::HTML( html )
name = doc.xpath('//h1[@class = "product_main_name"]').text.strip
price = doc.xpath('//span[@class = "price_comb"]').map(&:text)
wight = doc.xpath('//span[@class = "radio_label"]').map(&:text)
image = doc.xpath('//span[@id = "view_full_size"]/img/@src').text.strip
wight_name = []
full_name = []
if wight.length>0
  wight.each {|x| wight_name << name + "-" + x}
else 
  wight_name<<name
end
puts name
puts price
puts wight
puts image
puts wight_name
puts full_name
CSV.open(output_file+".csv", "wb") do |csv|
 csv << ["Name","Price","Image"]
end
CSV.open(output_file+".csv", "a") do |csv|
  for i in 0..price.length-1
    full_name << wight_name[i] << price[i].gsub(/[^\d\.]/,'') << image
    csv<<full_name
    full_name.clear
  end
end
