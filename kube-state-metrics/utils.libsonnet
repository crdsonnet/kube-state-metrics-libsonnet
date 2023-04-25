local k = import 'github.com/grafana/jsonnet-libs/ksonnet-util/kausal.libsonnet';
local d = import 'github.com/jsonnet-libs/docsonnet/doc-util/main.libsonnet';

{
  '#': d.package.newSub(
    'utils',
    'Helper functions to use in combination with kube-state-metrics'
  ),

  '#createWatchRules':: d.fn(
    |||
      `createWatchRules` turns an array of group/resources into a set of policyRules with
      list/watch verbs.

      For example, this array:

      ```jsonnet
      [
        {
          group: 'apps',
          resources: ['daemonsets', 'deployments'],
        }
      ]
      ```

      Will result in these policyRules:

      ```json
      [
          {
            "apiGroups": [
              "apps"
            ],
            "resources": [
              "daemonsets",
              "deployments"
            ],
            "verbs": [
              "list",
              "watch"
            ]
          }
      ]
      ```

      Additionally the policy rules array will be sorted so that the order of the
      input array does not affect the output order.
    |||,
    args=[d.arg('groupResources', d.T.array)],
  ),
  createWatchRules(groupResources):
    local policyRule = k.rbac.v1.policyRule;
    local groups =
      std.set(std.map(
        function(x) x.group,
        groupResources
      ));
    local rules = [
      policyRule.withApiGroups([group])
      + policyRule.withResources(
        std.flattenArrays(
          std.set(std.filterMap(
            function(x)
              x.group == group
              && 'resources' in x,
            function(x) x.resources,
            groupResources,
          ))
        )
      )
      + policyRule.withVerbs(['list', 'watch'])
      for group in groups
    ];
    self.sortRules(rules),

  '#sortRules':: d.fn(
    |||
      `sortRules` sorts policy rules for consistent output.
    |||,
    args=[d.arg('rules', d.T.array)],
  ),
  sortRules(rules):
    std.sort(
      rules,
      function(r)
        std.join(
          '',
          std.sort(r.verbs)
          + std.sort(r.apiGroups)
          + std.sort(r.resources)
        )
    ),

  '#scrapeConfig':: d.fn(
    |||
      `scrapeConfig` provides a scrape config for kube-state-metrics for Prometheus.

      This relates to the scrape configs in https://github.com/grafana/jsonnet-libs/tree/master/prometheus

      This scrape config doesn't add namespace, container, and pod labels, instead taking
      those labels from the exported timeseries. This prevents them being renamed to
      exported_namespace etc. and allows us to route alerts based on namespace and join
      KSM metrics with cAdvisor metrics.
    |||,
    args=[
      d.arg('namespace', d.T.string),
      d.arg('name', d.T.string, 'kube-state-metrics'),
    ],
  ),
  scrapeConfig(namespace, name='kube-state-metrics'): {
    job_name: std.join('/', [namespace, name]),
    kubernetes_sd_configs: [{
      role: 'pod',
      namespaces: {
        names: [namespace],
      },
    }],

    relabel_configs: [

      // Drop anything whose service is not kube-state-metrics.
      {
        source_labels: ['__meta_kubernetes_pod_label_name'],
        regex: name,
        action: 'keep',
      },

      // Drop anything whose port is not 'ksm', these are the metrics computed by
      // kube-state-metrics itself and not the 'self metrics' which should be
      // scraped by normal prometheus service discovery ('self-metrics' port
      // name).
      {
        source_labels: ['__meta_kubernetes_pod_container_port_name'],
        regex: 'ksm',
        action: 'keep',
      },

      // Rename instances to the concatenation of pod:container:port.
      // In the specific case of KSM, we could leave out the container
      // name and still have a unique instance label, but we leave it
      // in here for consistency with the normal pod scraping.
      {
        source_labels: [
          '__meta_kubernetes_pod_name',
          '__meta_kubernetes_pod_container_name',
          '__meta_kubernetes_pod_container_port_name',
        ],
        action: 'replace',
        separator: ':',
        target_label: 'instance',
      },
    ],
  },
}
