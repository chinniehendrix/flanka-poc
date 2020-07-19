// environments/prom-grafana/dev
(import "ksonnet-util/kausal.libsonnet") +
(import "prom-grafana/prom-grafana.libsonnet") +
{
   ns: $.core.v1.namespace.new('prom-grafana-dev'),
  // again, we only want to patch, not replace, thus +::
  _images+:: {
    // we update this one entirely, so we can replace this one (:)
    promgrafana: {
      prometheus: "prom/prometheus:v2.14",
      grafana: "grafana/grafana:6.5.2"
    }
  },

  podinfo: {
      deployment: deployment.new(
        name="podinfo", replicas=1,
        containers=[
          container.new("podinfo", $._images.promgrafana.podinfo),
        ],
      ),
    },
}