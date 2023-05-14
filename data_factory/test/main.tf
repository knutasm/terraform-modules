module "data_factory" {
  source = "../"
  resource_group_name = "rg-data-factory-test"
  location = "westeurope"
  data_factory_name = "test-data-factory-knutasm"
}
