resource "kubernetes_deployment" "web" {
  metadata {
    name      = "python-web-queue"
    namespace = "default"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "python-web-queue"
      }
    }
    template {
      metadata {
        labels = {
          app = "python-web-queue"
        }
      }
      spec {
        container {
          image = "neel1998/python-redis-worker-job-queue:latest"
          name  = "python-web-queue"
          args  = ["python", "python_modules/request_handler.py"]

          resources {
            limits = {
              cpu    = "100m"
              memory = "50Mi"
            }
            requests = {
              cpu    = "100m"
              memory = "50Mi"
            }
          }

          dynamic "env" {
            for_each = var.env_variables
            content {
              name  = env.key
              value = env.value
            }
          }
          
          port {
            container_port = 5000
          }
        }
      }
    }
  }
}

resource "kubernetes_deployment" "worker" {
  metadata {
    name      = "python-worker"
    namespace = "default"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "worker"
      }
    }
    template {
      metadata {
        labels = {
          app = "worker"
        }
      }
      spec {
        container {
          image = "neel1998/python-redis-worker-job-queue:latest"
          name  = "worker"
          args  = ["python", "python_modules/worker.py"]

          resources {
            limits = {
              cpu    = "100m"
              memory = "50Mi"
            }
            requests = {
              cpu    = "100m"
              memory = "50Mi"
            }
          }

          dynamic "env" {
            for_each = var.env_variables
            content {
              name  = env.key
              value = env.value
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_deployment" "redis" {
  metadata {
    name      = "redis-server"
    namespace = "default"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "redis-server"
      }
    }
    template {
      metadata {
        labels = {
          app = "redis-server"
        }
      }
      spec {
        container {
          image = "redis:alpine"
          name  = "redis-server"

          resources {
            limits = {
              cpu    = "100m"
              memory = "50Mi"
            }
            requests = {
              cpu    = "100m"
              memory = "50Mi"
            }
          }

          port {
            container_port = 6379
          }

        }
      }
    }
  }
}