resource "kubernetes_namespace" "worker" {
  metadata {
    name = "worker"
  }
}

resource "kubernetes_namespace" "web" {
  metadata {
    name = "web"
  }
}

resource "kubernetes_namespace" "redis" {
  metadata {
    name = "redis"
  }
}