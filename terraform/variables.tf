variable "yc_token" {
  description = "Yandex Cloud API Token"
  type        = string
  sensitive   = true
}

variable "yc_cloud_id" {
  description = "Yandex Cloud ID"
  type        = string
}

variable "yc_folder_id" {
  description = "Yandex Cloud Folder ID"
  type        = string
}
variable "ssh_keys" {
  description = "Public keys SSH"
  type        = string
} 