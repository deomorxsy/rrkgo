```
++ id -u
+ myuid=0
++ id -g
+ mygid=0
+ set +e
++ getent passwd 0
+ uidentry=root:x:0:0:root:/root:/bin/bash
+ set -e
+ '[' -z root:x:0:0:root:/root:/bin/bash ']'
+ SPARK_K8S_CMD=driver
+ case "$SPARK_K8S_CMD" in
+ shift 1
+ SPARK_CLASSPATH=':/opt/spark/jars/*'
+ env
+ grep SPARK_JAVA_OPT_
+ sort -t_ -k4 -n
+ sed 's/[^=]*=\(.*\)/\1/g'
+ readarray -t SPARK_EXECUTOR_JAVA_OPTS
+ '[' -n '' ']'
+ '[' -n '' ']'
+ PYSPARK_ARGS=
+ '[' -n '' ']'
+ R_ARGS=
+ '[' -n '' ']'
+ '[' '' == 2 ']'
+ '[' '' == 3 ']'
+ case "$SPARK_K8S_CMD" in
+ CMD=("$SPARK_HOME/bin/spark-submit" --conf "spark.driver.bindAddress=$SPARK_DRIVER_BIND_ADDRESS" --deploy-mode client "$@")
+ exec /usr/bin/tini -s -- /opt/spark/bin/spark-submit --conf spark.driver.bindAddress=10.42.0.10 --deploy-mode client --properties-file /opt/spark/conf/spark.properties --class org.apache.spark.examples.SparkPi local:///opt/spark/examples/jars/spark-examples_2.11-2.4.5.jar
22/04/09 02:47:51 WARN NativeCodeLoader: Unable to load native-hadoop library for your platform... using builtin-java classes where applicable
Using Spark's default log4j profile: org/apache/spark/log4j-defaults.properties
22/04/09 02:47:51 INFO SparkContext: Running Spark version 2.4.5
22/04/09 02:47:52 INFO SparkContext: Submitted application: Spark Pi
22/04/09 02:47:52 INFO SecurityManager: Changing view acls to: root
22/04/09 02:47:52 INFO SecurityManager: Changing modify acls to: root
22/04/09 02:47:52 INFO SecurityManager: Changing view acls groups to:
22/04/09 02:47:52 INFO SecurityManager: Changing modify acls groups to:
22/04/09 02:47:52 INFO SecurityManager: SecurityManager: authentication disabled; ui acls disabled; users  with view permissions: Set(root); groups with view permissions: Set(); users  with modify permissions: Set(root); groups with modify permissions: Set()
22/04/09 02:47:52 INFO Utils: Successfully started service 'sparkDriver' on port 7078.
22/04/09 02:47:52 INFO SparkEnv: Registering MapOutputTracker
22/04/09 02:47:52 INFO SparkEnv: Registering BlockManagerMaster
22/04/09 02:47:52 INFO BlockManagerMasterEndpoint: Using org.apache.spark.storage.DefaultTopologyMapper for getting topology information
22/04/09 02:47:52 INFO BlockManagerMasterEndpoint: BlockManagerMasterEndpoint up
22/04/09 02:47:52 INFO DiskBlockManager: Created local directory at /var/data/spark-963e8b35-ffa7-45ec-b933-1c7d4210d17d/blockmgr-1b33c9fa-e611-426a-815a-e28f54f0be13
22/04/09 02:47:52 INFO MemoryStore: MemoryStore started with capacity 93.3 MB
22/04/09 02:47:52 INFO SparkEnv: Registering OutputCommitCoordinator
22/04/09 02:47:53 INFO Utils: Successfully started service 'SparkUI' on port 4040.
22/04/09 02:47:53 INFO SparkUI: Bound SparkUI to 0.0.0.0, and started at http://spark-pi-8c1d45800c332075-driver-svc.spark-apps.svc:4040
22/04/09 02:47:53 INFO SparkContext: Added JAR local:///opt/spark/examples/jars/spark-examples_2.11-2.4.5.jar at file:/opt/spark/examples/jars/spark-examples_2.11-2.4.5.jar with timestamp 1649472473303
22/04/09 02:47:53 WARN SparkContext: The jar local:///opt/spark/examples/jars/spark-examples_2.11-2.4.5.jar has been added already. Overwriting of added jars is not supported in the current version.
22/04/09 02:47:57 INFO ExecutorPodsAllocator: Going to request 1 executors from Kubernetes.
22/04/09 02:47:58 INFO Utils: Successfully started service 'org.apache.spark.network.netty.NettyBlockTransferService' on port 7079.
22/04/09 02:47:58 INFO NettyBlockTransferService: Server created on spark-pi-8c1d45800c332075-driver-svc.spark-apps.svc:7079
22/04/09 02:47:58 INFO BlockManager: Using org.apache.spark.storage.RandomBlockReplicationPolicy for block replication policy
22/04/09 02:47:58 INFO BlockManagerMaster: Registering BlockManager BlockManagerId(driver, spark-pi-8c1d45800c332075-driver-svc.spark-apps.svc, 7079, None)
22/04/09 02:47:58 INFO BlockManagerMasterEndpoint: Registering block manager spark-pi-8c1d45800c332075-driver-svc.spark-apps.svc:7079 with 93.3 MB RAM, BlockManagerId(driver, spark-pi-8c1d45800c332075-driver-svc.spark-apps.svc, 7079, None)
22/04/09 02:47:58 INFO BlockManagerMaster: Registered BlockManager BlockManagerId(driver, spark-pi-8c1d45800c332075-driver-svc.spark-apps.svc, 7079, None)
22/04/09 02:47:58 INFO BlockManager: Initialized BlockManager: BlockManagerId(driver, spark-pi-8c1d45800c332075-driver-svc.spark-apps.svc, 7079, None)
22/04/09 02:48:05 INFO KubernetesClusterSchedulerBackend$KubernetesDriverEndpoint: Registered executor NettyRpcEndpointRef(spark-client://Executor) (10.42.0.11:49556) with ID 1
22/04/09 02:48:05 INFO KubernetesClusterSchedulerBackend: SchedulerBackend is ready for scheduling beginning after reached minRegisteredResourcesRatio: 0.8
22/04/09 02:48:05 INFO BlockManagerMasterEndpoint: Registering block manager 10.42.0.11:38679 with 114.6 MB RAM, BlockManagerId(1, 10.42.0.11, 38679, None)
22/04/09 02:48:06 INFO SparkContext: Starting job: reduce at SparkPi.scala:38
22/04/09 02:48:06 INFO DAGScheduler: Got job 0 (reduce at SparkPi.scala:38) with 2 output partitions
22/04/09 02:48:06 INFO DAGScheduler: Final stage: ResultStage 0 (reduce at SparkPi.scala:38)
22/04/09 02:48:06 INFO DAGScheduler: Parents of final stage: List()
22/04/09 02:48:06 INFO DAGScheduler: Missing parents: List()
22/04/09 02:48:06 INFO DAGScheduler: Submitting ResultStage 0 (MapPartitionsRDD[1] at map at SparkPi.scala:34), which has no missing parents
22/04/09 02:48:06 INFO MemoryStore: Block broadcast_0 stored as values in memory (estimated size 2.0 KB, free 93.3 MB)
22/04/09 02:48:06 INFO MemoryStore: Block broadcast_0_piece0 stored as bytes in memory (estimated size 1381.0 B, free 93.3 MB)
22/04/09 02:48:06 INFO BlockManagerInfo: Added broadcast_0_piece0 in memory on spark-pi-8c1d45800c332075-driver-svc.spark-apps.svc:7079 (size: 1381.0 B, free: 93.3 MB)
22/04/09 02:48:06 INFO SparkContext: Created broadcast 0 from broadcast at DAGScheduler.scala:1163
22/04/09 02:48:06 INFO DAGScheduler: Submitting 2 missing tasks from ResultStage 0 (MapPartitionsRDD[1] at map at SparkPi.scala:34) (first 15 tasks are for partitions Vector(0, 1))
22/04/09 02:48:06 INFO TaskSchedulerImpl: Adding task set 0.0 with 2 tasks
22/04/09 02:48:06 INFO TaskSetManager: Starting task 0.0 in stage 0.0 (TID 0, 10.42.0.11, executor 1, partition 0, PROCESS_LOCAL, 7885 bytes)
22/04/09 02:48:06 INFO BlockManagerInfo: Added broadcast_0_piece0 in memory on 10.42.0.11:38679 (size: 1381.0 B, free: 114.6 MB)
22/04/09 02:48:07 INFO TaskSetManager: Starting task 1.0 in stage 0.0 (TID 1, 10.42.0.11, executor 1, partition 1, PROCESS_LOCAL, 7885 bytes)
22/04/09 02:48:07 INFO TaskSetManager: Finished task 0.0 in stage 0.0 (TID 0) in 414 ms on 10.42.0.11 (executor 1) (1/2)
22/04/09 02:48:07 INFO TaskSetManager: Finished task 1.0 in stage 0.0 (TID 1) in 25 ms on 10.42.0.11 (executor 1) (2/2)
22/04/09 02:48:07 INFO TaskSchedulerImpl: Removed TaskSet 0.0, whose tasks have all completed, from pool
22/04/09 02:48:07 INFO DAGScheduler: ResultStage 0 (reduce at SparkPi.scala:38) finished in 0.936 s
22/04/09 02:48:07 INFO DAGScheduler: Job 0 finished: reduce at SparkPi.scala:38, took 1.047959 s
Pi is roughly 3.1436957184785923
22/04/09 02:48:07 INFO SparkUI: Stopped Spark web UI at http://spark-pi-8c1d45800c332075-driver-svc.spark-apps.svc:4040
22/04/09 02:48:07 INFO KubernetesClusterSchedulerBackend: Shutting down all executors
22/04/09 02:48:07 INFO KubernetesClusterSchedulerBackend$KubernetesDriverEndpoint: Asking each executor to shut down
22/04/09 02:48:07 WARN ExecutorPodsWatchSnapshotSource: Kubernetes client has been closed (this is expected if the application is shutting down.)
22/04/09 02:48:07 INFO MapOutputTrackerMasterEndpoint: MapOutputTrackerMasterEndpoint stopped!
22/04/09 02:48:07 INFO MemoryStore: MemoryStore cleared
22/04/09 02:48:07 INFO BlockManager: BlockManager stopped
22/04/09 02:48:07 INFO BlockManagerMaster: BlockManagerMaster stopped
22/04/09 02:48:07 INFO OutputCommitCoordinator$OutputCommitCoordinatorEndpoint: OutputCommitCoordinator stopped!
22/04/09 02:48:07 INFO SparkContext: Successfully stopped SparkContext
22/04/09 02:48:07 INFO ShutdownHookManager: Shutdown hook called
22/04/09 02:48:07 INFO ShutdownHookManager: Deleting directory /tmp/spark-7c7a33d1-db60-43c4-8641-b443355458bf
22/04/09 02:48:07 INFO ShutdownHookManager: Deleting directory /var/data/spark-963e8b35-ffa7-45ec-b933-1c7d4210d17d/spark-c39e2213-5023-401e-8818-834d40ac5c89
Stream closed EOF for spark-apps/spark-pi-driver (spark-kubernetes-driver)


```
