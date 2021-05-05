class Pokemon
    attr_accessor :id, :name, :type, :db

    def initialize(row)
        @id = row[:id]
        @name = row[:name]
        @type = row[:type]
        @db = row[:db]
    end

    def self.save(name, type, db)
        sql = <<-SQL
        INSERT INTO pokemon (name, type) 
        VALUES (?, ?)
        SQL

        db.execute(sql, name, type)
    end

    def self.find(id, db)
        sql = <<-SQL
            SELECT * FROM pokemon WHERE id = ?;
            LIMIT 1
        SQL
        pokemon = db.execute(sql, id).flatten
        pokemonHash = { id: id, name: pokemon[1], type: pokemon[2], db: db}
        Pokemon.new(pokemonHash)
    end
end
