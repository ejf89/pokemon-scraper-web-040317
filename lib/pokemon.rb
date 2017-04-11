require 'pry'

class Pokemon
    attr_accessor :id, :name, :type, :db, :hp
    # attr_reader :hp

     @@all = []

    def initialize(id:, name:, type:, hp: nil, db:)
        @id = id
        @name = name
        @type = type
        @db = db
        @hp = hp
    end

    def alter_hp(amount, db)
        @hp = amount
        db.execute("UPDATE pokemon SET hp = ? WHERE id = ?", amount, self.id)
        # binding.pry

    end


    def self.save(name, type, db)
      db.execute("INSERT INTO pokemon (name, type) VALUES (?, ?)",name, type)
    end

    def self.find(id, db)
        ans = db.execute("SELECT * FROM pokemon WHERE id = #{id}").flatten
        returnHash = {id: ans[0], name: ans[1], type: ans[2], hp: ans[3], db: db}
        Pokemon.new(returnHash)
    end
end
