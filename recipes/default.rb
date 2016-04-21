

# script 'run_experiment' do
#   cwd "/tmp"
#   user node['streamingbenchmarks']['user']
#   group node['streamingbenchmarks']['group']
#   interpreter "bash"
#   code <<-EOM
# java -cp intel-consulting-scala/target/intel-consulting-scala-0.1-SNAPSHOT-allinone.jar hu.sztaki.mbalassi.intel.consulting.als.generator.RandomSparseMatrixGen --numStores #{node.streamingbenchmarks.numStores} --numCustomers #{node.streamingbenchmarks.Customers} --output hdfs://#{node.hadoop.nn.private_ips[0]}:8020/user/flink
#   EOM
# end

zk_ip = private_recipe_ip("kzookeeper", "default")
kafka_ip = private_recipe_ip("kkafka", "default")
spark_master = private_recipe_ip("hadoop_spark", "master")
nn_ip = private_recipe_ip("apache_hadoop", "nn")

template "#{node[:streamingbenchmarks][:home]}/conf/benchmark.properties" do
  source "benchmark.properties.erb"
  owner node[:streamingbenchmarks][:user]
  group node[:streamingbenchmarks][:group]
  mode 0755
  variables({ :zk_ip => zk_ip,
              :kafka_ip => kafka_ip,
              :master_url => "spark://#{spark_master}:7077",
              :hdfs_url => "hdfs://#{nn_ip}:8020/user/flink"
  })
end


streamingbenchmarks "createtopics" do
  zk_ip zk_ip
  action :build
end

for d in %w[ batch-generate.sh batch-als.sh batch-pearson.sh spark-batch-als.sh spark-batch-pearson.sh streaming-generate.sh streaming-tweets.sh streaming-ab.sh spark-streaming-tweets.sh spark-streaming-ab.sh consume-kafka-spark.sh consume-kafka-flink.sh create-kafka-topics.sh ]

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

  template "#{node[:streamingbenchmarks][:home]}/README.txt" do
    source "README.txt.erb"
    owner node[:streamingbenchmarks][:user]
    group node[:streamingbenchmarks][:group]
    mode 0755
  end

