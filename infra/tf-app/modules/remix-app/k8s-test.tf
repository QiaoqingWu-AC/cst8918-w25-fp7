# modules/remix-app/k8s-test.tf

resource "kubernetes_deployment" "remix_weather_test" {
  provider = kubernetes.test
  metadata {
    name      = "remix-weather-test"
    namespace = "default"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "remix-weather-test"
      }
    }

    template {
      metadata {
        labels = {
          app = "remix-weather-test"
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


resource "kubernetes_service" "remix_weather_service_test" {
  provider = kubernetes.test
  metadata {
    name      = "remix-weather-service-test"
    namespace = "default"
  }

  spec {
    selector = {
      app = "remix-weather-test"
    }

    port {
      port        = 80
      target_port = 8080
    }

    type = "LoadBalancer"
  }
}
