
zk_ip = private_recipe_ip("kzookeeper", "default")
kafka_ip = private_recipe_ip("kkafka", "default")


template "#{node[:streamingbenchmarks][:home]}/bin/consume-kafka.sh" do
  source "consume-kafka.sh.erb"
  owner node[:streamingbenchmarks][:user]
  group node[:streamingbenchmarks][:group]
  mode 0755
  variables({ :zk_ip => zk_ip })
end



  # bash "run_kafka_client_latencies" do
  #   user node['streamingbenchmarks']['user']
  #   group node['streamingbenchmarks']['group']
  #    code <<-EOF 
  #     cd #{node[:kafka][:home]}
  #     nohup bin/kafka-console-consumer.sh --zookeeper #{zk_ip}:2181 --topic flinkabout --from-beginning > /tmp/kafka-flinkabout-latencies.log &
  # EOF
  # end
