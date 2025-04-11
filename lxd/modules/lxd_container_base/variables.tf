variable "container_name" {
  type          = string
  description   = "The name of the LXD container"
}

variable "container_image" {
  type          = string
  default       = "ubuntu"
  description   = "The LXD image to use for the container"
}

variable "container_profiles" {
  type          = list(string)
  default       = [ "ophelia_ci" ]
  description   = "The LXD profiles to apply to the container"
}
