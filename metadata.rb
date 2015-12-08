name             'streamingbenchmarks'
maintainer       "streamingbenchmarks"
maintainer_email "jdowling@kth.se"
license          "Apache v2.0"
description      'Installs/Configures/Runs streamingbenchmarks'
version          "0.1"

recipe            "streamingbenchmarks::install", "Experiment setup for streamingbenchmarks"
recipe            "streamingbenchmarks::experiment",  "configFile=; Experiment name: experiment"


depends "kagent"



%w{ ubuntu debian rhel centos }.each do |os|
  supports os
end



attribute "streamingbenchmarks/group",
:description => "group parameter value",
:type => "string"

attribute "streamingbenchmarks/numCustomers",
:description => "numCustomers parameter value",
:type => "string"

attribute "streamingbenchmarks/numStores",
:description => "numStores parameter value",
:type => "string"

attribute "streamingbenchmarks/numABRecords",
:description => "Number of AB Records (streaming experiment)",
:type => "string"

attribute "streamingbenchmarks/numABGroups",
:description => "Number of AB Groups (streaming experiment)",
:type => "string"

attribute "streamingbenchmarks/numTweets",
:description => "Number of Tweets (streaming experiment)",
:type => "string"
