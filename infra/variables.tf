variable "service" {
  default = "pr-demo"
}


variable "root_domain_name" {
  default = "natecheng.com"
}

variable "debug" {
  default = false
}

variable "lambda_origin_request" {
  type    = map(string)
  default = {}
}

variable "lambda_origin_request_defaults" {
  type = map(string)
  default = {
    name     = "graph-chatapp-web-artifacts-origin-request"
    handler  = "index.handler"
    artifact = "web-artifacts-origin-request.zip"
    runtime  = "nodejs16.x"
    timeout  = "10"  # seconds
    memory   = "128" # MB
  }
}

variable "lambda_viewer_request" {
  type    = map(string)
  default = {}
}

variable "lambda_viewer_request_defaults" {
  type = map(string)
  default = {
    name     = "graph-chatapp-web-artifacts-viewer-request"
    handler  = "index.handler"
    artifact = "web-artifacts-viewer-request.zip"
    runtime  = "nodejs16.x"
    timeout  = "10"  # seconds
    memory   = "128" # MB
  }
}