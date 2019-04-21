VERSION ?= 0.0.1  
NAME ?= "GKE k8s deployment"  
AUTHOR ?= "Timileyin Farayola"  
  
  
.PHONY: deploy destroy  
  
  
deploy:  
	./main.sh
  
  
destroy:  
	./delete.sh
  
  
DEFAULT: deploy
