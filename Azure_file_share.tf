resource "azurerm_storage_account" "account_share" {
  name                     = "aref23file1share"
  resource_group_name      = azurerm_resource_group.terraform_Lab.name
  location                 = azurerm_resource_group.terraform_Lab.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_share" "file_share" {
  name                 = "sharedfiles"
  storage_account_id   = azurerm_storage_account.account_share.id
  quota                = 5120 # 5GB
}

# upload the xamp file

resource "null_resource" "upload_file" {
  provisioner "local-exec" {
  command = <<-EOF
    az storage file upload \
      --source "C:/Users/Computer Store/Downloads/xampp-linux-x64-8.0.30-0-installer.run" \
      --path "mnt/sharedfiles" \
      --share-name "${azurerm_storage_share.file_share.name}" \
      --account-name "${azurerm_storage_account.account_share.name}" \
      --account-key "${azurerm_storage_account.account_share.primary_access_key}"
  EOF
}
}