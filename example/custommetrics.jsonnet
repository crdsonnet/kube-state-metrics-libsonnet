local ksmCustom = import '../ksm-custom/main.libsonnet';
local crsm = ksmCustom;  // shortcut


ksmCustom.crossplane.stateMetrics.new([{
  group: 'oss.grafana.crossplane.io',
  version: '*',
  kind: 'Dashboard',
}])
+ ksmCustom.crossplane.stateMetrics.withNamespaceFromClaimLabels()
