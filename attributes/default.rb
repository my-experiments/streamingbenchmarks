# 'user' and 'group' define the unix user and group, respectively, 
# that the experiment will be excecuted as.
default[:streamingbenchmarks][:group] = "hadoop"
default[:streamingbenchmarks][:numCustomers] = "1000"
default[:streamingbenchmarks][:numStores] = "1000"
default[:streamingbenchmarks][:user] = "flink"

default[:streamingbenchmarks][:dir] = "/srv" 
default[:streamingbenchmarks][:home] = node[:streamingbenchmarks][:dir] + "/intel_streamingbench" 
default[:streamingbenchmarks][:numABRecords] = "100" 
default[:streamingbenchmarks][:numABGroups] = "5"
default[:streamingbenchmarks][:numTweets] = "25000000"
