

# script 'run_experiment' do
#   cwd "/tmp"
#   user node['streamingbenchmarks']['user']
#   group node['streamingbenchmarks']['group']
#   interpreter "bash"
#   code <<-EOM
# java -cp intel-consulting-scala/target/intel-consulting-scala-0.1-SNAPSHOT-allinone.jar hu.sztaki.mbalassi.intel.consulting.als.generator.RandomSparseMatrixGen --numStores #{node.streamingbenchmarks.numStores} --numCustomers #{node.streamingbenchmarks.Customers} --output hdfs://#{node.hadoop.nn.private_ips[0]}:8020/User/flink
#   EOM
# end

zk_ip = private_recipe_ip("kzookeeper", "default")
kafka_ip = private_recipe_ip("kkafka", "default")
spark_master = private_recipe_ip("spark", "master")

template "#{node[:streamingbenchmarks][:home]}/conf/benchmark.properties" do
  source "benchmark.properties.erb"
  owner node[:streamingbenchmarks][:user]
  group node[:streamingbenchmarks][:group]
  mode 0755
  variables({ :zk_ip => zk_ip,
              :kafka_ip => kafka_ip,
              :spark_master => spark_master
  })
end


streamingbenchmarks "tweets" do
  action :build
end

template "#{node[:streamingbenchmarks][:home]}/bin/streaming-generate.sh" do
  source "streaming-generate.sh.erb"
  owner node[:streamingbenchmarks][:user]
  group node[:streamingbenchmarks][:group]
  mode 0755
end

template "#{node[:streamingbenchmarks][:home]}/bin/streaming-tweets.sh" do
  source "streaming-tweets.sh.erb"
  owner node[:streamingbenchmarks][:user]
  group node[:streamingbenchmarks][:group]
  mode 0755
end

template "#{node[:streamingbenchmarks][:home]}/bin/streaming-ab.sh" do
  source "streaming-ab.sh.erb"
  owner node[:streamingbenchmarks][:user]
  group node[:streamingbenchmarks][:group]
  mode 0755
end
