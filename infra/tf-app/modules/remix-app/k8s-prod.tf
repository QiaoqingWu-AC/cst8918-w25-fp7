# modules/remix-app/k8s-prod.tf


resource "kubernetes_deployment" "remix_weather_prod" {
    provider = kubernetes.prod
  metadata {
    name      = "remix-weather-prod"
    namespace = "default"
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = "remix-weather-prod"
      }
    }

    template {
      metadata {
        labels = {
          app = "remix-weather-prod"
        }
      }

      spec {
        container {
          name  = "remix-weather"
          image = "${var.acr_login_server}/remix-weather:${var.image_tag}"

          env {
            name  = "REDIS_URL"
            value = "redis://${var.test_redis_hostname}:6379"
          }
        }
      }
    }
  }
}


resource "kubernetes_service" "remix_weather_service_prod" {
    provider = kubernetes.prod
  metadata {
    name      = "remix-weather-service-prod"
    namespace = "default"
  }

  spec {
    selector = {
      app = "remix-weather-prod"
    }

    port {
      port        = 80
      target_port = 8080
    }

    type = "LoadBalancer"
  }
}
