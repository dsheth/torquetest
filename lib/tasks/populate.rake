namespace :db do 
	desc "deletes and populates users and auctions"
	task :populate => :environment do
		puts "deleting and populating"
		[Bid, Auction, User].each(&:delete_all)
		ActiveRecord::Base.connection.reset_pk_sequence!('auctions')
		ActiveRecord::Base.connection.reset_pk_sequence!('users')
		ActiveRecord::Base.connection.reset_pk_sequence!('bids')
	
		(1..100).each do |i|
			Auction.new do |a|
				a.name = 'Item_' + i.to_s
				a.expiration = Time.now + 1.year
				puts 'added auction ' + a.name
				a.save
				inserts = []
				(1..1000).each do |j|
           name = "User_" + j.to_s + "_for_Auction_" + i.to_s
				   stuff_to_insert = "(nextval('users_id_seq'), '" + name + "', '" + name + "@example.com', '$2a$10$lLAiGNS7hYtczhykOrPdc.Lrxy5DbCLg.eB7jwEuyXAjcHnPrHnNy', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)"
				   inserts.push stuff_to_insert
				end
				sql = "INSERT INTO users (id, name, email, password_digest, created_at, updated_at) VALUES #{inserts.join(", ")}"

				Auction.connection.execute sql
			end
		end	
	end
end
