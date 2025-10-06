variable "project_id" {
  description = "ID del proyecto GCP"
  type        = string
}

variable "region" {
  description = "Región para los recursos"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "Zona de despliegue"
  type        = string
  default     = "us-central1-a"
}

variable "network_name" {
  description = "Nombre de la red VPC"
  type        = string
  default     = "web-app-vpc"
}

variable "subnet_name" {
  description = "Nombre de la subred"
  type        = string
  default     = "web-app-subnet"
}

variable "instance_name" {
  description = "Nombre de la instancia de VM"
  type        = string
  default     = "web-server-1"
}

variable "machine_type" {
  description = "Tipo de máquina para la instancia"
  type        = string
  default     = "e2-medium"
}

variable "credentials_file" {
  description = "Ruta al archivo JSON de la cuenta de servicio"
  type        = string
}
