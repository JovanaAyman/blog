class Singleton
    attr_reader :value
  
    @instance_mutex = Mutex.new
  
    private_class_method :new
  
    def initialize(value)
      @value = value
    end
  
    # The static method that controls the access to the singleton instance.
    def self.instance(value)
      return @instance if @instance
  
      @instance_mutex.synchronize do
        @instance ||= new(value)
      end
  
      @instance
    end

    def some_business_logic
      # ...
    end
  end
  
  def test_singleton(value)
    singleton = Singleton.instance(value)
    puts singleton.value
  end

  puts "If you see the same value, then singleton was reused (yay!)\n"\
       "If you see different values, then 2 singletons were created (booo!!)\n\n"\
       "RESULT:\n"
  
  process1 = Thread.new { test_singleton('FOO') }
  process2 = Thread.new { test_singleton('BAR') }
  process1.join
  process2.join