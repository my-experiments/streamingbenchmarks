action :build do

Chef::Log.info "Building benchmark"

  bash "building_intel_benchmarks" do
    user node['streamingbenchmarks']['user']
    group node['streamingbenchmarks']['group']
     code <<-EOF 
      cd #{node[:streamingbenchmarks][:home]}/src
      mvn clean package
      cp intel-consulting-java/target/intel-consulting-java-0.1-SNAPSHOT-allinone.jar ../bin/intel-bench-streaming.jar
      cp intel-consulting-scala/target/intel-consulting-scala-0.1-SNAPSHOT-allinone.jar ../bin/intel-bench-batch.jar
#      update-alternatives --set java
  EOF
  end


end


action :generate_streaming do

Chef::Log.info "Generating data for streaming benchmark"

  bash "generate_data_streaming_intel_benchmarks" do
    user node['streamingbenchmarks']['user']
    group node['streamingbenchmarks']['group']
     code <<-EOF 
      cd #{node[:streamingbenchmarks][:home]}
      java -jar bin/intel-bench-streaming.jar hu.sztaki.mbalassi.intel.consulting.streaming.KafkaABGenerator conf/benchmark.properties
  EOF
  end


end

action :streaming_tweets do

Chef::Log.info "Running streaming tweets benchmark"

  bash "run_streaming_tweets_intel_benchmarks" do
    user node['streamingbenchmarks']['user']
    group node['streamingbenchmarks']['group']
     code <<-EOF 
      cd #{node[:streamingbenchmarks][:home]}
      /srv/flink/bin/flink run -c hu.sztaki.mbalassi.intel.consulting.streaming.FlinkABTest intel-bench-streaming.jar conf/benchmark.properties
  EOF
  end

end

action :streaming_ab do

Chef::Log.info "Running streaming ab benchmark"

  bash "run_streaming_ab_intel_benchmarks" do
    user node['streamingbenchmarks']['user']
    group node['streamingbenchmarks']['group']
     code <<-EOF 
      cd #{node[:streamingbenchmarks][:home]}

  EOF
  end

end


action :generate_batch do

Chef::Log.info "Generating batch data"

  bash "generate_data_batch_intel_benchmarks" do
    user node['streamingbenchmarks']['user']
    group node['streamingbenchmarks']['group']
     code <<-EOF 
      cd #{node[:streamingbenchmarks][:home]}
      java -jar bin/intel-bench-batch.jar 
  EOF
  end

end


action :batch do

Chef::Log.info "Running batch terasort benchmark"

  bash "run_batch_intel_benchmarks" do
    user node['streamingbenchmarks']['user']
    group node['streamingbenchmarks']['group']
     code <<-EOF 
      cd #{node[:streamingbenchmarks][:home]}
      java -jar bin/intel-bench-batch.jar 
  EOF
  end
end