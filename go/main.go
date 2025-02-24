package main

import (
	"encoding/json"
	"os"

	"github.com/invopop/jsonschema"
	"k8s.io/kube-state-metrics/v2/pkg/customresourcestate"
	"k8s.io/kube-state-metrics/v2/pkg/options"
)

func main() {
	crs := jsonschema.Reflect(&customresourcestate.Metrics{})
	crsdata, err := json.MarshalIndent(crs, "", "  ")
	if err != nil {
		panic(err.Error())
	}
	if err := os.WriteFile("customresourcestate.json", crsdata, 0666); err != nil {
		panic(err)
	}

	reflector := jsonschema.Reflector{}
	reflector.FieldNameTag = "yaml"

	if err := reflector.AddGoComments("k8s.io/kube-state-metrics", "./v2/pkg/options"); err != nil {
		panic(err)
	}
	opt := reflector.Reflect(&options.Options{})
	optdata, err := json.MarshalIndent(opt, "", "  ")
	if err != nil {
		panic(err.Error())
	}
	if err := os.WriteFile("options.json", optdata, 0666); err != nil {
		panic(err)
	}
}
