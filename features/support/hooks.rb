#Start the service before the Scenario Executes. This hook is invoked before scenario execution starts.
Before do |scenario|
    puts "Starting the service on port 6001"
    path = File.expand_path File.dirname(__FILE__)
    command = "ruby #{path}/actions.rb"
    $pid  = spawn(command)
    Process.detach($pid)
    sleep(3)
end


#Terminate the service after Scenario Completion.
After  do |scenario|
    puts "Killing process in teardown: #{$pid}"
    begin
        $pid.should_not be_nil
        status = Process.kill('TERM', $pid)
        status.should ==1
        puts "process was killed = #{status}"
    rescue => ex
        puts "ERROR: Couldn't kill #{$pid}. #{ex.class}=#{ex.message}"
        raise
    end
end    