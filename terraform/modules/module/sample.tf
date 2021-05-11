resource "local_file" "foo" {
  content     = "foo-${var.line_number}"
  filename = "/tmp/foo.bar-${var.line_number}"
}
variable "line_number" {}