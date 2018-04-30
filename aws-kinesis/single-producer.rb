require 'i2c'
require 'fileutils'
require 'json'
require 'pp'
require 'date'
require 'yaml'
require 'aws-sdk'

class KinesisStreamsProducer # Get temperature & Humidity data  from RaspberryPi with sensor(HIH3600)
  def initialize(path, address = 0x27)
    #i2c
    @device = I2C.create(path)
    @address = address
    @time = 0
    @temperature = 0
    @humidity = 0

    cli = YAML.load_file("config.yml")
    @region = cli["kinesisCredential"]["region"]
    @accessKey = cli["kinesisCredential"]["accessKeyId"]
    @secretKey = cli["kinesisCredential"]["secretKeyId"]

  end


  def putRecords
    # fetch Humidity & Temperature with i2c device
    s = @device.read(@address, 0x04)
    hum_h, hum_l, temp_h, temp_l = s.bytes.to_a

    status = (hum_h >> 6) & 0x03
    @time = Time.now.to_i
    hum_h = hum_h & 0x3f
    hum = (hum_h << 8) | hum_l
    temp = ((temp_h << 8) | temp_l) / 4

    @temperature = temp * 1.007e-2 - 40.0
    @humidity  = hum * 6.10e-3
    ##############################################

    # put records to Kinesis Streams
    kinesisClient = Aws::Kinesis::Client.new(
      region: @region,
      access_key_id: @accessKey,
      secret_access_key: @secretKey
    )

    device_room = ["living", "kitchen", "bath"] # Test
    records_json = JSON.generate({"datetime" => @time, "temperature" => @temperature, "humidity" => @humidity, "room" => "#{device_room.sample}"})

    records = kinesisClient.put_record(
      stream_name: "test-streams",
      data: records_json,
      partition_key: "#{device_room.sample}"
    )

    puts "ShardId: #{records.shard_id}, SequenceNumber: #{records.sequence_number}"

    return records
  end #putRecords end
end #class KinesisStreamsProducer end


#Following are processed codes
records_test = KinesisStreamsProducer.new('/dev/i2c-1')

loop do
  puts records_test.putRecords
end
