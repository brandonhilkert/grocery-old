module Grocery
  class List
    attr_reader :id

    def initialize
      @id = generate_id
    end

    private

      def generate_id
        Digest::SHA1.hexdigest(Time.now.to_s).split("").take(10).join
      end
  end
end