import com.amazonaws.services.glue.ChoiceOption
import com.amazonaws.services.glue.GlueContext
import com.amazonaws.services.glue.MappingSpec
import com.amazonaws.services.glue.ResolveSpec
import com.amazonaws.services.glue.errors.CallSite
import com.amazonaws.services.glue.util.GlueArgParser
import com.amazonaws.services.glue.util.Job
import com.amazonaws.services.glue.util.JsonOptions
import org.apache.spark.SparkContext
import scala.collection.JavaConverters._
import com.amazonaws.services.glue.DynamicFrame
import com.amazonaws.services.glue.{DynamicFrame, GlueContext}
import org.apache.spark.sql.functions._

object GlueApp {
  def main(sysArgs: Array[String]) {
    //@transient val spark: SparkContext = new SparkContext()
    //val glueContext: GlueContext = new GlueContext(spark)

    val sc: SparkContext = new SparkContext()
    val glueContext: GlueContext = new GlueContext(sc)
    val spark = glueContext.getSparkSession

    val args = GlueArgParser.getResolvedOptions(sysArgs, Seq("JOB_NAME").toArray)
    Job.init(args("JOB_NAME"), glueContext, args.asJava)

    //Read data into DynamicFrame
    val dyf = glueContext.getCatalogSource(database = "test_db", tableName = "test_table", redshiftTmpDir = "", transformationContext = "datasource0").getDynamicFrame()

    // Mapping - no need in this code
    // val applymapping1 = dyf.applyMapping(mappings = Seq(("recordat", "string", "recordat", "string"), ("time_stamp", "int", "time_stamp", "int"), ("uuid", "string", "uuid", "string"), ("room_humidity", "double", "room_humidity", "double"), ("room_temperature", "double", "room_temperature", "double")), caseSensitive = false, transformationContext = "applymapping1")

    val resolvechoice = dyf.resolveChoice(choiceOption = Some(ChoiceOption("make_struct")), transformationContext = "resolvechoice")
    val dropnullfields = resolvechoice.dropNulls(transformationContext = "dropnullfields")

    val df = dropnullfields.toDF() //Convert from DynamicFrame to DataFrame
    df.printSchema() //For debug

    val partitionKeys = Array("year", "month", "day")
    val targetOutput = "s3://<your-own-bucket>/"

    val newDf = df //Create new DataFrame
      .withColumn("year", substring(df.col("recordat"), 0, 4)) //Obtain year part "2018" from 2018-12-01
      .withColumn("month", substring(df.col("recordat"), 6, 2))
      .withColumn("day", substring(df.col("recordat"), 9, 2))

    newDf.show(8) //For debug

    val partitionedDf = newDf.repartition(partitionKeys.map(col(_)):_*)

    partitionedDf.write.partitionBy(partitionKeys:_*).option("compression", "snappy").parquet(targetOutput)

    Job.commit()
  }
}
