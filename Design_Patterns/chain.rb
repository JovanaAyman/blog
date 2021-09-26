class Handler
    def next_handler=(handler)
      raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
    end
  
    def handle(request)
      raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
    end
  end
  
  class AbstractHandler < Handler
    attr_writer :next_handler
  
    def next_handler(handler)
      @next_handler = handler
      handler
    end
  
    def handle(request)
      return @next_handler.handle(request) if @next_handler
  
      nil
    end
  end
  
  class MonkeyHandler < AbstractHandler
    def handle(request)
      if request == 'Banana'
        "Monkey: I'll eat the #{request}"
      else
        super(request)
      end
    end
  end
  
  class SquirrelHandler < AbstractHandler
    def handle(request)
      if request == 'Nut'
        "Squirrel: I'll eat the #{request}"
      else
        super(request)
      end
    end
  end
  
  class DogHandler < AbstractHandler
    def handle(request)
      if request == 'MeatBall'
        "Dog: I'll eat the #{request}"
      else
        super(request)
      end
    end
  end

  def client_code(handler)
    ['Nut', 'Banana', 'Cup of coffee'].each do |food|
      puts "\nClient: Who wants a #{food}?"
      result = handler.handle(food)
      if result
        print "  #{result}"
      else
        print "  #{food} was left untouched."
      end
    end
  end
  
  monkey = MonkeyHandler.new
  squirrel = SquirrelHandler.new
  dog = DogHandler.new
  
  monkey.next_handler(squirrel).next_handler(dog)
  
  puts 'Chain: Monkey > Squirrel > Dog'
  client_code(monkey)
  puts "\n\n"
  
  puts 'Subchain: Squirrel > Dog'
  client_code(squirrel)