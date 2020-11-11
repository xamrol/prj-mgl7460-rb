require 'rspec'
require_relative '../lib/uptime.rb'

describe TimeConversion do
  before { @testtime = TimeConversion.new }

  it "should convert seconds less than 3600 correctly" do
  	expect(@testtime.convert(3500)).to match_array([0, 0, 58, 20]) 
  end
  
  it "should convert seconds less than 1 day correctly" do
    expect(@testtime.convert(83500)).to match_array([0, 23, 11, 40])
  end

  it "should convert seconds less than 2 days correctly" do
    expect(@testtime.convert(163500)).to match_array([1, 21, 25, 0])
  end

  it "should convert seconds more than 2 days correctly" do
    expect(@testtime.convert(463859)).to match_array([5, 8, 50, 59])
  end

  it "should display uptime1 correctly" do
    expect(@testtime.format(3500, 'up')).to include("up 58 min")
  end
  
  it "should display uptime2 correctly" do
    expect(@testtime.format(83500, 'up')).to include("up 23:11")
  end

  it "should display uptime3 correctly" do  
    expect(@testtime.format(87000, 'up')).to include("up 1 day, 10 min")     
  end

  it "should display uptime4 correctly" do  
    expect(@testtime.format(163500, 'up')).to include("up 1 day, 21:25")
  end

  it "should display uptime5 correctly" do  
    expect(@testtime.format(173000, 'up')).to include("up 2 days, 3 min")
  end

  it "should display uptime6 correctly" do   
    expect(@testtime.format(463500, 'up')).to include("up 5 days, 8:45")    
  end  

  it "should display idle1 correctly" do
    expect(@testtime.format(3500, 'idle')).to include("idle 58 min")
  end

  it "should display idle2 correctly" do     
    expect(@testtime.format(83500, 'idle')).to include("idle 23:11")
  end

  it "should display idle3 correctly" do    
    expect(@testtime.format(87000, 'idle')).to include("idle 1 day, 10 min")
  end
  
  it "should display idle4 correctly" do     
    expect(@testtime.format(163500, 'idle')).to include("idle 1 day, 21:25")
  end

  it "should display idle5 correctly" do
    expect(@testtime.format(173000, 'idle')).to include("idle 2 days, 3 min")
  end

  it "should display idle6 correctly" do  
    expect(@testtime.format(463500, 'idle')).to include("idle 5 days, 8:45")    
  end

end