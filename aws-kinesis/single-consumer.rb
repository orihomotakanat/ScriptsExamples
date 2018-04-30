require 'aws-sdk'
require 'yaml'

class KinesisStreamsConsumer
  def initialize()
    cli = YAML.load_file("cofig.yml")
    @region = cli["kinesisCredential"]["region"]
    @accessKey = cli["kinesisCredential"]["accessKeyId"]
    @secretKey = cli["kinesisCredential"]["secretKeyId"]
    #streamName = ""
  end

  def createStream
    kinesis = Aws::Kinesis::Client.new(
      #region: @region,
      access_key_id: @accessKey,
      secret_access_key: @secretKey
      )

    kinesis.create_stream(
      :stream_name => "caseTest",
      :shard_count => 1
    )

    stream = kinesis.describe_stream(
      :stream_name => "caseTest"
      )

    return stream
  end # createShard end

  def getRecords
    kinesis = Aws::Kinesis::Client.new(
      region: @region,
      access_key_id: @accessKey,
      secret_access_key: @secretKey
      )

    shards = kinesis.describe_stream(stream_name: "testStream").stream_description.shards
    shards_ids = shards.map(&:shard_id)

    shards_ids.each do |shard_id|
      shard_iterator_info = kinesis.get_shard_iterator(
        stream_name: "testStream",
        shard_id: shard_id,
        shard_iterator_type: 'LATEST'
      )
      shard_iterator = shard_iterator_info.shard_iterator

      records_info = kinesis.get_records(
        shard_iterator: shard_iterator
      )

      records_info.records.each do |record|
        puts "Data: #{record}, PartitionKey: #{record.partition_key}"
      end #records end
    end #shards_ids end

  end #getRecords end

end #class end


test = KinesisStreamsConsumer.new

loop do
  test.getRecords
  sleep(4200)
end
