resource "kubernetes_service" "redis" {
  metadata {
    name      = kubernetes_deployment.redis.spec.0.template.0.metadata.0.labels.app
    namespace = "default"
  }
  spec {
    selector = {
      app = kubernetes_deployment.redis.spec.0.template.0.metadata.0.labels.app
    }
    type = "ClusterIP"
    port {
      port        = 6379
      target_port = 6379
    }
  }
}

resource "kubernetes_service" "web" {
  metadata {
    name      = kubernetes_deployment.web.spec.0.template.0.metadata.0.labels.app
    namespace = "default"
  }
  spec {
    selector = {
      app = kubernetes_deployment.web.spec.0.template.0.metadata.0.labels.app
    }
    type = "ClusterIP"
    port {
      port        = 5000
      target_port = 5000
    }
  }
}