actions :generate_streaming, :streaming_tweets, :streaming_ab, :generate_batch, :batch, :build

attribute :zk_ip, :kind_of => String

#attribute :mgm_server, :kind_of => String, :name_attribute => true
#attribute :kafka_ip, :kind_of => String, :required => true

default_action :generate

