provider "kubernetes"{
    config_context_cluster   = "minikube"
    }

resource "kubernetes_deployment" "myrs" {
  metadata {
    name = "myreplicset"
    labels = {
      test = "replicatest"
    }
  }

  spec {
    replicas = 1


    selector {
      match_labels = {
        env = "dev"
        dc  = "IN"
        app = "webserver"
      }
      match_expressions {
         key = "dc" 
         operator = "In" 
         values = [ "IN" , "US" ]  
         
     }
     match_expressions {
         key = "env" 
         operator = "In" 
         values = [ "dev" ]  
         
     }
      match_expressions {
         key = "app" 
         operator = "In" 
         values = [ "webserver" ]  
         
     }
}

    template {
      metadata {
         name = "mypod1"
        labels = {
           dc = "IN"
           env = "dev"
           app = "webserver"
      
        }
      }

      spec {
        container {
          image = "princeprashantsaini/tensorflow_task3"
          name  = "replica-container"
        }
      }
    }
  }
}   