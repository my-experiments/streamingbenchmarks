
script 'run_experiment' do
  cwd "/tmp"
  user node['streamingbenchmarks']['user']
  group node['streamingbenchmarks']['group']
  interpreter "bash"
  code <<-EOM
java -cp intel-consulting-scala/target/intel-consulting-scala-0.1-SNAPSHOT-allinone.jar hu.sztaki.mbalassi.intel.consulting.als.generator.RandomSparseMatrixGen --numStores #{node.streamingbenchmarks.numStores} --numCustomers #{node.streamingbenchmarks.Customers} --output hdfs://#{node.hadoop.nn.private_ips[0]}:8020/User/flink
  EOM
end

