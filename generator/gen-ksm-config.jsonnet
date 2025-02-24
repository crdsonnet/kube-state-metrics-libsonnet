local autils = import 'github.com/crdsonnet/astsonnet/utils.libsonnet';
local crdsonnet = import 'github.com/crdsonnet/crdsonnet/crdsonnet/main.libsonnet';
local d = import 'github.com/jsonnet-libs/docsonnet/doc-util/main.libsonnet';

local schema =
  (import './options.json')
  + {
    '$defs'+: {
      Options+: {
        properties: std.mergePatch(
          super.properties,
          {
            Config: null,
            help: null,
          },
        ),
      },
    },
  };

local processor =
  crdsonnet.processor.new('ast')
  + {
    render(name, schema):
      autils.get(
        super.render(name, schema),
        name,
        default=error 'field %s not found in ast' % name
      ).expr,
  };

local ast = crdsonnet.schema.render(
  'config',
  schema,
  processor
);

ast.toString()
