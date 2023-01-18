package main

import (
	"encoding/json"
	"fmt"

	"github.com/invopop/jsonschema"
	"k8s.io/kube-state-metrics/v2/pkg/customresourcestate"
)

func main() {
	s := jsonschema.Reflect(&customresourcestate.Metrics{})
	data, err := json.MarshalIndent(s, "", "  ")
	if err != nil {
		panic(err.Error())
	}
	fmt.Printf(string(data))
}
