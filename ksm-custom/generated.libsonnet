{
  '#withSpec': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['object'] }], help: '' } },
  withSpec(value): { spec: value },
  '#withSpecMixin': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['object'] }], help: '' } },
  withSpecMixin(value): { spec+: value },
  spec+:
    {
      '#withResources': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['array'] }], help: '' } },
      withResources(value): { spec+: { resources: (if std.isArray(value)
                                                   then value
                                                   else [value]) } },
      '#withResourcesMixin': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['array'] }], help: '' } },
      withResourcesMixin(value): { spec+: { resources+: (if std.isArray(value)
                                                         then value
                                                         else [value]) } },
      resources+:
        {
          '#': { help: '', name: 'resources' },
          '#withCommonLabels': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['object'] }], help: '' } },
          withCommonLabels(value): { commonLabels: value },
          '#withCommonLabelsMixin': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['object'] }], help: '' } },
          withCommonLabelsMixin(value): { commonLabels+: value },
          '#withErrorLogV': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['integer'] }], help: '' } },
          withErrorLogV(value): { errorLogV: value },
          '#withGroupVersionKind': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['object'] }], help: '' } },
          withGroupVersionKind(value): { groupVersionKind: value },
          '#withGroupVersionKindMixin': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['object'] }], help: '' } },
          withGroupVersionKindMixin(value): { groupVersionKind+: value },
          groupVersionKind+:
            {
              '#withGroup': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['string'] }], help: '' } },
              withGroup(value): { groupVersionKind+: { group: value } },
              '#withKind': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['string'] }], help: '' } },
              withKind(value): { groupVersionKind+: { kind: value } },
              '#withVersion': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['string'] }], help: '' } },
              withVersion(value): { groupVersionKind+: { version: value } },
            },
          '#withLabelsFromPath': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['object'] }], help: '' } },
          withLabelsFromPath(value): { labelsFromPath: value },
          '#withLabelsFromPathMixin': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['object'] }], help: '' } },
          withLabelsFromPathMixin(value): { labelsFromPath+: value },
          '#withMetricNamePrefix': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['string'] }], help: '' } },
          withMetricNamePrefix(value): { metricNamePrefix: value },
          '#withMetrics': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['array'] }], help: '' } },
          withMetrics(value): { metrics: (if std.isArray(value)
                                          then value
                                          else [value]) },
          '#withMetricsMixin': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['array'] }], help: '' } },
          withMetricsMixin(value): { metrics+: (if std.isArray(value)
                                                then value
                                                else [value]) },
          metrics+:
            {
              '#': { help: '', name: 'metrics' },
              '#withCommonLabels': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['object'] }], help: '' } },
              withCommonLabels(value): { commonLabels: value },
              '#withCommonLabelsMixin': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['object'] }], help: '' } },
              withCommonLabelsMixin(value): { commonLabels+: value },
              '#withEach': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['object'] }], help: '' } },
              withEach(value): { each: value },
              '#withEachMixin': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['object'] }], help: '' } },
              withEachMixin(value): { each+: value },
              each+:
                {
                  '#withGauge': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['object'] }], help: '' } },
                  withGauge(value): { each+: { gauge: value } },
                  '#withGaugeMixin': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['object'] }], help: '' } },
                  withGaugeMixin(value): { each+: { gauge+: value } },
                  gauge+:
                    {
                      '#withLabelFromKey': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['string'] }], help: '' } },
                      withLabelFromKey(value): { each+: { gauge+: { labelFromKey: value } } },
                      '#withLabelsFromPath': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['object'] }], help: '' } },
                      withLabelsFromPath(value): { each+: { gauge+: { labelsFromPath: value } } },
                      '#withLabelsFromPathMixin': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['object'] }], help: '' } },
                      withLabelsFromPathMixin(value): { each+: { gauge+: { labelsFromPath+: value } } },
                      '#withNilIsZero': { 'function': { args: [{ default: true, enums: null, name: 'value', type: ['boolean'] }], help: '' } },
                      withNilIsZero(value=true): { each+: { gauge+: { nilIsZero: value } } },
                      '#withPath': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['array'] }], help: '' } },
                      withPath(value): { each+: { gauge+: { path: (if std.isArray(value)
                                                                   then value
                                                                   else [value]) } } },
                      '#withPathMixin': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['array'] }], help: '' } },
                      withPathMixin(value): { each+: { gauge+: { path+: (if std.isArray(value)
                                                                         then value
                                                                         else [value]) } } },
                      '#withValueFrom': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['array'] }], help: '' } },
                      withValueFrom(value): { each+: { gauge+: { valueFrom: (if std.isArray(value)
                                                                             then value
                                                                             else [value]) } } },
                      '#withValueFromMixin': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['array'] }], help: '' } },
                      withValueFromMixin(value): { each+: { gauge+: { valueFrom+: (if std.isArray(value)
                                                                                   then value
                                                                                   else [value]) } } },
                    },
                  '#withInfo': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['object'] }], help: '' } },
                  withInfo(value): { each+: { info: value } },
                  '#withInfoMixin': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['object'] }], help: '' } },
                  withInfoMixin(value): { each+: { info+: value } },
                  info+:
                    {
                      '#withLabelFromKey': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['string'] }], help: '' } },
                      withLabelFromKey(value): { each+: { info+: { labelFromKey: value } } },
                      '#withLabelsFromPath': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['object'] }], help: '' } },
                      withLabelsFromPath(value): { each+: { info+: { labelsFromPath: value } } },
                      '#withLabelsFromPathMixin': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['object'] }], help: '' } },
                      withLabelsFromPathMixin(value): { each+: { info+: { labelsFromPath+: value } } },
                      '#withPath': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['array'] }], help: '' } },
                      withPath(value): { each+: { info+: { path: (if std.isArray(value)
                                                                  then value
                                                                  else [value]) } } },
                      '#withPathMixin': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['array'] }], help: '' } },
                      withPathMixin(value): { each+: { info+: { path+: (if std.isArray(value)
                                                                        then value
                                                                        else [value]) } } },
                    },
                  '#withStateSet': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['object'] }], help: '' } },
                  withStateSet(value): { each+: { stateSet: value } },
                  '#withStateSetMixin': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['object'] }], help: '' } },
                  withStateSetMixin(value): { each+: { stateSet+: value } },
                  stateSet+:
                    {
                      '#withLabelName': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['string'] }], help: '' } },
                      withLabelName(value): { each+: { stateSet+: { labelName: value } } },
                      '#withLabelsFromPath': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['object'] }], help: '' } },
                      withLabelsFromPath(value): { each+: { stateSet+: { labelsFromPath: value } } },
                      '#withLabelsFromPathMixin': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['object'] }], help: '' } },
                      withLabelsFromPathMixin(value): { each+: { stateSet+: { labelsFromPath+: value } } },
                      '#withList': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['array'] }], help: '' } },
                      withList(value): { each+: { stateSet+: { list: (if std.isArray(value)
                                                                      then value
                                                                      else [value]) } } },
                      '#withListMixin': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['array'] }], help: '' } },
                      withListMixin(value): { each+: { stateSet+: { list+: (if std.isArray(value)
                                                                            then value
                                                                            else [value]) } } },
                      '#withPath': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['array'] }], help: '' } },
                      withPath(value): { each+: { stateSet+: { path: (if std.isArray(value)
                                                                      then value
                                                                      else [value]) } } },
                      '#withPathMixin': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['array'] }], help: '' } },
                      withPathMixin(value): { each+: { stateSet+: { path+: (if std.isArray(value)
                                                                            then value
                                                                            else [value]) } } },
                      '#withValueFrom': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['array'] }], help: '' } },
                      withValueFrom(value): { each+: { stateSet+: { valueFrom: (if std.isArray(value)
                                                                                then value
                                                                                else [value]) } } },
                      '#withValueFromMixin': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['array'] }], help: '' } },
                      withValueFromMixin(value): { each+: { stateSet+: { valueFrom+: (if std.isArray(value)
                                                                                      then value
                                                                                      else [value]) } } },
                    },
                  '#withType': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['string'] }], help: '' } },
                  withType(value): { each+: { type: value } },
                },
              '#withErrorLogV': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['integer'] }], help: '' } },
              withErrorLogV(value): { errorLogV: value },
              '#withHelp': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['string'] }], help: '' } },
              withHelp(value): { help: value },
              '#withLabelsFromPath': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['object'] }], help: '' } },
              withLabelsFromPath(value): { labelsFromPath: value },
              '#withLabelsFromPathMixin': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['object'] }], help: '' } },
              withLabelsFromPathMixin(value): { labelsFromPath+: value },
              '#withName': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['string'] }], help: '' } },
              withName(value): { name: value },
            },
          '#withResourcePlural': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['string'] }], help: '' } },
          withResourcePlural(value): { resourcePlural: value },
        },
    },
}
