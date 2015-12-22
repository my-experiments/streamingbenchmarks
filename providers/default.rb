action :build do

Chef::Log.info "Building benchmark"

   bash "set_java8" do
    user "root"
     code <<-EOF 
#     update-alternatives --set java /usr/lib/jvm/java-8-oracle-amd64/bin/java
      mkdir /opt/kafka/logs
      chown -R flink /opt/kafka/logs
     EOF
  end

   zk_ip = "#{new_resource.zk_ip}"   
   bash "create_topics" do
    user "kafka"
     code <<-EOF 

     #{node[:kafka][:install_dir]}/bin/kafka-create-topic.sh --zookeeper #{zk_ip}:2181 --replica #{node[:streamingbenchmarks][:replicasTweets]} --partition #{node[:streamingbenchmarks][:partitionsTweets]} --topic tweets

     #{node[:kafka][:install_dir]}/bin/kafka-create-topic.sh --zookeeper #{zk_ip}:2181 --replica #{node[:streamingbenchmarks][:replicasAB]} --partition #{node[:streamingbenchmarks][:partitionsAB]} --topic ab       
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

# /opt/kafka/bin/kafka-create-topic.sh --zookeeper #{zk_ips}:2181 --replica 1 --partition 1 --topic test

  bash "run_batch_intel_benchmarks" do
    user node['streamingbenchmarks']['user']
    group node['streamingbenchmarks']['group']
     code <<-EOF 
      cd #{node[:streamingbenchmarks][:home]}
      java -jar bin/intel-bench-batch.jar 
  EOF
  end
end
