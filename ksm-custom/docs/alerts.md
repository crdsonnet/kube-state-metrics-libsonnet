# alerts

Generic alerts for use with Prometheus

## Index

* [`obj conditionStatus`](#obj-conditionstatus)
  * [`fn new(prefix, type, reasonFilter="reason=~\".*\"")`](#fn-conditionstatusnew)
  * [`fn withMessage(message)`](#fn-conditionstatuswithmessage)
  * [`fn withPendingFor(pendingFor)`](#fn-conditionstatuswithpendingfor)
  * [`fn withSeverity(severity)`](#fn-conditionstatuswithseverity)

## Fields

### obj conditionStatus

Create alert rules for the metrics provided by `spec.metrics.predefined.conditionStatus`

#### fn conditionStatus.new

```jsonnet
conditionStatus.new(prefix, type, reasonFilter="reason=~\".*\"")
```

PARAMETERS:

* **prefix** (`string`)
* **type** (`string`)
* **reasonFilter** (`string`)
   - default value: `"reason=~\".*\""`

`new` creates a new alert rule.

Arguments:
- `prefix`: metricNamePrefix that is used to create the CRSM resource
- `type`: type of condition to alert upon
- `reasonFilter`: prometheus label filter, this may be useful as some operations take longer or have a different severity

#### fn conditionStatus.withMessage

```jsonnet
conditionStatus.withMessage(message)
```

PARAMETERS:

* **message** (`string`)

`withMessage` can be used add additional information to the alert message annotation
#### fn conditionStatus.withPendingFor

```jsonnet
conditionStatus.withPendingFor(pendingFor)
```

PARAMETERS:

* **pendingFor** (`string`)

`withPendingFor` changes how long the alert can stay pending
#### fn conditionStatus.withSeverity

```jsonnet
conditionStatus.withSeverity(severity)
```

PARAMETERS:

* **severity** (`string`)

`withSeverity` changes the severity of the alert