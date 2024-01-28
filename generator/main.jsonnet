local j = import 'github.com/Duologic/jsonnet-libsonnet/main.libsonnet';
local jutils = import 'github.com/Duologic/jsonnet-libsonnet/utils.libsonnet';
local crdsonnet = import 'github.com/crdsonnet/crdsonnet/crdsonnet/main.libsonnet';
local d = import 'github.com/jsonnet-libs/docsonnet/doc-util/main.libsonnet';

local schema = import './schema.json';

local processor =
  crdsonnet.processor.new()
  + crdsonnet.processor.withRenderEngineType('ast')
  + {
    render(name, schema):
      jutils.get(
        super.render(name, schema),
        name,
        default=error 'field %s not found in ast' % name
      ).expr,
  };

local ast = crdsonnet.schema.render(
  'customResourceStateMetrics',
  schema,
  processor
);

ast.toString(break='\n')
