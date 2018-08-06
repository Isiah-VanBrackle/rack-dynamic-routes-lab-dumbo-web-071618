# require 'pry'
class Application

  @@items = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      item_name = req.path.split("/items/").last
      #req.path.split("/items/") will return an array where the first element is an empty string and the second is the string of the item we do .last on this to get that string.
      case # i wrote this case statement so that when the above 'if' is true it can have different behaviour inside of itself.
      when product = @@items.find {|p| p.name == item_name}
        #item_name is the string we gathered above i'm simple checking if the name of each item i'm iterating over matches that string.
        resp.write product.price
         resp.status = 200
      when product = @@items.find {|p| p.name != item_name}
        resp.write "Item not found"
        resp.status = 400
      end
      #below is my orriginal attempt, turns out the code never hit this elsif. hence the need for the code above.
    # elsif req.path.match(/items/)
    #   item_name = req.path.split("/items/").last
    #   product = @@items.find {|p| p.name != item_name}
    #   resp.write "Item not found"
    #   resp.status = 400
    else
      resp.write "Route not found"
      resp.status = 404
    end
    resp.finish
  end

  # def item_price(search_term)
  #   if @@items.include?(search_term)
  #     product = @@items.find do |item|
  #       item == search_term
  #     end
  #     resp.write "#{product[-1]}"
  #     resp.status = 200
  #   else
  #     resp.write "Item not found"
  #     resp.status = 400
  #   end
  # end

# binding.pry
end
