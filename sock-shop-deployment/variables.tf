variable "yandex_token" {
  description = "Yandex.Cloud OAuth token"
}

variable "cloud_id" {
  description = "Yandex.Cloud ID"
}

variable "folder_id" {
  description = "Yandex.Cloud Folder ID"
}

variable "public_key_path" {
  description = "Path to the public SSH key"
  default     = "~/.ssh/id_rsa.pub"
}

variable "private_key_path" {
  description = "Path to the private SSH key"
  default     = "~/.ssh/id_rsa"
}
