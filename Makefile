.PHONY: generate_schemas
generate_schemas: go/main.go
	cd go && go run .

generator/customresourcestate.json: generate_schemas
	mv go/customresourcestate.json generator/customresourcestate.json

generator/options.json: generate_schemas
	mv go/options.json generator/options.json

ksm-custom/generated.libsonnet: generator/customresourcestate.json generator/gen-ksm-custom.jsonnet
	jsonnet -S \
		-J generator/vendor \
		generator/gen-ksm-custom.jsonnet \
		| jsonnetfmt --no-use-implicit-plus - \
		> ksm-custom/generated.libsonnet

ksm-config/generated.libsonnet: generator/options.json generator/gen-ksm-config.jsonnet
	jsonnet -S \
		-J generator/vendor \
		generator/gen-ksm-config.jsonnet \
		| jsonnetfmt --no-use-implicit-plus - \
		> ksm-config/generated.libsonnet

.PHONY: docs
docs:
	@cd kube-state-metrics && \
	rm -rf docs/ && \
	jsonnet -J vendor -S -c -m docs/ \
			--exec "(import 'doc-util/main.libsonnet').render(import 'main.libsonnet')"
	@cd ksm-custom && \
	rm -rf docs/ && \
	jsonnet -J vendor -S -c -m docs/ \
			--exec "(import 'doc-util/main.libsonnet').render(import 'main.libsonnet')"
	@cd ksm-config && \
	rm -rf docs/ && \
	jsonnet -J vendor -S -c -m docs/ \
			--exec "(import 'doc-util/main.libsonnet').render(import 'main.libsonnet')"

.PHONY: fmt
fmt:
	@find . -path './.git' -prune -o -name 'vendor' -prune -o -name '*.libsonnet' -print -o -name '*.jsonnet' -print | \
		xargs -n 1 -- jsonnetfmt --no-use-implicit-plus -i
