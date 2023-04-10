local k = import 'github.com/grafana/jsonnet-libs/ksonnet-util/kausal.libsonnet';
local d = import 'github.com/jsonnet-libs/docsonnet/doc-util/main.libsonnet';

{
  '#createWatchRules':: d.fn(
    |||
      `createWatchRules` turns an array of group/kinds into a set of policyRules with
      list/watch verbs.

      For example, this array:

      ```jsonnet
      [
        {
          group: 'apps',
          kinds: ['daemonsets', 'deployments'],
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
    args=[d.arg('groupKinds', d.T.array)],
  ),
  createWatchRules(groupKinds):
    local policyRule = k.rbac.v1.policyRule;
    local groups =
      std.set(std.map(
        function(x) x.group,
        groupKinds
      ));
    local rules = [
      policyRule.withApiGroups([group])
      + policyRule.withResources(
        std.flattenArrays(
          std.set(std.filterMap(
            function(x)
              x.group == group
              && 'kinds' in x,
            function(x) x.kinds,
            groupKinds,
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
}
