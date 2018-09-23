require 'aws-sdk-ec2'
require 'net/ssh/proxy/command'

set :branch, :master

set :ssh_options, {
  forward_agent: true,
  keys: ENV['SSH_KEY_PATH'],
  proxy: Net::SSH::Proxy::Command.new("ssh -i '#{ENV['SSH_KEY_PATH']}' ubuntu@#{ENV['BASTIAN_PUBLIC_IP']} -W %h:%p"),
}

server ENV['SERVER_PUBLIC_DNS'], user: 'deploy'
