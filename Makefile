generator/schema.json:
	cd go && go run . > ../generator/schema.json

ksm-custom/generated.libsonnet:
	jsonnet -S \
		-J generator/vendor \
		generator/main.jsonnet \
		| jsonnetfmt --no-use-implicit-plus - \
		> ksm-custom/generated.libsonnet

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

.PHONY: fmt
fmt:
	@find . -path './.git' -prune -o -name 'vendor' -prune -o -name '*.libsonnet' -print -o -name '*.jsonnet' -print | \
		xargs -n 1 -- jsonnetfmt --no-use-implicit-plus -i
