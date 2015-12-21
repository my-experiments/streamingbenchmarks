

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
nn_ip = private_recipe_ip("hadoop", "nn")

template "#{node[:streamingbenchmarks][:home]}/conf/benchmark.properties" do
  source "benchmark.properties.erb"
  owner node[:streamingbenchmarks][:user]
  group node[:streamingbenchmarks][:group]
  mode 0755
  variables({ :zk_ip => zk_ip,
              :kafka_ip => kafka_ip,
              :master_url => "spark://#{spark_master}:7077",
              :hdfs_url => "hdfs://#{nn_ip}:8020/User/flink"
  })
end


streamingbenchmarks "tweets" do
  action :build
end

for d in %w[ streaming-generate.sh streaming-tweets.sh streaming-ab.sh spark-streaming-tweets.sh spark-streaming-ab.sh consume-kafka-spark.sh consume-kafka-flink.sh ]

  template "#{node[:streamingbenchmarks][:home]}/bin/#{d}" do
    source "#{d}.erb"
    owner node[:streamingbenchmarks][:user]
    group node[:streamingbenchmarks][:group]
    mode 0755
    variables({ :zk_ip => zk_ip,
              :kafka_ip => kafka_ip,
              :master_url => "spark://#{spark_master}:7077"
    })
  end
end

