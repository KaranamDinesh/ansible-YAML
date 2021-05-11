module "create_file" {
  count = 2
  source = "./module"
  line_number = count.index
}