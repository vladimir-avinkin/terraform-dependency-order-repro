provider "hashicups" {
  host = "http://api:9090"
  username = "education"
  password = "test123"
}

resource "hashicups_order" "cup" {
  dynamic "items" {
    for_each = null_resource.null
    content {
      quantity = 0
    coffee {
      id = items.key + 1
    }
    }
  }

  depends_on = [null_resource.null]
}

resource "null_resource" "null" {
  count = var.resource_count
}

variable "resource_count" {
  default = 2
}