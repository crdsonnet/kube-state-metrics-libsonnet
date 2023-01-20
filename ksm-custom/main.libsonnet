local crdsonnet = import 'github.com/Duologic/crdsonnet/crdsonnet/main.libsonnet';
local schemadb = import 'github.com/Duologic/crdsonnet/crdsonnet/schemadb.libsonnet';

local schema = import 'schema.json';

local db = schemadb.add(schema);

local render = 'dynamic';

local customResourceMetricsStateSchema =
  schema['$defs'].Metrics {
    '$defs': schema['$defs'],
  };

crdsonnet.fromSchema(
  'customResourceStateMetrics',
  customResourceMetricsStateSchema,
  db,
  render=render
)
+ (
  if render == 'dynamic'
  then import 'veneer.libsonnet'
  else importstr 'veneer.libsonnet'
)
