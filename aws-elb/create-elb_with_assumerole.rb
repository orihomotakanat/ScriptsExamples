require 'aws-sdk'
require 'yaml'

class Elb
  def initialize()
    cli = YAML.load_file("config.yml")
    #AssumeRoleCredentials
    @roleArn = cli["AssumeRoleCredentials"]["roleArn"] #ARN of AssumeRole
    @assumeAccessKey = cli["AssumeRoleCredentials"]["accessKeyId"] #AccessKeyId in Temporary Creadential User obtained with AssumeRole
    @assumeSecretKey = cli["AssumeRoleCredentials"]["secretKeyId"] #SecretKeyId in Temporary Creadential User obtained with AssumeRole
    #settings
    @certID = cli["Settings"]["certificateID"]
    @securityGroup = cli["Settings"]["securityGroup"]
    @subnet = cli["Settings"]["subnet"]
  end # def initialize()

  def create_elb_with_assumerole
    role_credentials = Aws::AssumeRoleCredentials.new(
        client: Aws::STS::Client.new(
                access_key_id: @assumeAccessKey,
                secret_access_key: @assumeSecretKey
                ),
        role_arn: @roleArn,
        role_session_name: "MakeELBusingAssumeRole" #Any name
    )
    elbcli = Aws::ElasticLoadBalancing::Client.new(credentials: role_credentials)

    resp = elbcli.create_load_balancer({
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
        load_balancer_name: "sample-clb-assumeRole",
        security_groups: [
          @securityGroup,
        ],
        subnets: [
          @subnet,
        ],
      })

  end # def create_elb_with_assumerole
end #class Elb

test = Elb.new
test.create_elb_with_assumerole
