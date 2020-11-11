class TimeConversion

    attr_accessor :type
    def initialize(conversion_factors=[60, 60, 24]) 
      @factors = conversion_factors
    end

    def convert(seconds)
      @factors.inject([seconds]) {|result, unitsize|
        result[0,0] = result.shift.divmod(unitsize)
        result
      }
    end

    def format(seconds, type)
        (d,h,m,s) = convert (seconds)
        t = Time.now.strftime('%H:%M:%S')
        case 
        when seconds < 3600
          p "#{t} #{type} #{'%02d' %m} min"
        when seconds >=3600 && seconds <86400 
          p "#{t} #{type} #{h}:#{'%02d' %m}"
        when seconds >=86400 && seconds <172800
            if h == 0
                p "#{t} #{type} #{d} day, #{m} min"
            else
                p "#{t} #{type} #{d} day, #{h}:#{'%02d' %m}"
            end  
        else 
            if h == 0
                p "#{t} #{type} #{d} days, #{m} min"
            else
                p "#{t} #{type} #{d} days, #{h}:#{'%02d' %m}"
            end    
        end
    end

    def display(filename, type)
        begin
            File.foreach( filename ) do |line|   
              if type == "up"
                sec_up = line.split[0].to_f
                format(sec_up, type)
              else
                type == "idle"
                sec_up = line.split[1].to_f
                format(sec_up, type)
              end   
            end
        rescue Exception => e
            puts e.message
            puts "Let's pretend this didn't happen..."
        end

    end
end

convtime = TimeConversion.new
convtime.display('uptime_file.txt', 'up')
convtime.display('uptime_file.txt', 'idle')
