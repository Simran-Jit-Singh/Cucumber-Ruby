After ('@restApi') do 

 	puts "Killing process in teardown: #{$pid}"
	begin
        status = Process.kill('TERM', $pid)
        status.should ==1
        puts "process was killed = #{status}"
    rescue => ex
        puts "ERROR: Couldn't kill #{$pid}. #{ex.class}=#{ex.message}"
        raise Exception "Couldn't kill #{$pid}"
    end	
end