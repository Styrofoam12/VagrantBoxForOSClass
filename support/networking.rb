def forward_rabbit_ports(config)
  config.vm.network :forwarded_port, guest:  5672, host:  5672, id: 'rabbitmq'
  config.vm.network :forwarded_port, guest: 15672, host: 15672, id: 'rabbitmq_management'
end

def forward_elasticsearch_ports(config)
  config.vm.network :forwarded_port, guest: 9200, host: 9200, id: 'elasticsearch'
  config.vm.network :forwarded_port, guest: 9250, host: 9250, id: 'elasticsearch_tests'
end
