# 'user' and 'group' define the unix user and group, respectively, 
# that the experiment will be excecuted as.
default[:streamingbenchmarks][:group] = "hadoop"
default[:streamingbenchmarks][:numCustomers] = "100"
default[:streamingbenchmarks][:numStores] = "100"
default[:streamingbenchmarks][:user] = "flink"

default[:streamingbenchmarks][:dir] = "/srv" 
default[:streamingbenchmarks][:home] = node[:streamingbenchmarks][:dir] + "/intel_streamingbench" 
default[:streamingbenchmarks][:numABRecords] = "10000" 
default[:streamingbenchmarks][:numABGroups] = "5"
default[:streamingbenchmarks][:numTweets] = "25000"

default[:streamingbenchmarks][:replicasTweets]   = "1"
default[:streamingbenchmarks][:partitionsTweets] = "1"

default[:streamingbenchmarks][:partitionsAB]     = "1"
default[:streamingbenchmarks][:replicasAB]       = "1"

