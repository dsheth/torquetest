namespace :db do 
	desc "deletes and populates users and auctions"
	task :populate => :environment do
		puts "deleting and populating"
#	[Bid, Auction, User].each(&:delete_all)
     Auction.delete_all
	 ActiveRecord::Base.connection.reset_pk_sequence!('auctions')
	
		(1..100).each do |i|
			Auction.new do |a|
				a.name = 'Item_' + i.to_s
				a.expiration = Time.now + 1.year
				puts 'added auction ' + a.name
				a.save
			end	
		end
	end
end