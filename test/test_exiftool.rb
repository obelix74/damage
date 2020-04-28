require 'mini_exiftool'

current_dir = File.expand_path(File.dirname(File.dirname(__FILE__)))
begin
	#photo = MiniExiftool.new "/Volumes/Pictures/2010/10/01/DSC_0555_6_7_8_9.tif"
	photo = MiniExiftool.new current_dir + '/test.NEF'
rescue => exception	
	p exception.backtrace
	raise
end

tags = {}

if photo.tags.empty?
	p "No tags found"
else
	photo.tags.each do |tag|
		tags[tag] = photo[tag]
	end
end

p photo.title
photo.description = "This is a test image"
photo.categories = "category1, category2"
photo.keywords = "keyword1, keyword2"
photo.rating = "5"
photo.save

File.open current_dir + '/test.NEF.json', 'w' do |file|
	file.write tags.to_json
end
