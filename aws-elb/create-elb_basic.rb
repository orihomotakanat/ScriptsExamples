require 'aws-sdk'
require 'yaml'

class Elb
  def initialize()
    cli = YAML.load_file("config.yml")
    #credential
    @elbregion = cli["UserCredential"]["region"]
    @accessKey = cli["UserCredential"]["accessKeyId"]
    @secretKey = cli["UserCredential"]["secretKeyId"]

    #settings
    @certID = cli["Settings"]["certificateID"]
    @securityGroup = cli["Settings"]["securityGroup"]
    @subnet = cli["Settings"]["subnet"]
  end # def initialize()

  def create_elb_basic
    elbcli = Aws::ElasticLoadBalancing::Client.new(
      :access_key_id => @accessKey,
      :secret_access_key => @secretKey,
      :logger => Logger.new(STDOUT),
      :log_level => :debug
    )

    resp = elbcli.create_load_balancer({ # Classic Load Balancer
      listeners: [
        {
          instance_port: 80,
          instance_protocol: "HTTP",
          load_balancer_port: 80,
          protocol: "HTTP",
        },
        {
          instance_port: 80,
          instance_protocol: "HTTP",
          load_balancer_port: 443,
          protocol: "HTTPS",
          ssl_certificate_id: @certID,
        },
      ],
        load_balancer_name: "sample-clb",
        security_groups: [
          @securityGroup,
        ],
        subnets: [
          @subnet,
        ],
      })

  end # def create_elb_basic
end #class Elb

test = Elb.new
test.create_elb_basic
