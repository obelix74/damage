require 'mini_exiftool'

current_dir = File.expand_path(File.dirname(File.dirname(__FILE__)))
begin
	id = "/Volumes/Pictures/2010/10/01/DSC_0555_6_7_8_9.tif"
	#id = current_dir + '/test.NEF'
	photo = MiniExiftool.new id
	#photo = MiniExiftool.new 
rescue => exception	
	p exception.backtrace
	raise
end

photo.title = "Test title"
photo.description = "This is a test image"
photo.categories = "category1, category2"
photo.keywords = "keyword1, keyword2"
photo.rating = "5"
photo.save

tags = {}
tags[:id] = id

if photo.tags.empty?
	p "No tags found"
else
	photo.tags.each do |tag|
		tags[tag] = photo[tag]
	end
end

File.open current_dir + '/test.NEF.json', 'w' do |file|
	file.write tags.to_json
end
