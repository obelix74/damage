require 'mini_exiftool'

current_dir = File.expand_path(File.dirname(File.dirname(__FILE__)))
photo = MiniExiftool.new current_dir + '/test.NEF'

tags = {}
photo.tags.sort.each do |tag|
	tags[tag] = photo[tag]
end

p photo.title
photo.description = "This is a test image"
photo.categories = "category1, category2"
photo.keywords = "keyword1, keyword2"

photo.save

File.open current_dir + '/test.NEF.json', 'w' do |file|
	file.write tags.to_json
end
